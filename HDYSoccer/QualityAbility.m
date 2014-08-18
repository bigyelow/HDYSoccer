//
//  QualityAbility.m
//  HDYSoccer
//
//  Created by bigyelow on 8/15/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "QualityAbility.h"

@implementation QualityAbility
- (NSInteger)respond
{
  NSNumber *number = [self.dictionary objectForKey:@"respond"];
  return number.integerValue;}

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
  NSNumber *number = [self.dictionary objectForKey:@"aggressivity"];
  return number.integerValue;
}
@end
