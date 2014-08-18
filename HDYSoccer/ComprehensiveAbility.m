//
//  ComprehensiveAbility.m
//  HDYSoccer
//
//  Created by bigyelow on 8/15/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ComprehensiveAbility.h"

@implementation ComprehensiveAbility
- (NSInteger)attack
{
  NSNumber *number = [self.dictionary objectForKey:@"attack"];
  return number.integerValue;
}

- (NSInteger)defend
{
  NSNumber *number = [self.dictionary objectForKey:@"defend"];
  return number.integerValue;
}
@end
