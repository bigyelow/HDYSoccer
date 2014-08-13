//
//  HDYSoccerGeekerViewController+UIConfiguration.m
//  HDYSoccer
//
//  Created by bigyelow on 3/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerViewController+SegmentControl.h"
#import "HDYSoccerGeekerViewController+Network.h"
#import "GeekerViewParams.h"
#import "UIConfiguration.h"
#import "SegmentView.h"
#import "SVPullToRefresh.h"

@implementation HDYSoccerGeekerViewController (SegmentControl)

- (void)configSegmentView
{
  // update tableview frame
  [self.tableView removeFromSuperview];
  
  CGFloat tableHeight = self.view.frame.size.height;
  CGFloat tableWidth = self.view.frame.size.width;
  CGRect tableRect = CGRectMake(0, 0, tableWidth, tableHeight);

  // geeker
  self.geekerTable = [[UITableView alloc] initWithFrame:tableRect style:self.style];
  [self customTableView:self.geekerTable];
  
  __weak typeof(self) weakSelf = self;
  [self.geekerTable addPullToRefreshWithActionHandler:^{
    [weakSelf loadMyFriends];
  }];
  [self customPullToRefresh:self.geekerTable];
  
  [self.view addSubview:self.geekerTable];
  
  // team
  self.teamTable = [[UITableView alloc] initWithFrame:tableRect style:self.style];
  [self customTableView:self.teamTable];
  
  [self.teamTable addPullToRefreshWithActionHandler:^{
    [weakSelf loadMyTeams];
  }];
  [self customPullToRefresh:self.teamTable];
  
  [self.view addSubview:self.teamTable];
  
  
  // segment view
  NSArray *segments = @[SEGMENT_ITEM_FRIENDS, SEGMENT_ITEM_TEAM];
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
}

- (void)customTableView:(UITableView *)tableView
{
  [tableView setDelegate:self];
  [tableView setDataSource:self];
  [tableView setBackgroundColor:[UIColor clearColor]];
  [tableView setContentInset:UIEdgeInsetsMake(SEGMENT_VIEW_HEIGHT + TOP_BAR_HEIGHT, 0, 0, 0)];
  [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  
  // background view
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
  [imageView setImage:[UIImage imageNamed:GEEKER_LIST_BACKGROUND_IMAGE]];
  [tableView setBackgroundView:imageView];
}

#define TEXT_PULL_TO_REFRESH @"下拉刷新"
#define TEXT_RELEASE_TO_REFRESH @"松开刷新"
#define TEXT_LOADING @"加载中..."
#define REFRESH_TITLE_FONT_SIZE 13.0f
#define REFRESH_ARROW_COLOR @"#dfdfdf"
#define REFRESH_X_PLUS 35.0f

- (void)customPullToRefresh:(UIScrollView *)scrollView
{
  [scrollView.pullToRefreshView setTitle:TEXT_PULL_TO_REFRESH forState:SVPullToRefreshStateStopped];
  [scrollView.pullToRefreshView setTitle:TEXT_RELEASE_TO_REFRESH forState:SVPullToRefreshStateTriggered];
  [scrollView.pullToRefreshView setTitle:TEXT_LOADING forState:SVPullToRefreshStateLoading];
  [scrollView.pullToRefreshView.titleLabel setFont:[UIFont systemFontOfSize:REFRESH_TITLE_FONT_SIZE]];
  [scrollView.pullToRefreshView setArrowColor:[UIColor grayColor]];
  
  CGFloat centerX = scrollView.center.x + REFRESH_X_PLUS;
  CGFloat centerY = scrollView.pullToRefreshView.center.y;
  [scrollView.pullToRefreshView setCenter:CGPointMake(centerX, centerY)];
}


- (void)segmentChanged:(UISegmentedControl *)paramSender
{
  NSInteger index = paramSender.selectedSegmentIndex;
  
  if (index == 0) { // geeker list
    if (self.geekersLoadedOnce == NO) {
      [self.geekerTable triggerPullToRefresh];
    }
    [self.geekerTable setHidden:NO];
    [self.teamTable setHidden:YES];
  }
  else {  // team list
    if (self.teamLoadedOnce == NO) {
      [self.teamTable triggerPullToRefresh];
    }
    [self.geekerTable setHidden:YES];
    [self.teamTable setHidden:NO];
  }
}
@end
