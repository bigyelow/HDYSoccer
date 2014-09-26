//
//  HDYSoccerGeekerDetailViewController+TopButtons.m
//  HDYSoccer
//
//  Created by bigyelow on 9/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerDetailViewController+TopButtons.h"
#import "PSPDFAlertView.h"

#import "HDYSoccerAPIClient+HTTPS.h"

@implementation HDYSoccerGeekerDetailViewController (TopButtons)

- (void)configTopAddButton
{
  UIButton *button = [self topButtonWithImageName:TOP_ADD_IMAGE];
  [button addTarget:self action:@selector(addFriend) forControlEvents:UIControlEventTouchUpInside];
  
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
  [self.navigationItem setRightBarButtonItem:item];
}

- (void)addFriend
{
  PSPDFAlertView *alertView = [[PSPDFAlertView alloc] initWithTitle:[NSString stringWithFormat:TEXT_ADD_SOMEBODY_AS_FRIEND, self.playerName]];
  [alertView setCancelButtonWithTitle:TEXT_CANCEL
                                block:nil];
  
#warning config add friend ok event (need push notification)
  __weak typeof(self) weakSelf = self;
  [alertView addButtonWithTitle:TEXT_OK block:^(NSInteger buttonIndex) {
    
    [UIConfiguration showTipMessageToView:weakSelf.view];
    [weakSelf.httpsClient addFriend:weakSelf.playerID
                          succeeded:^(NSDictionary *dictionary) {
                            [UIConfiguration hideTipMessageOnView:weakSelf.view];
                            
                            [UIConfiguration showTipMessageToView:weakSelf.view
                                                            title:TEXT_ADD_FRIEND_REQUESTED
                                                   hideAfterDelay:TIP_MESSAGE_HIDE_DELAY];
                            
                          } failed:^(HDYSoccerAPIError *error) {
                            [UIConfiguration hideTipMessageOnView:weakSelf.view];

                          }];
  }];
  
  [alertView show];
}

- (void)configTopEditButton
{
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:TEXT_EDIT
                                                           style:UIBarButtonItemStyleDone
                                                          target:self
                                                          action:@selector(edit)];
  [self.navigationItem setRightBarButtonItem:item];
}

- (void)edit
{
  // is self
  BOOL isSelf = [Tools isSelfUser:self.playerID];
  if (isSelf) {
#warning config self edit operation
  }
#warning config delete friend event (need push notification)
  else {  // is friend
    PSPDFAlertView *alertView = [[PSPDFAlertView alloc] initWithTitle:[NSString stringWithFormat:TEXT_DELETE_FRIEND, self.playerName]];
    [alertView setCancelButtonWithTitle:TEXT_OK
                                  block:^(NSInteger buttonIndex) {
                                    __weak typeof(self) weakSelf = self;
                                    [UIConfiguration showTipMessageToView:weakSelf.view];
                                    [weakSelf.httpsClient deleteFriend:weakSelf.playerID
                                                             succeeded:^(NSDictionary *dictionary) {
                                                               [UIConfiguration hideTipMessageOnView:weakSelf.view];
                                                               
                                                               [weakSelf.navigationController popViewControllerAnimated:YES];
                                                               
                                                               if (weakSelf.editPlayerDelegate &&
                                                                   [weakSelf.editPlayerDelegate respondsToSelector:@selector(deleteFriendSucceeded)]) {
                                                                 [weakSelf.editPlayerDelegate deleteFriendSucceeded];
                                                               }
                                                             } failed:^(HDYSoccerAPIError *error) {
                                                               [UIConfiguration hideTipMessageOnView:weakSelf.view];
                                                               
                                                             }];
                                  }];
    [alertView addButtonWithTitle:TEXT_CANCEL block:nil];
    
    [alertView show];
  }
}

#pragma makr - network
@end
