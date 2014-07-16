//
//  SegmentView.h
//  HDYSoccer
//
//  Created by bigyelow on 7/16/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define SEGMENT_VIEW_HEIGHT 40.0F

@interface SegmentView : UIView

@property (nonatomic, strong) UISegmentedControl *segControl;
- (id)initWithFrame:(CGRect)frame
           segments:(NSArray *)segments;
@end
