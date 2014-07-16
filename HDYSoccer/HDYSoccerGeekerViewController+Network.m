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
  [UIConfiguration showTipMessageToView:self.view];
  [self.httpsClient getMyFriendsSucceeded:^(NSArray *array) {
    [UIConfiguration hideTipMessageOnView:weakSelf.view];
    
    if (array) {
      weakSelf.geekersArray = [NSMutableArray arrayWithArray:array];
    }
    
    [weakSelf.geekerTable reloadData];
    [weakSelf setGeekersLoadedOnce:YES];
    [weakSelf.geekerTable setHidden:NO];
  } failed:^(HDYSoccerAPIError *error) {
    [UIConfiguration hideTipMessageOnView:weakSelf.view];

  }];
}
@end
