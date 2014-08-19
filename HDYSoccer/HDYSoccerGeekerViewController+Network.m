//
//  HDYSoccerGeekerViewController+Network.m
//  HDYSoccer
//
//  Created by bigyelow on 7/1/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerViewController+Network.h"
#import "HDYSoccerAPIClient+HTTPS.h"

@implementation HDYSoccerGeekerViewController (Network)

- (void)loadMyFriends
{
  __weak typeof(self) weakSelf = self;
  
  if (self.geekersLoadedOnce == NO) {
    [UIConfiguration showTipMessageToView:self.geekerTable title:TEXT_LOADING];
  }
  [self.httpsClient getMyFriendsSucceeded:^(NSArray *array) {
    [UIConfiguration hideTipMessageOnView:weakSelf.geekerTable];
    [weakSelf.playerRefreshControl endRefreshing];

    if (array) {
      weakSelf.geekersArray = [NSMutableArray arrayWithArray:array];
    }
    
    [weakSelf.geekerTable reloadData];
    [weakSelf setGeekersLoadedOnce:YES];
  } failed:^(HDYSoccerAPIError *error) {
    [UIConfiguration hideTipMessageOnView:weakSelf.geekerTable];
    [weakSelf.playerRefreshControl endRefreshing];
  }];
}

- (void)loadMyTeams
{
  __weak typeof(self) weakSelf = self;
  
  if (self.teamLoadedOnce == NO) {
    [UIConfiguration showTipMessageToView:self.teamTable title:TEXT_LOADING];
  }
  [self.httpsClient getMyTeamsSucceeded:^(NSArray *array) {
    [UIConfiguration hideTipMessageOnView:weakSelf.teamTable];
    [weakSelf.teamRefreshControl endRefreshing];
    
    if (array) {
      weakSelf.teamsArray = [NSMutableArray arrayWithArray:array];
    }
    
    [weakSelf.teamTable reloadData];
    [weakSelf setTeamLoadedOnce:YES];

  } failed:^(HDYSoccerAPIError *error) {
    [UIConfiguration hideTipMessageOnView:weakSelf.teamTable];
    [weakSelf.teamRefreshControl endRefreshing];

  }];
}
@end
