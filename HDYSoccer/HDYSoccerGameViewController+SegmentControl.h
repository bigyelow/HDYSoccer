//
//  HDYSoccerGameViewController+SegmentControl.h
//  HDYSoccer
//
//  Created by bigyelow on 6/6/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameViewController.h"

@interface HDYSoccerGameViewController (SegmentControl)

- (NSString *)getSegmentTypeWithIndex:(NSInteger)index;
- (void)configSegControlWithIndex:(NSInteger)segIndex;
@end
