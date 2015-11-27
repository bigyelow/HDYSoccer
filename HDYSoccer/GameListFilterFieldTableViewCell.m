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
CGFloat kTextLeftMargin = 10.0;

NSString *kfieldTitle = @"选择场地";

@interface GameListFilterFieldTableViewCell ()

@property (nonatomic, strong) UIView *seperator;

@end

@implementation GameListFilterFieldTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
    [self.contentView setAlpha:0.5];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // field image
    UIImage *fieldImage = [UIImage imageNamed:@"location-75.png"];
    CGRect fieldRect = CGRectMake(kFieldLeftMargin, kFieldTopMargin, kFieldWidth, kFieldHeight);
    UIImageView *fieldView = [[UIImageView alloc] initWithFrame:fieldRect];
    [fieldView setImage:fieldImage];
    
    [self addSubview:fieldView];
    
    // field
    UILabel *fieldLabel = [UIConfiguration labelWithText:kfieldTitle textColor:[UIColor whiteColor] font:nil];
    CGFloat fieldX = CGRectGetMaxX(fieldView.frame) + kTextLeftMargin;
    
    [UIConfiguration setView:fieldLabel origin:CGPointMake(fieldX, 0)];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:fieldLabel];
    
    self.fieldLabel = fieldLabel;
    [self addSubview:fieldLabel];
    
    // seperator line
    CGFloat seperatorY = self.frame.size.height - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.frame.size.width, GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT)];
    [seperator setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_SEPERATOR_COLOR]];
    self.seperator = seperator;
    
    [self addSubview:seperator];
  }
  return self;
}

- (void)configCellWithField:(NSString *)field
{
  self.fieldLabel.text = field;
  [self.fieldLabel sizeToFit];
}

- (void)layoutSubviews
{
  [super layoutSubviews];

  CGRect frame = self.seperator.frame;
  frame.size.width = self.bounds.size.width;
  self.seperator.frame = frame;
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
