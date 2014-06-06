//
//  Authorization.m
//  HDYSoccer
//
//  Created by bigyelow on 5/7/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "Authorization.h"

@implementation Authorization

- (NSString *)accessToken
{
  return [self.dictionary objectForKey:@"access_token"];
}

- (NSString *)refreshToken
{
  return [self.dictionary objectForKey:@"refresh_token"];
}

- (NSString *)expireIn
{
  return [self.dictionary objectForKey:@"expire_in"];
}

- (NSString *)userID
{
  return [self.dictionary objectForKey:@"user_id"];
}

- (NSString *)userName
{
  return [self.dictionary objectForKey:@"user_name"];
}

@end
