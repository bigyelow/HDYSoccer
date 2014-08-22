//
//  AppContextParams.h
//  HDYSoccer
//
//  Created by bigyelow on 5/7/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <Foundation/Foundation.h>

#define APP_NAME @""
#define APP_SCHEME @""

// user defaults keys
#define USER_ID_KEY @"userID"
#define USER_NAME_KEY @"userName"
#define AVATAR_URL_KEY @"avatarURL"
#define IS_LOGIN_KEY @"isLogin"
#define LATITUDE_KEY @"latitude"
#define LONGTITUDE_KEY @"longtitude"
#define CITY_KEY @"city"
#define LOCATE_ALLOWED_KEY @"locateAllowedKey"
#define ACCESS_TOKEN_KEY @"accessToken"
#define REFRESH_TOKEN_KEY @"refreshToken"

#define APP_DELEGATE  ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppContextParams : NSObject

@end
