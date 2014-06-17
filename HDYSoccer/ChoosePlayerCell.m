//
//  ChoosePlayerCell.m
//  HDYSoccer
//
//  Created by bigyelow on 6/16/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ChoosePlayerCell.h"

#define SELECT_PLAYER_TITLE @"人数"

// title
#define TITLE_LEFT_MARGIN 10.0f

// text field
#define TEXT_FIELD_LEFT_MARGIN 10.0f
#define TEXT_FIELD_WIDTH 50.0
#define TEXT_FIELD_HEIGHT 30.0f

// choose friend button
#define FRIEND_BUTTON_LEFT_MARGIN 10.0f
#define FRIEND_BUTTON_TITLE @"选择好友"

@implementation ChoosePlayerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LEFT_MARGIN, 0, 0, 0)];
    [titleLabel setText:SELECT_PLAYER_TITLE];
    [titleLabel sizeToFit];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:titleLabel];
    
    // text field
    CGFloat fieldX = CGRectGetMaxX(titleLabel.frame) + TEXT_FIELD_LEFT_MARGIN;
    CGRect fieldRect = CGRectMake(fieldX, 0, TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT);
    UITextField *textField = [[UITextField alloc] initWithFrame:fieldRect];
    [textField.layer setBorderWidth:1.0f];
    [textField.layer setCornerRadius:5.0f];
    [textField.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [textField setKeyboardType:UIKeyboardTypeNumberPad];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:textField];
    
    self.textField = textField;
    
    // choose friend
    CGFloat buttonX = CGRectGetMaxX(textField.frame) + FRIEND_BUTTON_LEFT_MARGIN;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, 0, 0, 50)];
    [button setTitle:FRIEND_BUTTON_TITLE forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [button sizeToFit];
    
    [button.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [button.layer setCornerRadius:5.0f];
    [button.layer setBorderWidth:1.0f];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:button];
    
    [self.contentView addSubview:button];
    [self.contentView addSubview:titleLabel];
    [self.contentView addSubview:textField];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
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
