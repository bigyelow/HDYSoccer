//
//  HDYSoccerGeekerDetailViewController+SegmentControl.m
//  HDYSoccer
//
//  Created by bigyelow on 8/12/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerDetailViewController+SegmentControl.h"
#import "SegmentView.h"

// SEGMENT
#define SEGMENT_TITLE_PLAYER_INFO @"个人信息"
#define SEGMENT_TITLE_STATISTICS @"数据"

@implementation HDYSoccerGeekerDetailViewController (SegmentControl)

- (void)configSegmentView
{
  // update tableview frame
  [self.tableView removeFromSuperview];
  
  CGFloat tableHeight = self.view.frame.size.height;
  CGFloat tableWidth = self.view.frame.size.width;
  CGRect tableRect = CGRectMake(0, 0, tableWidth, tableHeight);
  
  // player info table
  self.playerInfoTable = [[UITableView alloc] initWithFrame:tableRect style:UITableViewStylePlain];
  [self customTableView:self.playerInfoTable];
  
  [self.view addSubview:self.playerInfoTable];
  
  // segment view
  NSArray *segments = @[SEGMENT_TITLE_PLAYER_INFO, SEGMENT_TITLE_STATISTICS];
  CGRect segmentRect = CGRectMake(0, TOP_BAR_HEIGHT, CGRectGetWidth(self.view.frame), SEGMENT_VIEW_HEIGHT);
  SegmentView *segmentView = [[SegmentView alloc] initWithFrame:segmentRect segments:segments];
  
//  [self.view addSubview:segmentView];

  // send control
  self.segControl = segmentView.segControl;
  [self.segControl addTarget:self
                      action:@selector(segmentChanged:)
            forControlEvents:UIControlEventValueChanged];
  
  [self.segControl setSelectedSegmentIndex:0];
  [self.segControl sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)customTableView:(UITableView *)tableView
{
  [tableView setDelegate:self];
  [tableView setDataSource:self];
  [tableView setBackgroundColor:[UIColor clearColor]];
  [tableView setContentInset:UIEdgeInsetsMake(0, 0, 0, 0)];
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
  
  }
  else if (index == 1) {
    
  }
}
@end
