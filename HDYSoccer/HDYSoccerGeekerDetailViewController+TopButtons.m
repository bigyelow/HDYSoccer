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
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                        target:self
                                                                        action:@selector(addFriend)];
  [item setTintColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR]];
  [self.navigationItem setRightBarButtonItem:item];
}

- (void)addFriend
{
  PSPDFAlertView *alertView = [[PSPDFAlertView alloc] initWithTitle:[NSString stringWithFormat:TEXT_ADD_SOMEBODY_AS_FRIEND, self.playerName]];
  [alertView setCancelButtonWithTitle:TEXT_CANCEL
                                block:nil];
  [alertView addButtonWithTitle:TEXT_OK block:nil];
  
  [alertView show];
}

@end
