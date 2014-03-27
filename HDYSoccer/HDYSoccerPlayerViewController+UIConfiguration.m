//
//  HDYSoccerPlayerViewController+UIConfiguration.m
//  HDYSoccer
//
//  Created by bigyelow on 3/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerPlayerViewController+UIConfiguration.h"
#import "PlayerViewParams.h"
#import "HDYSoccerBaseTableViewController.h"

@implementation HDYSoccerPlayerViewController (UIConfiguration)

- (void)configSegmentView
{
  CGRect segmentRect = CGRectMake(0, 0, self.view.bounds.size.width, SEGMENT_VIEW_HEIGHT);
  UIView *segmentView = [[UIView alloc] initWithFrame:segmentRect];
  
  self.segControl = [[UISegmentedControl alloc] initWithItems:@[SEGMENT_ITEM_FRIENDS, SEGMENT_ITEM_SUPERIOR, SEGMENT_ITEM_TEAM]];
  [segmentView addSubview:self.segControl];
  
//  CGRect tableRect = self.tableView.frame;
//  tableRect.origin.y += SEGMENT_VIEW_HEIGHT;
//  tableRect.size.height -= SEGMENT_VIEW_HEIGHT;
//  self.tableView.frame = tableRect;
  
  [self.view addSubview:segmentView];
}

@end
