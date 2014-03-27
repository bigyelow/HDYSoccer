//
//  HDYSoccerGeekerViewController+UIConfiguration.m
//  HDYSoccer
//
//  Created by bigyelow on 3/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerViewController+UIConfiguration.h"
#import "GeekerViewParams.h"
#import "UIConfiguration.h"

@implementation HDYSoccerGeekerViewController (UIConfiguration)

- (void)configSegmentView
{
  // config segment view
  CGRect segmentRect = CGRectMake(0, 0, self.view.bounds.size.width, 0);
  UIView *segmentView = [[UIView alloc] initWithFrame:segmentRect];
  
  self.segControl = [[UISegmentedControl alloc] initWithItems:@[SEGMENT_ITEM_FRIENDS, SEGMENT_ITEM_SUPERIOR, SEGMENT_ITEM_TEAM]];
  for (NSInteger index = 0; index < self.segControl.numberOfSegments; ++index) {
    [self.segControl setWidth:SEGMENT_ITEM_WIDTH forSegmentAtIndex:index];
  }
  [self.segControl setBackgroundColor:[UIColor whiteColor]];

  CGRect segControlRect = self.segControl.frame;
  segControlRect.origin.y = SEGMENT_CONTROL_TOP_MARGIN;
  [self.segControl setFrame:segControlRect];
  
  segmentRect.size.height = self.segControl.frame.size.height
  + SEGMENT_CONTROL_TOP_MARGIN
  + SEGMENT_CONTROL_BOTTOM_MARGIN;
  [segmentView setFrame:segmentRect];
  
  [UIConfiguration moveSubviewXToSuperviewCenter:self.view subview:self.segControl];
  [segmentView addSubview:self.segControl];
  
  // update tableview frame
  CGRect tableRect = self.tableView.frame;
  tableRect.origin.y += segmentRect.size.height;
  tableRect.size.height -= segmentRect.size.height;
  self.tableView.frame = tableRect;
  
  [self.view addSubview:segmentView];
}
@end
