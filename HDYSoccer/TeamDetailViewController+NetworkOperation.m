//
//  TeamDetailViewController+NetworkOperation.m
//  HDYSoccer
//
//  Created by bigyelow on 8/18/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "TeamDetailViewController+NetworkOperation.h"
#import "HDYSoccerAPIClient+HTTP.h"
#import "Team.h"

@implementation TeamDetailViewController (NetworkOperation)

- (void)loadTeamInfoWithTeamID:(NSString *)teamID
{
  __weak typeof(self) weakSelf = self;
  [UIConfiguration showTipMessageToView:self.view title:TEXT_LOADING];
  [self.httpsClient getTeamInfoWithTemaID:teamID
                                succeeded:^(NSDictionary *dictionary) {
                                  [UIConfiguration hideTipMessageOnView:self.view];
                                  
                                  weakSelf.teamInfo = [Team objectWithDictionary:dictionary];
                                  [weakSelf configParamsWithTeamdInfo:weakSelf.teamInfo];
                                  [weakSelf.teamInfoTable reloadData];
                                } failed:^(HDYSoccerAPIError *error) {
                                  [UIConfiguration hideTipMessageOnView:self.view];

                                }];
}

- (void)configParamsWithTeamdInfo:(Team *)teamInfo
{
  // SCORE ANIMATION
  NSMutableArray *array = [NSMutableArray arrayWithCapacity:SCORE_TYPE_NUMBER];
  for (int i = 0; i < SCORE_TYPE_NUMBER; ++i) {
    [array addObject:[NSNumber numberWithBool:YES]];
  }
  
  self.scoreAnimationArray = [array mutableCopy];
  
  // SCORE DIC
  [array removeAllObjects];
  NSDictionary *dic = [NSDictionary dictionaryWithObject:teamInfo.teamScore.attack forKey:TEXT_ATTACK];
  [array addObject:dic];
  
  dic = [NSDictionary dictionaryWithObject:teamInfo.teamScore.defend forKey:TEXT_DEFENTD];
  [array addObject:dic];
  
  dic = [NSDictionary dictionaryWithObject:teamInfo.teamScore.coorperation forKey:TEXT_COORPERATION];
  [array addObject:dic];
  
  dic = [NSDictionary dictionaryWithObject:teamInfo.teamScore.skill forKey:TEXT_SKILL];
  [array addObject:dic];
  
  dic = [NSDictionary dictionaryWithObject:teamInfo.teamScore.speed forKey:TEXT_SPEED];
  [array addObject:dic];
  
  dic = [NSDictionary dictionaryWithObject:teamInfo.teamScore.physicalStrength forKey:TEXT_PHYSICAL_STRENGTH];
  [array addObject:dic];

  self.scoreArray = [array copy];
}
@end
