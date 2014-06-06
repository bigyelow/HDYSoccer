//
//  Location.m
//  HDYSoccer
//
//  Created by bigyelow on 5/7/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "Location.h"

@implementation Location

- (BOOL)locateAllowed
{
  NSNumber *locateAllowed = [self.dictionary objectForKey:@"locate_allowed"];
  return locateAllowed.boolValue;
}

- (NSString *)latitude
{
  return [self.dictionary objectForKey:@"latitude"];
}

- (NSString *)longtitude
{
  return [self.dictionary objectForKey:@"longtitude"];
}

- (NSString *)city
{
  return [self.dictionary objectForKey:@"city"];
}

@end
