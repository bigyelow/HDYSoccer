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
                                  [weakSelf.teamInfoTable reloadData];
                                } failed:^(HDYSoccerAPIError *error) {
                                  [UIConfiguration hideTipMessageOnView:self.view];

                                }];
}
@end
