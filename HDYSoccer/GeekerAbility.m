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

+ (PlayerAbility)abilityTypeFromAbilityName:(NSString *)name
{
  if ([name isEqualToString:TEXT_ABILITY_TEAM_SPIRITY]) {
    return kPlayerAbilityTeamSpirit;
  }
  else if ([name isEqualToString:TEXT_ABILITY_STRONG]) {
    return kPlayerAbilityStrong;
  }
  else if ([name isEqualToString:TEXT_ABILITY_STAMINA]) {
    return kPlayerAbilityStamina;
  }
  else if ([name isEqualToString:TEXT_ABILITY_SPEED]) {
    return kPlayerAbilitySpeed;
  }
  else if ([name isEqualToString:TEXT_ABILITY_SHOOT]) {
    return kPlayerAbilityShoot;
  }
  else if ([name isEqualToString:TEXT_ABILITY_RESPOND]) {
    return kPlayerAbilityRespond;
  }
  else if ([name isEqualToString:TEXT_ABILITY_PLACE_KICK]) {
    return kPlayerAbilityPlaceKick;
  }
  else if ([name isEqualToString:TEXT_ABILITY_PASS]) {
    return kPlayerAbilityPass;
  }
  else if ([name isEqualToString:TEXT_ABILITY_HEADING]) {
    return kPlayerAbilityHeading;
  }
  else if ([name isEqualToString:TEXT_ABILITY_DEVOTION]) {
    return kPlayerAbilityDevotion;
  }
  else if ([name isEqualToString:TEXT_ABILITY_DEFEND]) {
    return kPlayerAbilityDefend;
  }
  else if ([name isEqualToString:TEXT_ABILITY_CREATIVITY]) {
    return kPlayerAbilityCreativity;
  }
  else if ([name isEqualToString:TEXT_ABILITY_BALLLESS_RUNNING]) {
    return kPlayerAbilityBalllessRunning;
  }
  else if ([name isEqualToString:TEXT_ABILITY_ATTACK]) {
    return kPlayerAbilityAttack;
  }
  else if ([name isEqualToString:TEXT_ABILITY_AGGRESSIVITY]) {
    return kPlayerAbilityAggressivity;
  }
  
  return 0;
}

+ (NSString *)abilityStringFromAbility:(PlayerAbility)ability
{
  switch (ability) {
    case kPlayerAbilityAggressivity:
      return @"aggressivity";
      
    case kPlayerAbilityAttack:
      return @"attack";
      
    case kPlayerAbilityBalllessRunning:
      return @"ballless_running";
      
    case kPlayerAbilityCreativity:
      return @"creativity";
      
    case kPlayerAbilityDefend:
      return @"defend";
      
    case kPlayerAbilityDevotion:
      return @"devotion";
      
    case kPlayerAbilityHeading:
      return @"heading";
      
    case kPlayerAbilityPass:
      return @"pass";
      
    case kPlayerAbilityPlaceKick:
      return @"place_kick";
      
    case kPlayerAbilityRespond:
      return @"respond";
      
    case kPlayerAbilityShoot:
      return @"shoot";
      
    case kPlayerAbilitySpeed:
      return @"speed";
      
    case kPlayerAbilityStamina:
      return @"stamina";
      
    case kPlayerAbilityStrong:
      return @"strong";
      
    case kPlayerAbilityTeamSpirit:
      return @"team_spirit";
      
    default:
      break;
  }
}
@end
