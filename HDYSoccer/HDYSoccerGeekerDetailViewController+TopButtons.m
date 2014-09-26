//
//  HDYSoccerGeekerDetailViewController+TopButtons.m
//  HDYSoccer
//
//  Created by bigyelow on 9/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerDetailViewController+TopButtons.h"
#import "PSPDFAlertView.h"

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
  
#warning config add friend ok event
  [alertView addButtonWithTitle:TEXT_OK block:nil];
  
  [alertView show];
}

@end
