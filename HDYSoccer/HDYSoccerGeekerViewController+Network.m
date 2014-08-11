//
//  HDYSoccerGeekerViewController+Network.m
//  HDYSoccer
//
//  Created by bigyelow on 7/1/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerViewController+Network.h"
#import "HDYSoccerAPIClient+HTTPS.h"
#import "SVPullToRefresh.h"

@implementation HDYSoccerGeekerViewController (Network)

- (void)loadMyFriends
{
  __weak typeof(self) weakSelf = self;
  [self.httpsClient getMyFriendsSucceeded:^(NSArray *array) {
    if (array) {
      weakSelf.geekersArray = [NSMutableArray arrayWithArray:array];
    }
    
    [weakSelf.geekerTable reloadData];
    [weakSelf setGeekersLoadedOnce:YES];
    [weakSelf.geekerTable.pullToRefreshView stopAnimating];
  } failed:^(HDYSoccerAPIError *error) {
    [weakSelf.geekerTable.pullToRefreshView stopAnimating];

  }];
}

- (void)loadMyTeams
{
  __weak typeof(self) weakSelf = self;
  [self.httpsClient getMyTeamsSucceeded:^(NSArray *array) {
    if (array) {
      weakSelf.teamsArray = [NSMutableArray arrayWithArray:array];
    }
    
    [weakSelf.teamTable reloadData];
    [weakSelf setTeamLoadedOnce:YES];
    [weakSelf.teamTable.pullToRefreshView stopAnimating];
  } failed:^(HDYSoccerAPIError *error) {
    [weakSelf.teamTable.pullToRefreshView stopAnimating];

  }];
}
@end
