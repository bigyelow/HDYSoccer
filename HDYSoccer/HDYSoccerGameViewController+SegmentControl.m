//
//  HDYSoccerGameViewController+SegmentControl.m
//  HDYSoccer
//
//  Created by bigyelow on 6/6/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameViewController+SegmentControl.h"
#import "HDYSoccerGameViewController+CollectionView.h"
#import "SVPullToRefresh.h"
#import "SegmentView.h"

@implementation HDYSoccerGameViewController (SegmentControl)

#define SEGMENT_TITLE_PERSONAL @"小场活动"
#define SEGMENT_TITLE_TEAM @"大场比赛"

- (void)configSegControlWithIndex:(NSInteger)segIndex
{
  // segment view
  NSArray *segments = [[NSArray alloc] initWithObjects:
                       SEGMENT_TITLE_PERSONAL,
                       SEGMENT_TITLE_TEAM,
                       nil];
  SegmentView *segmentView = [[SegmentView alloc] initWithFrame:
                              CGRectMake(0, 0, CGRectGetWidth(self.view.frame), SEGMENT_VIEW_HEIGHT)
                                                       segments:segments];
  self.segmentBackView = segmentView;
  [self.view addSubview:segmentView];
  
  self.segControl = segmentView.segControl;
  [self.segControl addTarget:self
                      action:@selector(segmentChanged:)
            forControlEvents:UIControlEventValueChanged];
  
  [self configCollectionViewWithCount:[segments count]];  // add collection views according to the number of segcontrol
  
  [self.segControl setSelectedSegmentIndex:segIndex];
  [self.segControl sendActionsForControlEvents:UIControlEventValueChanged];
}


#define TRIGGER_PULL_TO_REFRESH_DELAY 0.5f
- (void)segmentChanged:(UISegmentedControl *)paramSender
{
  NSInteger index = paramSender.selectedSegmentIndex;
  [self updateCollecionViewDisplayWithIndex:index];

  UICollectionView *collectView = self.collectionViewArray[index];
  BOOL loadedOnce = [self getLoadedOnceValueIndex:index];
  if (!loadedOnce && index == 0) {
    [Tools performAfterDelay:TRIGGER_PULL_TO_REFRESH_DELAY block:^{
      [collectView triggerPullToRefresh];
    }];
  }
  else if (!loadedOnce) {
    [collectView triggerPullToRefresh];
  }
}

#define GAME_TYPE_PERSONAL @"personal"
#define GAME_TYPE_TEAM @"team"

- (NSString *)getSegmentTypeWithIndex:(NSInteger)index
{
  if (index == 0) {
    return GAME_TYPE_PERSONAL;
  }
  else if (index == 1) {
    return GAME_TYPE_TEAM;
  }
  return @"";
}
@end
