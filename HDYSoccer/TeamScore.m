//
//  TeamScore.m
//  HDYSoccer
//
//  Created by bigyelow on 6/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "TeamScore.h"

@implementation TeamScore

- (NSString *)attack
{
  return [self.dictionary objectForKey:@"attack"];
}

- (NSString *)defend
{
  return [self.dictionary objectForKey:@"defend"];
}

- (NSString *)coorperation
{
  return [self.dictionary objectForKey:@"coorperation"];
}

- (NSString *)skill
{
  return [self.dictionary objectForKey:@"skill"];
}

- (NSString *)speed
{
  return [self.dictionary objectForKey:@"speed"];
}

- (NSString *)physicalStrength
{
  return [self.dictionary objectForKey:@"physical_strength"];
}
@end
