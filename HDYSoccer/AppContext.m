//
//  AppContext.m
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "AppContext.h"
#import "AppContextParams.h"

@implementation AppContext
{
//  NSUserDefaults *_userDefaults;
}

static AppContext *sharedInstance = nil;

+ (void)initialize
{
  if (sharedInstance == nil) {
    sharedInstance = [[self alloc] init];
    [sharedInstance initAppContextFromUserDefaults:[NSUserDefaults standardUserDefaults]];
  }
}

+ (AppContext *)appContext {
  [AppContext initialize];
  return sharedInstance;
}


- (void)initAppContextFromUserDefaults:(NSUserDefaults *)defaults
{
//  _userDefaults = defaults;

  self.isLogin = [[defaults objectForKey:IS_LOGIN_KEY] boolValue];
  self.location.latitude = [defaults objectForKey:LATITUDE_KEY];
  self.location.longtitude = [defaults objectForKey:LONGTITUDE_KEY];
  self.auth.accessToken = [defaults objectForKey:ACCESS_TOKEN_KEY];
  self.auth.refreshToken= [defaults objectForKey:REFRESH_TOKEN_KEY];
  self.auth.userID = [defaults objectForKey:USER_ID_KEY];
  
//  self.cachedXAuthTokenString = [defaults objectForKey:kCachedXAuthAccessTokenKey];
//  self.storeUrl = [defaults objectForKey:kStoreUrl];
//  self.deviceToken = [defaults objectForKey:kDeviceTokenKey];
//  id canPushValue = [defaults objectForKey:kCanPushKey];
//  if (canPushValue == nil) {
//    self.canPush = YES;
//    [self synchronize];
//  } else {
//    self.canPush = [defaults boolForKey:kCanPushKey];
//  }
}

- (void)updateInfoWithAuth:(Authorization *)auth
{
  self.auth = auth;
  self.isLogin = YES;
  [self synchronize];
}

- (void)clearInfo
{
  self.auth = nil;
  self.isLogin = NO;
  [self synchronize];
}

- (void)synchronize
{
  NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
  
  [defaults setObject:[NSNumber numberWithBool:self.isLogin] forKey:IS_LOGIN_KEY];
  
  if (self.location.latitude) {
    [defaults setObject:self.location.latitude forKey:LATITUDE_KEY];
  }
  else {
    [defaults removeObjectForKey:LATITUDE_KEY];
  }
  
  if (self.location.longtitude) {
    [defaults setObject:self.location.longtitude forKey:LONGTITUDE_KEY];
  }
  else {
    [defaults removeObjectForKey:LONGTITUDE_KEY];
  }
  
  if (self.location.city) {
    [defaults setObject:self.location.city forKey:CITY_KEY];
  }
  else {
    [defaults removeObjectForKey:CITY_KEY];
  }
  
  if (self.auth.accessToken) {
    [defaults setObject:self.auth.accessToken forKey:ACCESS_TOKEN_KEY];
  }
  else {
    [defaults removeObjectForKey:ACCESS_TOKEN_KEY];
  }
  
  if (self.auth.refreshToken) {
    [defaults setObject:self.auth.refreshToken forKey:REFRESH_TOKEN_KEY];
  }
  else {
    [defaults removeObjectForKey:REFRESH_TOKEN_KEY];
  }
  
  
  [defaults synchronize];
}

#pragma mark - getter methods
- (Location *)location
{
  if (!_location) {
    _location = [[Location alloc] init];
  }
  
  return _location;
}

- (Authorization *)auth
{
  if (!_auth) {
    _auth = [[Authorization alloc] init];
  }
  
  return _auth;
}

@end
