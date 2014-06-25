//
//  GameDetailViewController+TopButtons.m
//  HDYSoccer
//
//  Created by bigyelow on 6/25/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GameDetailViewController+TopButtons.h"

@implementation GameDetailViewController (TopButtons)

- (void)configTopItems
{
  UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:TEXT_ACCOMPLISH
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(confirmItemPressed)];
  
  [self.navigationItem setRightBarButtonItem:confirmItem];
}

- (void)confirmItemPressed
{
  [self dismissViewControllerAnimated:YES completion:nil];
}
@end
