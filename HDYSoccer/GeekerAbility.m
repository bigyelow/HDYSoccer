//
//  GeekerAbility.m
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GeekerAbility.h"

@implementation GeekerAbility

- (ComprehensiveAbility *)comprehensiveAbility
{
  if (!_comprehensiveAbility) {
    _comprehensiveAbility = [ComprehensiveAbility
                             objectWithDictionary:[self.dictionary objectForKey:@"comprehensive_ability"]];
  }
  return _comprehensiveAbility;
}

- (SkillAbility *)skillAbility
{
  if (!_skillAbility) {
    _skillAbility = [SkillAbility objectWithDictionary:[self.dictionary objectForKey:@"skill"]];
  }
  return _skillAbility;
}

- (QualityAbility *)qualityAbility
{
  if (!_qualityAbility) {
    _qualityAbility = [QualityAbility objectWithDictionary:[self.dictionary objectForKey:@"quality"]];
  }
  return _qualityAbility;
}
@end
