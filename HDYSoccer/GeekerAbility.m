//
//  GeekerAbility.m
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GeekerAbility.h"

@implementation GeekerAbility

- (NSInteger)teamSpirit
{
  NSNumber *number = [self.dictionary objectForKey:@"team_spirit"];
  return number.integerValue;
}

- (NSInteger)devotion
{
  NSNumber *number = [self.dictionary objectForKey:@"devotion"];
  return number.integerValue;
}

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
  NSNumber *number = [self.dictionary objectForKey:@"place-kick"];
  return number.integerValue;
}

- (NSInteger)creativity
{
  NSNumber *number = [self.dictionary objectForKey:@"creativity"];
  return number.integerValue;
}

- (NSInteger)stamina
{
  NSNumber *number = [self.dictionary objectForKey:@"stamina"];
  return number.integerValue;
}

- (NSInteger)speed
{
  NSNumber *number = [self.dictionary objectForKey:@"speed"];
  return number.integerValue;
}

- (NSInteger)strong
{
  NSNumber *number = [self.dictionary objectForKey:@"strong"];
  return number.integerValue;
}

- (NSInteger)aggressivity
{
  NSNumber *number = [self.dictionary objectForKey:@"agreesivity"];
  return number.integerValue;
}
@end
