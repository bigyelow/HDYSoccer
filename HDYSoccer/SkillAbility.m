//
//  SkillAbility.m
//  HDYSoccer
//
//  Created by bigyelow on 8/15/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "SkillAbility.h"

@implementation SkillAbility
- (NSInteger)balllessRunning
{
  NSNumber *number = [self.dictionary objectForKey:@"ballless_running"];
  return number.integerValue;
}

- (NSInteger)shoot
{
  NSNumber *number = [self.dictionary objectForKey:@"shoot"];
  return number.integerValue;
}

- (NSInteger)pass
{
  NSNumber *number = [self.dictionary objectForKey:@"pass"];
  return number.integerValue;
}

- (NSInteger)heading
{
  NSNumber *number = [self.dictionary objectForKey:@"heading"];
  return number.integerValue;
}

- (NSInteger)placeKick
{
  NSNumber *number = [self.dictionary objectForKey:@"place_kick"];
  return number.integerValue;
}
@end
