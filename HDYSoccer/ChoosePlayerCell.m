//
//  ChoosePlayerCell.m
//  HDYSoccer
//
//  Created by bigyelow on 6/16/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ChoosePlayerCell.h"
#import "GameListFilterTableViewCell.h"
#import "UIImageView+WebCache.h"

#define SELECT_PLAYER_TITLE @"人数"

// image
#define PLAYER_IMAGE_LEFT_MARGIN 10.0F
#define PLAYER_IMAGE_TOP_MARGIN 13.0F
#define PLAYER_IMAGE_WIDTH 16.0F
#define PLAYER_IMAGE_HEIGHT 16.0F

// title
#define TITLE_LEFT_MARGIN 8.0f

// text field
#define TEXT_FIELD_LEFT_MARGIN 4.0f
#define TEXT_FIELD_WIDTH 80.0
#define TEXT_FIELD_HEIGHT 30.0f

// add friend button
#define FRIEND_BUTTON_LEFT_MARGIN 30.0f
#define FRIEND_BUTTON_WIDTH 26.0F
#define FRIEND_BUTTON_HEIGHT 24.0F

// FRIENDS
#define FRIENDS_TOP_MARGIN 7
#define FRIENDS_LEFT_MARGIN 7
#define FRIENDS_INTERAL_MARING 7
#define FRIEND_IMAGE_HEIGHT 24

#define FRIEND_NAME_TOP_MARGIN 5
#define FRIEND_NAME_HEIGHT 15

#define FRIENDS_ROW_MARGIN 8
#define FRIEND_NAME_BOTTOM_MARGIN 5
#define FRIEND_LIMIT_PER_LINE 3

#define FRIEND_SEPER_TOP_MARGIN 13

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
    
    self.addFriendButton = button;
    [self addSubview:button];
    
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

// playersArray = [[avatarURL, name, selected],...]
- (void)configCellWithPlayers:(NSArray *)playersArray
                   cellHeight:(CGFloat)cellHeight
{
  if (![Tools isNilOrEmptyArray:playersArray]) {
    CGFloat x = 0;
    CGFloat y = CGRectGetMaxY(self.addFriendButton.frame) + FRIENDS_TOP_MARGIN;
    CGFloat width = self.frame.size.width / FRIEND_LIMIT_PER_LINE;
    CGFloat height0 = (FRIENDS_TOP_MARGIN + FRIEND_IMAGE_HEIGHT
                       + FRIEND_NAME_TOP_MARGIN + FRIEND_NAME_HEIGHT);  // first row height
    CGFloat height1 =(FRIENDS_ROW_MARGIN + FRIEND_IMAGE_HEIGHT // other row height
                     + FRIEND_NAME_TOP_MARGIN + FRIEND_NAME_HEIGHT);
    NSInteger index = 0;
    for (NSArray *object in playersArray) {
      CGFloat backHeight = index < FRIEND_LIMIT_PER_LINE ? height0 : height1;
      UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, backHeight)];
      
      [self addSubview:backView];
      
      // avatar
      NSString *avatarURL = object[0];
      CGFloat avatarY = index < FRIEND_LIMIT_PER_LINE ? FRIENDS_TOP_MARGIN : FRIENDS_ROW_MARGIN;
      UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, avatarY, FRIEND_IMAGE_HEIGHT, FRIEND_IMAGE_HEIGHT)];
      [avatar setImageWithURL:[NSURL URLWithString:avatarURL]];
      [UIConfiguration moveSubviewXToSuperviewCenter:backView subview:avatar];
      
      [backView addSubview:avatar];
      
      // name
      NSString *name = object[1];
      CGFloat nameY = CGRectGetMaxY(avatar.frame) + FRIEND_NAME_TOP_MARGIN;
      CGFloat nameWidth = backView.frame.size.width;
      UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, nameY, nameWidth, FRIEND_NAME_HEIGHT)];
      [nameLabel setText:name];
      [nameLabel setTextColor:[UIColor whiteColor]];
      [nameLabel setFont:[UIFont systemFontOfSize:11]];
      [nameLabel setTextAlignment:NSTextAlignmentCenter];
      
      [backView addSubview:nameLabel];
      
      // seper
      if ((index + 1) % FRIEND_LIMIT_PER_LINE && index != [playersArray count] - 1) { // not the last one of the row
        CGFloat seperX = backView.frame.size.width - 0.5;
        CGFloat seperHeight = backView.frame.size.height - 2 * FRIEND_SEPER_TOP_MARGIN;
        UIView *lineSeper = [[UIView alloc] initWithFrame:CGRectMake(seperX, FRIEND_SEPER_TOP_MARGIN, 0.5, seperHeight)];
        [lineSeper setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR_CLEAR]];
        
        [backView addSubview:lineSeper];
        
        x += backView.frame.size.width;
      }
      else {
        x = 0;
        y += backHeight;
      }
      
      index++;
    }
    
    [UIConfiguration setView:self.seperator y:cellHeight - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT];
  }
}

- (CGFloat)cellHeight:(NSArray *)playersArray
{
  CGFloat height = 44;
  
  if (![Tools isNilOrEmptyArray:playersArray]) {
    NSInteger lineNumber = [playersArray count] / FRIEND_LIMIT_PER_LINE;
    lineNumber += (([playersArray count] % FRIEND_LIMIT_PER_LINE) ? 1 : 0);
    
    height += (FRIENDS_TOP_MARGIN + FRIEND_IMAGE_HEIGHT + FRIEND_NAME_TOP_MARGIN + FRIEND_NAME_HEIGHT);
    lineNumber--;
    
    height += (lineNumber * (FRIENDS_ROW_MARGIN + FRIEND_IMAGE_HEIGHT + FRIEND_NAME_TOP_MARGIN + FRIEND_NAME_HEIGHT));
    
    height += FRIEND_NAME_BOTTOM_MARGIN;
  }
  
  return height;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
