//
//  TeamDetailViewController+SegmentControl.m
//  HDYSoccer
//
//  Created by bigyelow on 8/18/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "TeamDetailViewController+SegmentControl.h"
#import "SegmentView.h"

// SEGMENT
#define SEGMENT_TITLE_TEAM_INFO @"球队信息"
#define SEGMENT_TITLE_HISTORY @"历史战绩"

@implementation TeamDetailViewController (SegmentControl)

- (void)configSegmentView
{
  // update tableview frame
  [self.tableView removeFromSuperview];
  
  CGFloat tableHeight = self.view.frame.size.height;
  CGFloat tableWidth = self.view.frame.size.width;
  CGRect tableRect = CGRectMake(0, 0, tableWidth, tableHeight);
  
  // team info table
  self.teamInfoTable = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
  [self customTableView:self.teamInfoTable];
  [self.teamInfoTable setContentInset:UIEdgeInsetsMake(SEGMENT_VIEW_HEIGHT, 0, 0, 0)];
  [self.teamInfoTable setScrollIndicatorInsets:self.teamInfoTable.contentInset];
  
  [self.view addSubview:self.teamInfoTable];
  
  // team administration
  self.administrateTable = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
  [self customTableView:self.administrateTable];
  [self.administrateTable setContentInset:UIEdgeInsetsMake(SEGMENT_VIEW_HEIGHT + TOP_BAR_HEIGHT, 0, 0, 0)];
  [self.administrateTable setScrollIndicatorInsets:self.administrateTable.contentInset];
  
  [self.view addSubview:self.administrateTable];
  
  
  // segment view
  NSArray *segments = @[SEGMENT_TITLE_TEAM_INFO, SEGMENT_TITLE_HISTORY];
  CGRect segmentRect = CGRectMake(0, TOP_BAR_HEIGHT, CGRectGetWidth(self.view.frame), SEGMENT_VIEW_HEIGHT);
  SegmentView *segmentView = [[SegmentView alloc] initWithFrame:segmentRect segments:segments];
  
  [self.view addSubview:segmentView];
  
  // send control
  self.segControl = segmentView.segControl;
  [self.segControl addTarget:self
                      action:@selector(segmentChanged:)
            forControlEvents:UIControlEventValueChanged];
  
  [self.segControl setSelectedSegmentIndex:0];
  [self.segControl sendActionsForControlEvents:UIControlEventValueChanged];
  [self.teamInfoTable setHidden:YES];
}

- (void)customTableView:(UITableView *)tableView
{
  [tableView setDelegate:self];
  [tableView setDataSource:self];
  [tableView setBackgroundColor:[UIColor clearColor]];
  [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  
  // background view
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
  [imageView setImage:[UIImage imageNamed:GEEKER_LIST_BACKGROUND_IMAGE]];
  [tableView setBackgroundView:imageView];
}

- (void)segmentChanged:(UISegmentedControl *)paramSender
{
  NSInteger index = paramSender.selectedSegmentIndex;
  
  if (index == 0) {
    [self.teamInfoTable setHidden:NO];
    [self.administrateTable setHidden:YES];
  }
  else if (index == 1) {
    [self.teamInfoTable setHidden:YES];
    [self.administrateTable setHidden:NO];
    if (!self.administrationLoadedOnce) {
      [self.administrateTable reloadData];
      self.administrationLoadedOnce = YES;
    }
  }
}
@end
