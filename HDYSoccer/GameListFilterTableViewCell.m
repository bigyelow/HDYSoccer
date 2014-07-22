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
    
    // clock image
    UIImage *clockImage = [UIImage imageNamed:@"clock-75.png"];
    CGRect clockRect = CGRectMake(kClockLeftMargin, kClockTopMargin, kClockWidth, kClockHeight);
    UIImageView *clockView = [[UIImageView alloc] initWithFrame:clockRect];
    [clockView setImage:clockImage];
    
    [self.contentView addSubview:clockView];
    
    // time
    UILabel *timeLabel = [UIConfiguration labelWithText:kTimeTitle textColor:[UIColor whiteColor] font:nil];
    CGFloat timeX = CGRectGetMaxX(clockView.frame) + kTextLeftMargin;
    
    [UIConfiguration setView:timeLabel origin:CGPointMake(timeX, 0)];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:timeLabel];
    
    self.timeLabel = timeLabel;
    [self addSubview:timeLabel];
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
