//
//  ChooseTeamCell.m
//  HDYSoccer
//
//  Created by bigyelow on 6/17/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ChooseTeamCell.h"
#import "GameListFilterTableViewCell.h"
#import "UIImageView+WebCache.h"

#define TITLE_LEFT_MARGIN 8.0f

// image
#define NUMBER_IMAGE_LEFT_MARGIN 10.0F
#define NUMBER_IMAGE_TOP_MARGIN 13.0F
#define NUMBER_IMAGE_WIDTH 16.0F
#define NUMBER_IMAGE_HEIGHT 16.0F

// choose team button
#define TEAM_BUTTON_LEFT_MARGIN 10.0f
#define TEAM_BUTTON_TITLE @"选择我的球队"
#define TEAM_BUTTON_LEFT_PLUS 10.0F

// number of NUMBERs label and text field
#define NUMBER_TOP_MARGIN 10.0f
#define NUMBER_TITLE @"几人制"
#define NUMBER_FIELD_LEFT_MARGIN 5.0f
#define NUMBER_FIELD_WIDTH 50.0f
#define NUMBER_FIELD_HEIGHT 30.0f
#define NUMBER_FIELD_MEASURE_LEFTMARGIN 5.0f

// TEAM
#define TEAM_AVATAR_TOP_MARGIN 13
#define TEAM_AVATAR_HEIGHT 40
#define TEAM_NAME_TOP_MARGIN 10
#define TEAM_NAME_HEIGHT 18
#define TEAM_NAME_BOTTOM_MARGIN 13

@implementation ChooseTeamCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    //
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
    [self.contentView setAlpha:0.5];
    
    // number image
    UIImage *numberImage = [UIImage imageNamed:@"group-75.png"];
    CGRect numberRect = CGRectMake(NUMBER_IMAGE_LEFT_MARGIN, NUMBER_IMAGE_TOP_MARGIN, NUMBER_IMAGE_WIDTH, NUMBER_IMAGE_HEIGHT);
    UIImageView *numberView = [[UIImageView alloc] initWithFrame:numberRect];
    [numberView setImage:numberImage];
    
    [self addSubview:numberView];
    
    // title
    CGFloat titleX = CGRectGetMaxX(numberView.frame) + TITLE_LEFT_MARGIN;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, 0, 0, 0)];
    [titleLabel setText:NUMBER_TITLE];
    [titleLabel sizeToFit];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:titleLabel];
    
    // text field
    CGFloat fieldX = CGRectGetMaxX(titleLabel.frame) + NUMBER_FIELD_LEFT_MARGIN;
    CGRect fieldRect = CGRectMake(fieldX, 0, NUMBER_FIELD_WIDTH, NUMBER_FIELD_HEIGHT);
    UITextField *textField = [[UITextField alloc] initWithFrame:fieldRect];
    [textField.layer setBorderWidth:1.0f];
    [textField.layer setCornerRadius:5.0f];
    [textField.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [textField setKeyboardType:UIKeyboardTypeNumberPad];
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField setTintColor:[UIColor blackColor]];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:textField];
    self.textField = textField;
    
    // choose team
    CGFloat buttonX = CGRectGetMaxX(textField.frame) + TEAM_BUTTON_LEFT_MARGIN;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, 0, 0, 50)];
    [button setTitle:TEAM_BUTTON_TITLE forState:UIControlStateNormal];
    [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [button setBackgroundColor:[UIColor clearColor]];
    [button.titleLabel setFont:[UIFont systemFontOfSize:17.0]];
    [button sizeToFit];
    
    CGFloat buttonWidth = button.frame.size.width + 2 * TEAM_BUTTON_LEFT_PLUS;
    [UIConfiguration setView:button width:buttonWidth];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:button];
    
    self.chooseTeamButton = button;
    
    [self addSubview:button];
    [self addSubview:titleLabel];
    [self addSubview:textField];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // seperator line
    CGFloat seperatorY = self.frame.size.height - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.frame.size.width, GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT)];
    [seperator setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_SEPERATOR_COLOR]];
    
    self.seperator = seperator;
    [self addSubview:seperator];
  }
  
  return self;
}

// team = [avatar, name, selected]
- (void)configCellWithTeam:(NSArray *)team
{
  NSString *avatarURL = team[0];
  NSString *name = team[1];
  
  CGFloat avatarY = CHOOSE_TEAM_NORMAL_HEIGHT + TEAM_AVATAR_TOP_MARGIN;
  UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, avatarY, TEAM_AVATAR_HEIGHT, TEAM_AVATAR_HEIGHT)];
  [avatar sd_setImageWithURL:[NSURL URLWithString:avatarURL]];
  [UIConfiguration moveSubviewXToSuperviewCenter:self subview:avatar];
  
  [self addSubview:avatar];
  
  CGFloat nameY = CGRectGetMaxY(avatar.frame) + TEAM_NAME_TOP_MARGIN;
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, nameY, self.frame.size.width, TEAM_NAME_HEIGHT)];
  
  [label setText:name];
  [label setTextColor:[UIColor whiteColor]];
  [label setTextAlignment:NSTextAlignmentCenter];
  [label setFont:[UIFont systemFontOfSize:13]];
  
  [self addSubview:label];
  
  [self.chooseTeamButton setTitle:TEXT_SELECT_AGAIN forState:UIControlStateNormal];
  
  [UIConfiguration setView:self.seperator y:CGRectGetMaxY(label.frame)
   + TEAM_NAME_BOTTOM_MARGIN - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT];
}

- (CGFloat)cellHeight
{
  CGFloat height = CHOOSE_TEAM_NORMAL_HEIGHT;
  height += (TEAM_AVATAR_TOP_MARGIN + TEAM_AVATAR_HEIGHT
             + TEAM_NAME_TOP_MARGIN + TEAM_NAME_HEIGHT + TEAM_NAME_BOTTOM_MARGIN);
  
  return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
