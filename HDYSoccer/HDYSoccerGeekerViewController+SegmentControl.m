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

#define SEGMENT_VIEW_HEIGHT 40.0f

@implementation HDYSoccerGeekerViewController (SegmentControl)

- (void)configSegmentView
{
  // config segment view
  CGRect segmentViewRect = CGRectMake(0, 0, self.view.bounds.size.width, SEGMENT_VIEW_HEIGHT);
  UIView *segmentView = [[UIView alloc] initWithFrame:segmentViewRect];
  [self.view addSubview:segmentView];
  
  // segControl
  self.segControl = [[UISegmentedControl alloc] initWithItems:@[SEGMENT_ITEM_FRIENDS, SEGMENT_ITEM_TEAM]];
  for (NSInteger index = 0; index < self.segControl.numberOfSegments; ++index) {
    [self.segControl setWidth:SEGMENT_ITEM_WIDTH forSegmentAtIndex:index];
  }
  [self.segControl setBackgroundColor:[UIColor whiteColor]];

  CGRect segControlRect = self.segControl.frame;
  segControlRect.origin.y = SEGMENT_CONTROL_TOP_MARGIN;
  segControlRect.size.height = SEGMENT_VIEW_HEIGHT - SEGMENT_CONTROL_TOP_MARGIN - SEGMENT_CONTROL_BOTTOM_MARGIN;
  [self.segControl setFrame:segControlRect];
  
  [UIConfiguration moveSubviewXToSuperviewCenter:self.view subview:self.segControl];
  [segmentView addSubview:self.segControl];
  
  [self.segControl addTarget:self
                      action:@selector(segmentChanged:)
            forControlEvents:UIControlEventValueChanged];
  
  // update tableview frame
  // geeker
  CGRect tableRect = self.tableView.frame;
  tableRect.origin.y += SEGMENT_VIEW_HEIGHT;
  tableRect.size.height -= SEGMENT_VIEW_HEIGHT;
  self.tableView.frame = tableRect;
  
  // team
  self.teamTable = [[UITableView alloc] initWithFrame:tableRect style:self.style];
  [self.teamTable setHidden:YES];
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
      [self.tableView setHidden:NO];
      [self.teamTable setHidden:YES];
    }
  }
  else {  // team list
    if (self.teamLoadedOnce == NO) {
      [self.tableView setHidden:YES];
      [self.teamTable setHidden:NO];
    }
    else {
      [self.tableView setHidden:YES];
      [self.teamTable setHidden:NO];
    }
  }
}
@end
