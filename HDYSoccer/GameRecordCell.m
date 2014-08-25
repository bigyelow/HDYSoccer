//
//  GameRecordCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/25/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GameRecordCell.h"
#import "TeamGameRecords.h"
#import "TeamDetailViewController.h"

#define TIME_HEIGHT 15

#define SCORE_WIDTH 50

#define HOME_RIGHT_MARGIN 10

#define SEPER_HEIGHT 0.5

@implementation GameRecordCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [UIConfiguration setView:self height:GAME_RECORD_CELL_HEIGHT];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // TIME
    UIView *timeBackView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, TIME_HEIGHT)];
    [timeBackView setBackgroundColor:[UIConfiguration colorForHex:@"#f5f5f5"]];
    
    [self addSubview:timeBackView];
    
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:timeBackView.bounds];
    [timeLabel setFont:[UIFont systemFontOfSize:12]];
    [timeLabel setTextAlignment:NSTextAlignmentCenter];
    [timeLabel setTextColor:[UIColor lightGrayColor]];
    
    self.timeLabel = timeLabel;
    [timeBackView addSubview:timeLabel];
    
    // HOME TEAM
    CGFloat homeWidth = (self.frame.size.width - SCORE_WIDTH - 2 * HOME_RIGHT_MARGIN) / 2;
    CGFloat homeY = CGRectGetMaxY(timeBackView.frame);
    CGFloat homeHeight = self.frame.size.height - TIME_HEIGHT;
    
    self.homeTeamLabel = [self teamLabelWithFrame:CGRectMake(HOME_RIGHT_MARGIN, homeY, homeWidth, homeHeight)];
    
    [self addSubview:self.homeTeamLabel];
    
    // SCORE
    CGFloat scoreX = CGRectGetMaxX(self.homeTeamLabel.frame);
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(scoreX, homeY, SCORE_WIDTH, homeHeight)];
    [self.scoreLabel setTextAlignment:NSTextAlignmentCenter];
    [self.scoreLabel setFont:[UIFont systemFontOfSize:15]];
    [self.scoreLabel setTextColor:[UIColor grayColor]];
    
    [self addSubview:self.scoreLabel];
    
    // GUEST TEAM
    CGFloat guestX = CGRectGetMaxX(self.scoreLabel.frame);
    self.guestTeamLabel = [self teamLabelWithFrame:CGRectMake(guestX, homeY, homeWidth, homeHeight)];
    
    [self addSubview:self.guestTeamLabel];
    
    // SEPER
    CGFloat seperY = SEPER_HEIGHT;
    UIView *seper = [[UIView alloc] initWithFrame:CGRectMake(0, seperY, self.frame.size.width, SEPER_HEIGHT)];
    [seper setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR]];
    
    [self addSubview:seper];
  }
  return self;
}

- (UILabel *)teamLabelWithFrame:(CGRect)frame
{
  UILabel *label = [[UILabel alloc] initWithFrame:frame];
  [label setTextAlignment:NSTextAlignmentCenter];
  [label setFont:[UIFont systemFontOfSize:15]];
  [label setNumberOfLines:2];
  
  return label;
}

- (void)configWithRecord:(TeamGameRecords *)record
{
  self.record = record;
  
  [self.timeLabel setText:[Tools dateOnlyToStr:record.time preferUTC:NO]];
  [self.homeTeamLabel setText:record.homeTeamName];
  [self.scoreLabel setText:record.score];
  [self.guestTeamLabel setText:record.guestTeamName];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
