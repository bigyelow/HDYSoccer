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

@implementation HDYSoccerGameViewController (SegmentControl)

#define SEGMENT_TITLE_PERSONAL @"小场活动"
#define SEGMENT_TITLE_TEAM @"大场比赛"

- (void)configSegControlWithIndex:(NSInteger)segIndex
{
  NSArray *segments = [[NSArray alloc] initWithObjects:SEGMENT_TITLE_PERSONAL,
                       SEGMENT_TITLE_TEAM,
                       nil];
  self.segControl = [[UISegmentedControl alloc] initWithItems:segments];
  [UIConfiguration moveSubviewXToSuperviewCenter:self.view subview:self.segControl];
  
  [self.segControl addTarget:self
                      action:@selector(segmentChanged:)
            forControlEvents:UIControlEventValueChanged];
  
  [self.view addSubview:self.segControl];
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
