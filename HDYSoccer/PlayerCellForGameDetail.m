//
//  PlayerCellForGameDetail.m
//  HDYSoccer
//
//  Created by bigyelow on 7/31/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "PlayerCellForGameDetail.h"
#import "SimpleGeekerInfo.h"
#import "UIImageView+WebCache.h"
#import "GameListFilterTableViewCell.h"
#import "GeekerTag.h"
#import "UILabel+Customize.h"

#define GAME_INFO_CELL_FONT_NAME @"Verdana"

#define CELL_RIGHT_MARGIN 20.0F

// avatar
#define AVATAR_TOP_MARGIN 8.0F
#define AVATAR_LEFT_MARGIN 12.0F
#define SPONSOR_BORDER_COLOR @"#cc0000"

// name
#define NAME_LEFT_MARGIN 3.0F
#define NAME_FONT_SIZE 14.0F

// score
#define SCORE_LEFT_MARGIN 10.0F
#define SCORE_PLUS_WIDTH 10.0F

// tags
#define TAGS_COUNT 2
#define TAGS_LEFT_MARGIN 18.0F
#define TAGS_INTERAL_MARGIN 10.0F
#define TAG_FONT_SIZE 16.0F
#define TAG_PLUS_WIDTH 20
#define TAG_HEIGHT 30
#define TAG_BACKGROUND_COLOR @"#37ae84"

// seperator
#define SEPERATOR_COLOR @"#d8d8d8"

@implementation PlayerCellForGameDetail

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [UIConfiguration setView:self height:GAME_INFO_PLAYER_CELL_HEIGHT];
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
    [self.contentView setAlpha:0.5];
    
    // avatar
    CGFloat avatarHeight = self.frame.size.height - 2 * AVATAR_TOP_MARGIN;
    UIImageView *avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(AVATAR_LEFT_MARGIN, AVATAR_TOP_MARGIN, avatarHeight, avatarHeight)];
    avatarView.layer.cornerRadius = avatarHeight / 2;
    avatarView.layer.borderColor = [UIColor whiteColor].CGColor;
    avatarView.layer.borderWidth = 1.0f;
    avatarView.clipsToBounds = YES;
    
    self.avatarView = avatarView;
    [self addSubview:avatarView];
    
    // sponsor
    CGFloat captainX = CGRectGetMaxX(avatarView.frame);
    CGFloat captainY = self.avatarView.center.y;
    CGFloat captainWidth = avatarHeight / 2.5;
    UIImageView *captainView = [[UIImageView alloc] initWithFrame:CGRectMake(captainX, captainY, captainWidth, captainWidth)];
    [captainView setImage:[UIImage imageNamed:@"star-26.png"]];
    
    self.sponsorView = captainView;
    [self.sponsorView setHidden:YES];
    
    [self addSubview:self.sponsorView];
    
    // name
    CGFloat nameX = CGRectGetMaxX(self.sponsorView.frame) + NAME_LEFT_MARGIN;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, 0, 0, 0)];
    [UIConfiguration setView:nameLabel x:nameX];
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    
    // score
    CGFloat scoreX = CGRectGetMaxX(self.nameLabel.frame) + SCORE_LEFT_MARGIN;
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(scoreX, 0, 0, 0)];
    [self.scoreLabel setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR]];
    [self.scoreLabel.layer setCornerRadius:8.0f];
    [self.scoreLabel setTextAlignment:NSTextAlignmentCenter];
    [self.scoreLabel setClipsToBounds:YES];
    [self.scoreLabel setHidden:YES];
    [self addSubview:self.scoreLabel];
    
    // tags
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < TAGS_COUNT; ++i) {
      UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
      [label setBackgroundColor:[UIConfiguration colorForHex:TAG_BACKGROUND_COLOR]];
      [label setClipsToBounds:YES];
      [label setTextAlignment:NSTextAlignmentCenter];
      [label.layer setCornerRadius:4];
      
      [tempArray addObject:label];
      [label setHidden:YES];
      [self addSubview:label];
    }
    self.tagLabelsArray = [tempArray copy];
    
    // seperator line
    CGFloat seperatorY = self.frame.size.height - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.frame.size.width, GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT)];
    [seperator setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_SEPERATOR_COLOR]];
    
    self.seperator = seperator;
    [self addSubview:seperator];
  }
  return self;
}

- (void)configWithPlayerInfo:(SimpleGeekerInfo *)geekerInfo
                   isSponsor:(BOOL)isSponsor
{
  // avatar
  if (geekerInfo.avatarURL) {
    [self.avatarView setImageWithURL:[NSURL URLWithString:geekerInfo.avatarURL]];
  }
  else {
    [self.avatarView setImage:nil];
  }
  
  // sponsor
  if (isSponsor) {
    [self.sponsorView setHidden:NO];
  }
  else {
    [self.sponsorView setHidden:YES];
  }
  
  // name
  [self.nameLabel setText:geekerInfo.name];
  [self.nameLabel setTextColor:[UIColor whiteColor]];
  [self.nameLabel setFont:[UIFont fontWithName:GAME_INFO_CELL_FONT_NAME size:NAME_FONT_SIZE]];
  [self.nameLabel sizeToFit];
  
  [UIConfiguration moveSubviewYToSuperviewCenter:self subview:self.nameLabel];
  
  CGFloat rightMost = CGRectGetMaxX(self.nameLabel.frame);
  
  // score
  if (geekerInfo.score) {
    [self.scoreLabel setText:geekerInfo.score];
    [self.scoreLabel setTextColor:[UIColor whiteColor]];
    [self.scoreLabel setFont:[UIFont fontWithName:GAME_INFO_CELL_FONT_NAME size:NAME_FONT_SIZE]];
    [self.scoreLabel sizeToFit];
    
    CGFloat scoreX = rightMost + SCORE_LEFT_MARGIN;
    CGFloat scoreWidth = self.scoreLabel.frame.size.width + SCORE_PLUS_WIDTH;
    [UIConfiguration setView:self.scoreLabel x:scoreX];
    [UIConfiguration setView:self.scoreLabel width:scoreWidth];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:self.scoreLabel];
    
    [self.scoreLabel setHidden:NO];
    
    rightMost = CGRectGetMaxX(self.scoreLabel.frame);
  }
  else {
    [self.scoreLabel setHidden:YES];
  }
  
  // tags
  for (UILabel *label in self.tagLabelsArray) {
    [label setHidden:YES];
  }
  
  CGFloat xLimit = self.frame.size.width - CELL_RIGHT_MARGIN;
  if (geekerInfo.tagsArray) {
    int i = 0;
    for (GeekerTag *tag in geekerInfo.tagsArray) {
      if (i == TAGS_COUNT) {
        break;
      }
      
      UILabel *label = self.tagLabelsArray[i];
      NSMutableString *text = [NSMutableString stringWithString:tag.tagName];
      if (tag.up != 0) {
        [text appendString:[NSString stringWithFormat:@" %d", tag.up]];
      }
      [label configWithText:text
                  textColor:[UIColor whiteColor]
                       font:[UIFont fontWithName:GAME_INFO_CELL_FONT_NAME size:TAG_FONT_SIZE]
              numberOfLines:1];
      CGFloat leftMargin = i == 0 ? TAGS_LEFT_MARGIN : TAGS_INTERAL_MARGIN;
      CGFloat labelX = rightMost + leftMargin;
      CGFloat labelWidth = label.frame.size.width + TAG_PLUS_WIDTH;
      [UIConfiguration setView:label x:labelX];
      [UIConfiguration setView:label size:CGSizeMake(labelWidth, TAG_HEIGHT)];
      [UIConfiguration moveSubviewYToSuperviewCenter:self subview:label];
      
      rightMost = CGRectGetMaxX(label.frame);
      if (rightMost > xLimit) {
        break;
      }
      [label setHidden:NO];
      
      ++i;
    }
  }
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
