//
//  ChooseTableViewController+Network.m
//  HDYSoccer
//
//  Created by bigyelow on 8/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ChooseTableViewController+Network.h"
#import "HDYSoccerAPIClient+HTTPS.h"
#import "SimpleGeekerInfo.h"
#import "SimpleTeamInfo.h"

@implementation ChooseTableViewController (Network)

- (void)loadMyFriends
{
  __weak typeof(self) weakSelf = self;

  [UIConfiguration showTipMessageToView:self.tableView];
  [self.httpsClient getMyFriendsSucceeded:^(NSArray *array) {
    [UIConfiguration hideTipMessageOnView:weakSelf.tableView];
    
    weakSelf.friendsArray = [array copy];
    [weakSelf configSelectedArray];
    
    [weakSelf.tableView reloadData];
    
  } failed:^(HDYSoccerAPIError *error) {
    [UIConfiguration hideTipMessageOnView:weakSelf.tableView];

  }];
}

- (void)loadMyTeams
{
  __weak typeof(self) weakSelf = self;
  
  [UIConfiguration showTipMessageToView:self.tableView];
  [self.httpsClient getMyTeamsSucceeded:^(NSArray *array) {
    [UIConfiguration hideTipMessageOnView:weakSelf.tableView];
    
    weakSelf.teamsArray = [array copy];
    [weakSelf configSelectedArray];
    
    [weakSelf.tableView reloadData];
    
  } failed:^(HDYSoccerAPIError *error) {
    [UIConfiguration hideTipMessageOnView:weakSelf.tableView];
    
  }];
}

// selectedArray = [[avatarURL, name, selected],...]
- (void)configSelectedArray
{
  self.selectedArray = [NSMutableArray array];
  
  if (self.type == kChooseTableTypeFriend) {
    for (SimpleGeekerInfo *info in self.friendsArray) {
      NSString *avatarURL = info.avatarURL;
      NSString *name = info.name;
      NSNumber *selected = [NSNumber numberWithBool:NO];
      NSMutableArray *array = [NSMutableArray arrayWithArray:@[avatarURL, name, selected]];
      
      [self.selectedArray addObject:array];
    }
  }
  else if (self.type == kChooseTableTypeTeam) {
    for (SimpleTeamInfo *info in self.teamsArray) {
      NSString *avatarURL = info.teamAvatarURL;
      NSString *name = info.teamName;
      NSNumber *selected = [NSNumber numberWithBool:NO];
      NSMutableArray *array = [NSMutableArray arrayWithArray:@[avatarURL, name, selected]];
      
      [self.selectedArray addObject:array];
    }
  }
}
@end
