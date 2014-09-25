//
//  GeekerAbility.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "BaseObject.h"
#import "ComprehensiveAbility.h"
#import "SkillAbility.h"
#import "QualityAbility.h"

typedef NS_ENUM(NSUInteger, PlayerAbility) {
  kPlayerAbilityAttack,
  kPlayerAbilityDefend,
  kPlayerAbilityPass,
  kPlayerAbilityShoot,
  kPlayerAbilityBalllessRunning,
  kPlayerAbilityPlaceKick,
  kPlayerAbilityHeading,
  kPlayerAbilityRespond,
  kPlayerAbilityTeamSpirit,
  kPlayerAbilityDevotion,
  kPlayerAbilityCreativity,
  kPlayerAbilityStamina,
  kPlayerAbilitySpeed,
  kPlayerAbilityStrong,
  kPlayerAbilityAggressivity
};

@interface GeekerAbility : BaseObject

@property (nonatomic, strong) ComprehensiveAbility *comprehensiveAbility;
@property (nonatomic, strong) SkillAbility *skillAbility;
@property (nonatomic, strong) QualityAbility *qualityAbility;

+ (NSString *)abilityStringFromAbility:(PlayerAbility)ability;
+ (PlayerAbility)abilityTypeFromAbilityName:(NSString *)name;
@end
