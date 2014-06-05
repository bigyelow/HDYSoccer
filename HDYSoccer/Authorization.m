//
//  Authorization.m
//  HDYSoccer
//
//  Created by bigyelow on 5/7/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "Authorization.h"

@implementation Authorization

+(JSONKeyMapper*)keyMapper
{
  return [[JSONKeyMapper alloc] initWithDictionary:@{
                                                     @"access_token": @"accessToken",
                                                     @"refresh_token": @"refreshToken",
                                                     @"expire_in": @"expireIn",
                                                     @"user_id": @"userID",
                                                     @"user_name": @"userName"
                                                     }];
}

@end
