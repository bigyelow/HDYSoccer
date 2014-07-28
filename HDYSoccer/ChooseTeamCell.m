//
//  ChooseTeamCell.m
//  HDYSoccer
//
//  Created by bigyelow on 6/17/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ChooseTeamCell.h"

#define TITLE_LEFT_MARGIN 10.0f

// choose team button
#define TEAM_BUTTON_LEFT_MARGIN 10.0f
#define TEAM_BUTTON_TITLE @"选择我的球队"

// number of players label and text field
#define NUMBER_TOP_MARGIN 10.0f
#define NUMBER_TITLE @"几人制"
#define NUMBER_FIELD_LEFT_MARGIN 5.0f
#define NUMBER_FIELD_WIDTH 50.0f
#define NUMBER_FIELD_HEIGHT 30.0f
#define NUMBER_FIELD_MEASURE_LEFTMARGIN 5.0f

@implementation ChooseTeamCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LEFT_MARGIN, 0, 0, 0)];
    [titleLabel setText:NUMBER_TITLE];
    [titleLabel sizeToFit];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:titleLabel];
    
    // text field
    CGFloat fieldX = CGRectGetMaxX(titleLabel.frame) + NUMBER_FIELD_LEFT_MARGIN;
    CGRect fieldRect = CGRectMake(fieldX, 0, NUMBER_FIELD_WIDTH, NUMBER_FIELD_HEIGHT);
    UITextField *textField = [[UITextField alloc] initWithFrame:fieldRect];
    [textField.layer setBorderWidth:1.0f];
    [textField.layer setCornerRadius:5.0f];
    [textField.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [textField setKeyboardType:UIKeyboardTypeNumberPad];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:textField];
    self.textField = textField;
    
    // choose team
    CGFloat buttonX = CGRectGetMaxX(textField.frame) + TEAM_BUTTON_LEFT_MARGIN;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, 0, 0, 50)];
    [button setTitle:TEAM_BUTTON_TITLE forState:UIControlStateNormal];
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
