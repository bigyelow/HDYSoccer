//
//  PlayerAbilityHeaderView.m
//  HDYSoccer
//
//  Created by bigyelow on 8/18/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "PlayerAbilityHeaderView.h"

#define TOP_SEPER_TOP_MARGIN 15
#define TOP_SEPER_HEIGHT 1

// TITLE
#define TITLE_TOP_MARGIN 4
#define TITLE_HEIGHT 15
#define TITLE_BOTTOM_MARGIN 5

@implementation PlayerAbilityHeaderView

- (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIColor whiteColor]];
    [UIConfiguration setView:self height:[[self class] viewHeight]];
    
    // TOP SEPERATOR
    UIView *topSeper = [[UIView alloc] initWithFrame:CGRectMake(0, TOP_SEPER_TOP_MARGIN, frame.size.width, TOP_SEPER_HEIGHT)];
    [topSeper setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR]];
    [self addSubview:topSeper];
    
    // TITLE
    CGFloat titleY = CGRectGetMaxY(topSeper.frame) + TITLE_TOP_MARGIN;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, titleY, frame.size.width, TITLE_HEIGHT)];
    [titleLabel setText:title];
    [titleLabel setTextAlignment:NSTextAlignmentCenter];
    [titleLabel setFont:[UIFont systemFontOfSize:14]];
    [titleLabel setTextColor:[UIColor lightGrayColor]];
    
    [self addSubview:titleLabel];
  }
  return self;
}

+ (CGFloat)viewHeight
{
  return TOP_SEPER_TOP_MARGIN + TOP_SEPER_HEIGHT + TITLE_TOP_MARGIN + TITLE_HEIGHT + TITLE_BOTTOM_MARGIN;
}

@end
