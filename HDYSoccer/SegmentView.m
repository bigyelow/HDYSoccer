//
//  SegmentView.m
//  HDYSoccer
//
//  Created by bigyelow on 7/16/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "SegmentView.h"

#define SEGMENT_BACKGROUND_COLOR @"#e9e9e9"
#define SEGCONTROL_HEIGHT 28.0F
#define SEGMENT_ITEM_WIDTH 100.0f

@implementation SegmentView

- (id)initWithFrame:(CGRect)frame
           segments:(NSArray *)segments
{
  self = [super initWithFrame:frame];
  if (self) {
    // segcontrol background view
    CGFloat lineHeight = 0.5f;
    [self setBackgroundColor:[UIConfiguration colorForHex:SEGMENT_BACKGROUND_COLOR]];
    [self setAlpha:0.96];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, CGRectGetHeight(frame) - lineHeight, CGRectGetWidth(frame), lineHeight)];
    [line setBackgroundColor:[UIColor lightGrayColor]];
    [self addSubview:line];
    
    self.segControl = [[UISegmentedControl alloc] initWithItems:segments];
    for (NSInteger index = 0; index < self.segControl.numberOfSegments; ++index) {
      [self.segControl setWidth:SEGMENT_ITEM_WIDTH forSegmentAtIndex:index];
    }
    [self.segControl setBackgroundColor:[UIConfiguration colorForHex:SEGMENT_BACKGROUND_COLOR]];
    [self.segControl setTintColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR]];
    [UIConfiguration setView:self.segControl height:SEGCONTROL_HEIGHT];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:self.segControl];
    [UIConfiguration moveSubviewXToSuperviewCenter:self subview:self.segControl];
    
    [self addSubview:self.segControl];
  }
  return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
