//
//  ChoosePlayerCell.m
//  HDYSoccer
//
//  Created by bigyelow on 6/16/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ChoosePlayerCell.h"
#import "GameListFilterTableViewCell.h"

#define SELECT_PLAYER_TITLE @"人数"

// image
#define PLAYER_IMAGE_LEFT_MARGIN 10.0F
#define PLAYER_IMAGE_TOP_MARGIN 13.0F
#define PLAYER_IMAGE_WIDTH 16.0F
#define PLAYER_IMAGE_HEIGHT 16.0F

// title
#define TITLE_LEFT_MARGIN 8.0f

// text field
#define TEXT_FIELD_LEFT_MARGIN 5.0f
#define TEXT_FIELD_WIDTH 80.0
#define TEXT_FIELD_HEIGHT 30.0f

// choose friend button
#define FRIEND_BUTTON_LEFT_MARGIN 30.0f
#define FRIEND_BUTTON_WIDTH 26.0F
#define FRIEND_BUTTON_HEIGHT 24.0F

@implementation ChoosePlayerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    //
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
    [self.contentView setAlpha:0.5];
    
    // player image
    UIImage *playerImage = [UIImage imageNamed:@"group-75.png"];
    CGRect playerRect = CGRectMake(PLAYER_IMAGE_LEFT_MARGIN, PLAYER_IMAGE_TOP_MARGIN, PLAYER_IMAGE_WIDTH, PLAYER_IMAGE_HEIGHT);
    UIImageView *playerView = [[UIImageView alloc] initWithFrame:playerRect];
    [playerView setImage:playerImage];
    
    [self addSubview:playerView];
    
    // title
    CGFloat titleX = CGRectGetMaxX(playerView.frame) + TITLE_LEFT_MARGIN;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, 0, 0, 0)];
    [titleLabel setText:SELECT_PLAYER_TITLE];
    [titleLabel sizeToFit];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:titleLabel];
    
    [self addSubview:titleLabel];
    
    // text field
    CGFloat fieldX = CGRectGetMaxX(titleLabel.frame) + TEXT_FIELD_LEFT_MARGIN;
    CGRect fieldRect = CGRectMake(fieldX, 0, TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT);
    UITextField *textField = [[UITextField alloc] initWithFrame:fieldRect];
    [textField.layer setBorderWidth:1.0f];
    [textField.layer setCornerRadius:5.0f];
    [textField.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [textField setKeyboardType:UIKeyboardTypeNumberPad];
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField setTintColor:[UIColor blackColor]];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:textField];
    
    self.textField = textField;
    [self addSubview:textField];
    
    // choose friend
    CGFloat buttonX = CGRectGetMaxX(textField.frame) + FRIEND_BUTTON_LEFT_MARGIN;
    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(buttonX, 0, FRIEND_BUTTON_WIDTH, FRIEND_BUTTON_HEIGHT)];
    [button setImage:[UIImage imageNamed:@"add_user-75.png"] forState:UIControlStateNormal];
    
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:button];
    
    [self addSubview:button];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
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
