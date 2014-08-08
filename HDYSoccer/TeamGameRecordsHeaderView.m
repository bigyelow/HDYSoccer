//
//  TeamGameRecordsHeaderView.m
//  HDYSoccer
//
//  Created by bigyelow on 8/8/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "TeamGameRecordsHeaderView.h"
#import "GameListFilterTableViewCell.h"

#define BACKGROUND_COLOR @"#f3f3f3"
#define TEXT_COLOR @"#9f9f9f"

@implementation TeamGameRecordsHeaderView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIConfiguration colorForHex:BACKGROUND_COLOR]];
    
    UILabel *label = [UIConfiguration labelWithText:TEXT_TEAM_GAME_RECORDS_TITLE
                                          textColor:[UIColor grayColor]
                                               font:[UIFont systemFontOfSize:12]
                                      numberOfLines:1];
    [UIConfiguration moveSubviewToSuperviewCenter:self subview:label];
    
    [self addSubview:label];
    
    // bottom seperator
    CGFloat seperatorY = self.frame.size.height - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.frame.size.width, GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT)];
    [seperator setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR]];
    
    [self addSubview:seperator];
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
