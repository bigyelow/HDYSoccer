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
  // location
  NSString *latitude = [defaults objectForKey:LATITUDE_KEY];
  NSString *longtitude = [defaults objectForKey:LONGTITUDE_KEY];
  NSString *city = [defaults objectForKey:CITY_KEY];
  
  NSArray *objects = @[latitude, longtitude, city];
  NSArray *keys = @[@"latitude", @"longtitude", @"city"];
  NSDictionary *dic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
  
  self.location = [Location objectWithDictionary:dic];
  
  // auth
  self.isLogin = [[defaults objectForKey:IS_LOGIN_KEY] boolValue];

  if (self.isLogin) {
    NSString *accessToken = [defaults objectForKey:ACCESS_TOKEN_KEY];
    NSString *refreshToken= [defaults objectForKey:REFRESH_TOKEN_KEY];
    NSString *userID = [defaults objectForKey:USER_ID_KEY];
    NSString *userName = [defaults objectForKey:USER_NAME_KEY];
    NSString *avatarURL = [defaults objectForKey:AVATAR_URL_KEY];
    
    NSArray *objects = @[accessToken, refreshToken, userID, userName, avatarURL];
    NSArray *keys = @[@"acccess_token", @"refresh_token", @"user_id", @"user_name", @"avatar_url"];
    NSDictionary *dic = [NSDictionary dictionaryWithObjects:objects forKeys:keys];
    self.auth = [Authorization objectWithDictionary:dic];
  }
  
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
  
  // location
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
  
  // is login
  [defaults setObject:[NSNumber numberWithBool:self.isLogin] forKey:IS_LOGIN_KEY];
  
  // auth
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
  
  if (self.auth.userID) {
    [defaults setObject:self.auth.userID forKey:USER_ID_KEY];
  }
  else {
    [defaults removeObjectForKey:USER_ID_KEY];
  }
  
  if (self.auth.userName) {
    [defaults setObject:self.auth.userName forKey:USER_NAME_KEY];
  }
  else {
    [defaults removeObjectForKey:USER_NAME_KEY];
  }
  
  if (self.auth.avatarURL) {
    [defaults setObject:self.auth.avatarURL forKey:AVATAR_URL_KEY];
  }
  else {
    [defaults removeObjectForKey:AVATAR_URL_KEY];
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
