//
//  HDYSoccerGameViewController+Filter.m
//  HDYSoccer
//
//  Created by bigyelow on 6/7/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameViewController+Filter.h"
#import "HDYSoccerGameViewController+CollectionView.h"
#import "HDYSoccerNavigationController.h"
#import "SVPullToRefresh.h"

#define FILTER_BUTTON_TITLE @"筛选"

@implementation HDYSoccerGameViewController (Filter)


- (void)configTopFilterButton
{
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:FILTER_BUTTON_TITLE
                                                           style:UIBarButtonItemStyleDone
                                                          target:self
                                                          action:@selector(filterButtonPressed)];
  self.filterItem = item;
  [self.navigationItem setLeftBarButtonItem:item];
}

- (void)filterButtonPressed
{
  GameListFilterViewController *filterCtr = [[GameListFilterViewController alloc]
                                             initWithStyle:UITableViewStylePlain];
  [filterCtr setReloadGameListDelegate:self];
  HDYSoccerNavigationController *filterNav = [[HDYSoccerNavigationController alloc]
                                              initWithRootViewController:filterCtr];
  
  [self presentViewController:filterNav animated:YES completion:nil];
}

- (void)reloadGameListWithParams:(NSDictionary *)params
{
  NSDate *date = [params objectForKey:PARAM_DATE];
  NSString *field = [params objectForKey:PARAM_FIELD];
  
  // update filter params
  NSInteger index = self.segControl.selectedSegmentIndex;
  if (date) {
    [self setfilterParam:index date:date];
  }
  if (field) {
    [self setfilterParam:index field:field];
  }
  
  UICollectionView *collectionView = self.collectionViewArray[index];
  [collectionView triggerPullToRefresh];
}
@end
