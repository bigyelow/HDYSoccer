//
//  ChooseTableViewController+Network.m
//  HDYSoccer
//
//  Created by bigyelow on 8/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ChooseTableViewController+Network.h"
#import "HDYSoccerAPIClient+HTTPS.h"

@implementation ChooseTableViewController (Network)

- (void)loadMyFriends
{
  __weak typeof(self) weakSelf = self;

  [self.httpsClient getMyFriendsSucceeded:^(NSArray *array) {
    if (array) {
      weakSelf.friendsArray = [NSMutableArray arrayWithArray:array];
    }
    
    [weakSelf.tableView reloadData];
  } failed:^(HDYSoccerAPIError *error) {

  }];
}

@end
