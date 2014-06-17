//
//  CreateGameDetailViewController+UIConfiguration.m
//  HDYSoccer
//
//  Created by bigyelow on 6/16/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CreateGameDetailViewController+UIConfiguration.h"

@implementation CreateGameDetailViewController (UIConfiguration)

#pragma mark - top items
- (void)configTopItems
{
  UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:TEXT_OK
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(confirmItemPressed)];
  
  [self.navigationItem setRightBarButtonItem:confirmItem];
}

- (void)confirmItemPressed
{
  NSLog(@"pressed ok");
}
@end
