//
//  HDYSoccerGeekerDetailViewController+NetworkOperation.m
//  HDYSoccer
//
//  Created by bigyelow on 8/13/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerDetailViewController+NetworkOperation.h"
#import "HDYSoccerAPIClient+HTTP.h"
#import "Geeker.h"
#import "GeekerAbility.h"

@implementation HDYSoccerGeekerDetailViewController (NetworkOperation)

- (void)loadPlayerInfoWithPlayerID:(NSString *)playerID
{
  __weak typeof(self) weakSelf = self;
  
  [UIConfiguration showTipMessageToView:self.view title:TEXT_LOADING];
  [self.httpsClient getGeekerInfoWithGeekerID:playerID
                                   succeeded:^(NSDictionary *dictionary) {
                                     [UIConfiguration hideTipMessageOnView:weakSelf.view];
                                     
                                     weakSelf.playerInfo = [Geeker objectWithDictionary:dictionary];
                                     [weakSelf configAbilityArrayWithPlayerInfo:weakSelf.playerInfo];
                                     [weakSelf configAbilityScoreAnimationArray];
                                     [weakSelf.playerInfoTable reloadData];
                                     
                                     [weakSelf.playerInfoTable setHidden:NO];
                                   } failed:^(HDYSoccerAPIError *error) {
                                     [UIConfiguration hideTipMessageOnView:weakSelf.view];

                                   }];
}

- (void)configAbilityScoreAnimationArray
{
  NSMutableArray *array = [NSMutableArray array];
  
  for (int i = 0; i < [self.comprehensiveAbilityArray count]; ++i) {
    [array addObject:[NSNumber numberWithBool:YES]];
  }
  self.compreAbilityScoreAnimationArray = [array mutableCopy];
  [array removeAllObjects];
  
  for (int i = 0; i < [self.skillAbilityArray count]; ++i) {
    [array addObject:[NSNumber numberWithBool:YES]];
  }
  self.skillAbilityScoreAnimationArray = [array mutableCopy];
  [array removeAllObjects];
  
  for (int i = 0; i < [self.qualityAbilityArray count]; ++i) {
    [array addObject:[NSNumber numberWithBool:YES]];
  }
  self.qualityAbilityScoreAnimationArray = [array mutableCopy];
}

- (void)configAbilityArrayWithPlayerInfo:(Geeker *)playerInfo
{
  NSMutableArray *array = [NSMutableArray array];

  // ## attack
  ComprehensiveAbility *compreAbility = playerInfo.ability.comprehensiveAbility;
  NSDictionary *dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:compreAbility.attack]
                                                         forKey:TEXT_ABILITY_ATTACK];
  [array addObject:dictionary];
  
  // defend
  dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:compreAbility.defend]
                                           forKey:TEXT_ABILITY_DEFEND];
  [array addObject:dictionary];
  
  self.comprehensiveAbilityArray = [array copy];
  [array removeAllObjects];
  
  // ## pass
  SkillAbility *skillAbility = playerInfo.ability.skillAbility;
  dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:skillAbility.pass]
                                           forKey:TEXT_ABILITY_PASS];
  [array addObject:dictionary];
  
  // shoot
  dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:skillAbility.shoot]
                                           forKey:TEXT_ABILITY_SHOOT];
  [array addObject:dictionary];
  
  // ballless running
  dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:skillAbility.balllessRunning]
                                           forKey:TEXT_ABILITY_BALLLESS_RUNNING];
  [array addObject:dictionary];
  
  // place kick
  dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:skillAbility.placeKick]
                                           forKey:TEXT_ABILITY_PLACE_KICK];
  [array addObject:dictionary];
  
  // heading
  dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:skillAbility.heading]
                                           forKey:TEXT_ABILITY_HEADING];
  [array addObject:dictionary];
  
  self.skillAbilityArray = [array copy];
  [array removeAllObjects];
  
  // ## team spirit
  QualityAbility *qualityAbility = playerInfo.ability.qualityAbility;
  dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:qualityAbility.teamSpirit]
                                           forKey:TEXT_ABILITY_TEAM_SPIRITY];
  [array addObject:dictionary];
  
  // stamina
  dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:qualityAbility.stamina]
                                           forKey:TEXT_ABILITY_STAMINA];
  [array addObject:dictionary];
  
  // speed
  dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:qualityAbility.speed]
                                           forKey:TEXT_ABILITY_SPEED];
  [array addObject:dictionary];
  
  // strong
  dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:qualityAbility.strong]
                                           forKey:TEXT_ABILITY_STRONG];
  [array addObject:dictionary];
  
  // respond
  dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:qualityAbility.respond]
                                           forKey:TEXT_ABILITY_RESPOND];
  [array addObject:dictionary];
  
  // devotion
  dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:qualityAbility.devotion]
                                           forKey:TEXT_ABILITY_DEVOTION];
  [array addObject:dictionary];
  
  // aggressivity
  dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:qualityAbility.aggressivity]
                                           forKey:TEXT_ABILITY_AGGRESSIVITY];
  [array addObject:dictionary];
  
  // creativity
  dictionary = [NSDictionary dictionaryWithObject:[NSNumber numberWithInteger:qualityAbility.creativity]
                                           forKey:TEXT_ABILITY_CREATIVITY];
  [array addObject:dictionary];
  
  self.qualityAbilityArray = [array copy];
}
@end
