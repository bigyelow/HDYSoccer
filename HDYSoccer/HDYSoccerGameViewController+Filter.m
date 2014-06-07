//
//  HDYSoccerGameViewController+Filter.m
//  HDYSoccer
//
//  Created by bigyelow on 6/7/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameViewController+Filter.h"

#define FILTER_BUTTON_TITLE @"筛选"

@implementation HDYSoccerGameViewController (Filter)


- (void)configTopFilterButton
{
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:FILTER_BUTTON_TITLE
                                                           style:UIBarButtonItemStyleBordered
                                                          target:self
                                                          action:@selector(filterButtonPressed)];
  self.filterItem = item;
  [self.navigationItem setLeftBarButtonItem:item];
}

- (void)filterButtonPressed
{
  UIViewController *tempCtr = [[UIViewController alloc] init];
  [tempCtr setTitle:FILTER_BUTTON_TITLE];
  [tempCtr.view setBackgroundColor:[UIColor lightGrayColor]];
  
  [self presentViewController:tempCtr
                     animated:YES
                   completion:nil];
}
@end
