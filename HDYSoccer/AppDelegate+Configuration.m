//
//  AppDelegate+Configuration.m
//  HDYSoccer
//
//  Created by bigyelow on 5/7/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "AppDelegate+Configuration.h"
#import "HDYSoccerAPIClient+HTTP.h"
#import "HDYSoccerMenuViewController.h"

@implementation AppDelegate (Configuration)

- (void)configStandardsDefaults
{
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  [userDefaults setObject: [NSArray arrayWithObjects:@"zh-Hans", nil] forKey:@"AppleLanguages"];
  [userDefaults synchronize];
  [userDefaults setBool:NO forKey:@"isEndGoogleRequest"];//多语言环境支持,读取google数据
}

#pragma mark - login
+ (void)showLoginWithDelegate:(id<RegisterAndLoginDelegate>)delegate
{
  RegisterAndLoginViewController *vc = [[RegisterAndLoginViewController alloc] initWithDelegate:delegate];
  if ([delegate isKindOfClass:[HDYSoccerBaseViewController class]]) {
    HDYSoccerBaseViewController *baseVC = (HDYSoccerBaseViewController *)delegate;
    [baseVC presentViewController:vc animated:YES completion:nil];
  }
}

#pragma mark - network indicator

- (void)showNetworkActivityIndicator
{
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:YES];
}

- (void)hideNetworkActivityIndicator
{
  [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
}

#pragma mark - some data need
- (void)configNeedData
{
  HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];
  [client getTagsSucceeded:^(NSArray *array) {
    NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
    [userDefaults setObject:array forKey:DEFAULTS_TAGS_KEY];
  } failed:^(HDYSoccerAPIError *error) {
    
  }];
}

#pragma mark - location
- (void)configLocation
{
  if (_m_locManager == nil) {
    _m_locManager = [[CLLocationManager alloc] init];
    [_m_locManager setDelegate:self];
    [_m_locManager setDesiredAccuracy:kCLLocationAccuracyBest];
  }
  [self startLocatingWithCallBack:nil];
}

- (void)startLocatingWithCallBack:(id<LocateCallBack>)callback
{
  if (self.callbacks == nil) {
    self.callbacks = [NSMutableArray array];
  }
  if (callback != nil) {
    [self.callbacks addObject:callback];
  }
  if (_m_locManager) {
    [_m_locManager stopUpdatingLocation];
  }
  if (![CLLocationManager locationServicesEnabled]) {
    [self callCallBacksAndClear];
  } else {
    _locationCounts = 0;
    [_m_locManager startUpdatingLocation];
  }
}

#pragma mark - LocationDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
  DebugLog(@"locationManager error:%@",[NSString stringWithFormat:@"%@",error]);
  [self callCallBacksAndClear];
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
  NSDate *eventDate = newLocation.timestamp;
  NSTimeInterval howRecent = [eventDate timeIntervalSinceNow];

  BOOL isCached = NO;
  if (fabs(howRecent) > 1) {  // 如果大于1s,很有可能是缓存的位置.
    isCached = YES;
  }
  else {
    _locationCounts++;
    isCached = NO;
  }
  
  CLLocationCoordinate2D location = [newLocation coordinate];
  if (!CLLocationCoordinate2DIsValid(location)) {
    return;
  }
  NSString *latitude =[NSString stringWithFormat:@"%f",location.latitude];//纬度
  NSString *longtitude =[NSString stringWithFormat:@"%f",location.longitude];//经度
  
  NSArray *objects = @[latitude, longtitude, [NSNumber numberWithBool:YES]];
  NSArray *keys = @[@"latitude", @"longtitude", @"locate_allowed"];
  NSDictionary *dic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
  [AppContext appContext].location = [Location objectWithDictionary:dic];
  
  if (_locationCounts > MAX_LOCATED_LIMIT) {
    [manager stopUpdatingLocation];
    _locationCounts = 0;
    [[AppContext appContext] synchronize];
  }
  if (!isCached) {
    [[AppContext appContext] synchronize];
    
    _geoCoder = [[CLGeocoder alloc] init];
    [_geoCoder reverseGeocodeLocation:newLocation
                    completionHandler:^(NSArray *placemarks, NSError *error) {
                      if (error == nil) {
                        [self findPlacemarkSucceeded:placemarks];
                      }
                      else {
                        [self findPlacemarkFailed:error];
                      }
                    }];
  }
}

- (void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status{
  
}

- (void)locationManager:(CLLocationManager *)manager
monitoringDidFailForRegion:(CLRegion *)region
              withError:(NSError *)error{
  
}

- (void)callCallBacks{
  for (id callback in self.callbacks) {
    if (callback && [callback respondsToSelector:@selector(refreshData)]) {
      [callback performSelector:@selector(refreshData)];
    }
  }
}

- (void)callCallBacksAndClear{
  [self callCallBacks];
  [self.callbacks removeAllObjects];
}

#pragma mark - handle find placemarks
- (void)findPlacemarkSucceeded:(NSArray *)placemarksArray
{
  if (placemarksArray && [placemarksArray count]) {
    CLPlacemark *placemark = (CLPlacemark *)[placemarksArray objectAtIndex:0];
    
    NSString *city;
    if (placemark.locality) { // 直辖市locality = null
      city = placemark.locality;
    }
    else if (placemark.addressDictionary) {
      city = [placemark.addressDictionary objectForKey:@"City"];
      if (!city) {  // 直辖市只有State
        city = [placemark.addressDictionary objectForKey:@"State"];
      }
    }
    
    if (city) {
      NSString *lastWord = [city substringFromIndex:city.length - 1];
      if ([lastWord isEqualToString:TEXT_CITY]) {
        city = [city substringToIndex:city.length - 1];
      }

      NSMutableDictionary *dic = [[AppContext appContext].location.dictionary mutableCopy];
      [dic setObject:city forKey:@"city"];
      [AppContext appContext].location = [Location objectWithDictionary:dic];
      
      [[AppContext appContext] synchronize];
      [_m_locManager stopUpdatingLocation];
    }
    
    [self callCallBacksAndClear];
  }
  else {
    DebugLog(@"placemarks array count = 0\n");
  }
}

- (void)findPlacemarkFailed:(NSError *)error
{
  DebugLog(@"%@", error);
  [_geoCoder cancelGeocode];
  _geoCoder = nil;
}

@end
