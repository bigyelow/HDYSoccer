//
//  GameListFilterTableViewCell.m
//  HDYSoccer
//
//  Created by bigyelow on 7/19/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GameListFilterTableViewCell.h"

CGFloat kClockLeftMargin = 10.0f;
CGFloat kClockTopMargin = 15.0f;
CGFloat kClockWidth = 13.0f;
CGFloat kClockHeight = 13.0f;

CGFloat kTextLeftMargin = 10.0f;
NSString *kTimeTitle = @"选择时间";

@implementation GameListFilterTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
    [self.contentView setAlpha:0.5];
    
    // clock image
    UIImage *clockImage = [UIImage imageNamed:@"clock-75.png"];
    CGRect clockRect = CGRectMake(kClockLeftMargin, kClockTopMargin, kClockWidth, kClockHeight);
    UIImageView *clockView = [[UIImageView alloc] initWithFrame:clockRect];
    [clockView setImage:clockImage];
    
    [self addSubview:clockView];
    
    // time
    UILabel *timeLabel = [UIConfiguration labelWithText:kTimeTitle textColor:[UIColor whiteColor] font:nil];
    CGFloat timeX = CGRectGetMaxX(clockView.frame) + kTextLeftMargin;
    
    [UIConfiguration setView:timeLabel origin:CGPointMake(timeX, 0)];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:timeLabel];
    
    self.timeLabel = timeLabel;
    [self addSubview:timeLabel];
    
    // seperator line
    CGFloat seperatorY = self.frame.size.height - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.frame.size.width, GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT)];
    [seperator setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_SEPERATOR_COLOR]];
    
    [self addSubview:seperator];
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
