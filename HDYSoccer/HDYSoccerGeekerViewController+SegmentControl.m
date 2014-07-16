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
  // segment view
  NSArray *segments = @[SEGMENT_ITEM_FRIENDS, SEGMENT_ITEM_TEAM];
  CGRect segmentRect = CGRectMake(0, 0, CGRectGetWidth(self.view.frame), SEGMENT_VIEW_HEIGHT);
  SegmentView *segmentView = [[SegmentView alloc] initWithFrame:segmentRect segments:segments];
  [self.view addSubview:segmentView];
  
  self.segControl = segmentView.segControl;
  [self.segControl addTarget:self
                      action:@selector(segmentChanged:)
            forControlEvents:UIControlEventValueChanged];
  
  // update tableview frame
  // geeker
  CGFloat tableHeight = CGRectGetHeight(self.view.frame) - CGRectGetHeight(segmentView.frame);
  CGFloat tableWidth = CGRectGetWidth(self.view.frame);
  CGFloat tableY = CGRectGetHeight(segmentView.frame);
  CGRect tableRect = CGRectMake(0, tableY, tableWidth, tableHeight);

  self.geekerTable = [[UITableView alloc] initWithFrame:tableRect style:self.style];
  [self.geekerTable setDelegate:self];
  [self.geekerTable setDataSource:self];
  [self.view addSubview:self.geekerTable];
  
  // team
  self.teamTable = [[UITableView alloc] initWithFrame:tableRect style:self.style];
  [self.teamTable setHidden:YES];
  [self.teamTable setDelegate:self];
  [self.teamTable setDataSource:self];
  [self.view addSubview:self.teamTable];
  
  [self.segControl setSelectedSegmentIndex:0];
  [self.segControl sendActionsForControlEvents:UIControlEventValueChanged];
}

- (void)segmentChanged:(UISegmentedControl *)paramSender
{
  NSInteger index = paramSender.selectedSegmentIndex;
  
  if (index == 0) { // geeker list
    if (self.geekersLoadedOnce == NO) {
      [self loadMyFriends];
    }
    else {
      [self.geekerTable setHidden:NO];
      [self.teamTable setHidden:YES];
    }
  }
  else {  // team list
    if (self.teamLoadedOnce == NO) {
      [self.geekerTable setHidden:YES];
      [self.teamTable setHidden:NO];
    }
    else {
      [self.geekerTable setHidden:YES];
      [self.teamTable setHidden:NO];
    }
  }
}
@end
