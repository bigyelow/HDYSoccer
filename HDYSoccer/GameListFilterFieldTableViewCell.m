//
//  GameListFilterFieldTableViewCell.m
//  HDYSoccer
//
//  Created by bigyelow on 7/19/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GameListFilterFieldTableViewCell.h"
#import "GameListFilterTableViewCell.h"

CGFloat kFieldLeftMargin = 10.0f;
CGFloat kFieldTopMargin = 15.0f;
CGFloat kFieldWidth = 14.0f;
CGFloat kFieldHeight = 14.0f;

#define TEXT_LEFT_MARGIN 10.0F
NSString *kfieldTitle = @"选择场地";

@implementation GameListFilterFieldTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
    [self.contentView setAlpha:0.5];
    
    // clock image
    UIImage *clockImage = [UIImage imageNamed:@"football-75.png"];
    CGRect clockRect = CGRectMake(kFieldLeftMargin, kFieldTopMargin, kFieldWidth, kFieldHeight);
    UIImageView *clockView = [[UIImageView alloc] initWithFrame:clockRect];
    [clockView setImage:clockImage];
    
    [self addSubview:clockView];
    
    // field
    UILabel *fieldLabel = [UIConfiguration labelWithText:kfieldTitle textColor:[UIColor whiteColor] font:nil];
    CGFloat fieldX = CGRectGetMaxX(clockView.frame) + TEXT_LEFT_MARGIN;
    
    [UIConfiguration setView:fieldLabel origin:CGPointMake(fieldX, 0)];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:fieldLabel];
    
    [self addSubview:fieldLabel];
    
    // seperator line
    CGFloat seperatorY = self.frame.size.height - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.frame.size.width, GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT)];
    [seperator setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_SEPERATOR_COLOR]];
    
    [self addSubview:seperator];
  }
  return self;
}

- (void)awakeFromNib
{
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
