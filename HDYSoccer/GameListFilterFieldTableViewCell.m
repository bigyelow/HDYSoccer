//
//  GameListFilterFieldTableViewCell.m
//  HDYSoccer
//
//  Created by bigyelow on 7/19/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GameListFilterFieldTableViewCell.h"
#import "GameListFilterTableViewCell.h"

CGFloat kFieldLeftMargin = 8.0f;
CGFloat kFieldTopMargin = 13.0f;
CGFloat kFieldWidth = 16.0f;
CGFloat kFieldHeight = 16.0f;

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
    
    // field image
    UIImage *fieldImage = [UIImage imageNamed:@"location-75.png"];
    CGRect fieldRect = CGRectMake(kFieldLeftMargin, kFieldTopMargin, kFieldWidth, kFieldHeight);
    UIImageView *fieldView = [[UIImageView alloc] initWithFrame:fieldRect];
    [fieldView setImage:fieldImage];
    
    [self addSubview:fieldView];
    
    // field
    UILabel *fieldLabel = [UIConfiguration labelWithText:kfieldTitle textColor:[UIColor whiteColor] font:nil];
    CGFloat fieldX = CGRectGetMaxX(fieldView.frame) + TEXT_LEFT_MARGIN;
    
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
