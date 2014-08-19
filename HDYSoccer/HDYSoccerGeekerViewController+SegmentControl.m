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
  [self.geekerTable setContentInset:UIEdgeInsetsMake(SEGMENT_VIEW_HEIGHT, 0, 0, 0)];
  
  // refresh control
  UIRefreshControl *playerRefreshCtr = [[UIRefreshControl alloc] init];
  [playerRefreshCtr setTintColor:[UIColor whiteColor]];
  [playerRefreshCtr addTarget:self action:@selector(loadMyFriends) forControlEvents:UIControlEventValueChanged];
  
  self.playerRefreshControl = playerRefreshCtr;
  [self.geekerTable addSubview:playerRefreshCtr];
  
  [self.view addSubview:self.geekerTable];
  
  // team
  self.teamTable = [[UITableView alloc] initWithFrame:tableRect style:self.style];
  [self customTableView:self.teamTable];
  [self.teamTable setContentInset:UIEdgeInsetsMake(SEGMENT_VIEW_HEIGHT + TOP_BAR_HEIGHT, 0, 0, 0)];
  
  // refresh control
  UIRefreshControl *teamRefreshCtr = [[UIRefreshControl alloc] init];
  [teamRefreshCtr setTintColor:[UIColor whiteColor]];
  [teamRefreshCtr addTarget:self action:@selector(loadMyTeams) forControlEvents:UIControlEventValueChanged];
  
  self.teamRefreshControl = teamRefreshCtr;
  [self.teamTable addSubview:teamRefreshCtr];
  
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
  [tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  
  // background view
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
  [imageView setImage:[UIImage imageNamed:GEEKER_LIST_BACKGROUND_IMAGE]];
  [tableView setBackgroundView:imageView];
}

- (void)segmentChanged:(UISegmentedControl *)paramSender
{
  NSInteger index = paramSender.selectedSegmentIndex;
  
  if (index == 0) { // geeker list
    [self.geekerTable setHidden:NO];
    [self.teamTable setHidden:YES];
    
    if (self.geekersLoadedOnce == NO) {
      [self loadMyFriends];
    }
  }
  else {  // team list
    [self.geekerTable setHidden:YES];
    [self.teamTable setHidden:NO];
    
    if (self.teamLoadedOnce == NO) {
      [self loadMyTeams];
    }

  }
}
@end
