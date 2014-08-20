//
//  RatePlayerCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/1/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "RatePlayerCell.h"
#import "ParticipantsScore.h"
#import "UIImageView+WebCache.h"
#import "RatePlayerHeaderView.h"
#import "GeekerTag.h"
#import "UILabel+Customize.h"

// seperator
#define SEPERATOR_HEIGHT 0.5
#define SEPERATOR_COLOR @"#e6e6e6"
#define SEPERATOR_SIDE_MARGIN 10.0F

// rank
#define RANK_TOP_MARGIN 5.0F

// avatar
#define SPONSOR_BORDER_COLOR @"#cc0000"

// name
#define NAME_FONT_SIZE 14.0F
#define RATE_CELL_FONT_NAME @"Verdana"

// score
#define SCORE_TOP_MARGIN 5.0F
#define NO_SCORE_COLOR @"D5D5D5"

// tag
#define TAG_NUMBER_LIMIT 3
#define TAG_BACKGROUND_COLOR @"#37ae84"
#define TAG_FONT_SIZE 12
#define TAGS_LEFT_MARGIN 15
#define TAGS_INTERAL_MARGIN 3.0F
#define TAG_PLUS_WIDTH 10
#define TAG_TOP_MARGIN 4

// rate
#define RATE_LEFT_MARGIN 5.0F
#define RATE_TOP_MARGIN 5.0F
#define RATE_ENABLE_COLOR @"#ff8000"

@implementation RatePlayerCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [UIConfiguration setView:self height:RATE_PLAYER_CELL_HEIGHT];
    
    // seperator
    CGFloat seperatorWidth = self.frame.size.width - 2 * SEPERATOR_SIDE_MARGIN;
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(SEPERATOR_SIDE_MARGIN, 0, seperatorWidth, SEPERATOR_HEIGHT)];
    [seperator setBackgroundColor:[UIConfiguration colorForHex:SEPERATOR_COLOR]];
    
    [self addSubview:seperator];
    
    // rank
    CGFloat rankWidth = [RatePlayerHeaderView rankWidth];
    CGFloat rankHeight = self.frame.size.height - 2 * RANK_TOP_MARGIN;
    UILabel *rankLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, rankWidth, rankHeight)];
    
    self.rankLabel = rankLabel;
    [self addSubview:rankLabel];
    
    // avatar
    CGFloat avatarHeight = RATE_PLAYER_CELL_HEIGHT - 2 * RATE_PLAYER_CELL_AVATAR_TOP_MARGIN;
    CGFloat avatarX = rankWidth + RATE_PLAYER_CELL_AVATAR_LEFT_MARGIN;
    UIImageView *avatarView = [[UIImageView alloc]
                               initWithFrame:CGRectMake(avatarX, RATE_PLAYER_CELL_AVATAR_TOP_MARGIN, avatarHeight, avatarHeight)];
    avatarView.layer.cornerRadius = 3.0f;
    avatarView.layer.borderColor = [UIColor whiteColor].CGColor;
    avatarView.layer.borderWidth = 1.0f;
    avatarView.clipsToBounds = YES;
    
    self.avatarView = avatarView;
    [self addSubview:avatarView];
    
    // name
    CGFloat nameX = CGRectGetMaxX(self.avatarView.frame) + RATE_PLAYER_CELL_NAME_LEFT_MARGIN;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, 0, 0, 0)];
    [UIConfiguration setView:nameLabel x:nameX];
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    
    // score
    CGFloat scoreX = [RatePlayerHeaderView rankWidth] + [RatePlayerHeaderView IDWidth];
    CGFloat scoreWidth = [RatePlayerHeaderView scoreWidth];
    CGFloat scoreHeight = self.frame.size.height - 2 * SCORE_TOP_MARGIN;
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(scoreX, 0, scoreWidth, scoreHeight)];
    
    self.scoreLabel = scoreLabel;
    [self addSubview:scoreLabel];
    
    // tags
    CGFloat tagX = CGRectGetMaxX(scoreLabel.frame);
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < TAG_NUMBER_LIMIT; ++i) {
      UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(tagX, 0, 0, 0)];
      [label setBackgroundColor:[UIConfiguration colorForHex:TAG_BACKGROUND_COLOR]];
      [label setClipsToBounds:YES];
      [label setTextAlignment:NSTextAlignmentCenter];
      [label.layer setCornerRadius:11];
      [label setHidden:YES];
      
      [self addSubview:label];
      [tempArray addObject:label];
    }
    self.tagsArray = [tempArray copy];
    
    // can rate
    CGFloat rateX = self.frame.size.width - [RatePlayerHeaderView rateWidth] + RATE_LEFT_MARGIN;
    CGFloat rateWidth = [RatePlayerHeaderView rateWidth] - 2 * RATE_LEFT_MARGIN;
    CGFloat rateHeight = self.frame.size.height - 2 * RATE_TOP_MARGIN;
    UILabel *rateLabel = [[UILabel alloc] initWithFrame:CGRectMake(rateX, RATE_TOP_MARGIN, rateWidth, rateHeight)];
    [rateLabel setText:TEXT_RATE];
    [rateLabel setFont:[UIFont systemFontOfSize:12.0f]];
    [rateLabel setTextColor:[UIColor whiteColor]];
    [rateLabel setTextAlignment:NSTextAlignmentCenter];
    [rateLabel setClipsToBounds:YES];
    [rateLabel.layer setCornerRadius:5.0];
    
    self.rateLabel = rateLabel;
    [self addSubview:rateLabel];
  }
  return self;
}

#define HIGH_SCORE_COLOR @"#ff5500"

- (void)configWithPlayerInfo:(ParticipantsScore *)scoreInfo
{
  // avatar
  if (scoreInfo.avatarURL) {
    [self.avatarView setImageWithURL:[NSURL URLWithString:scoreInfo.avatarURL]];
  }
  else {
    [self.avatarView setImage:nil];
  }
  
  // rank
  [self configLabel:self.rankLabel text:[NSString stringWithFormat:@"%d", scoreInfo.thisRank] sizeToFit:NO];

  // name
  [self configLabel:self.nameLabel text:scoreInfo.name sizeToFit:YES];
  CGFloat nameRightLimit = CGRectGetMaxX(self.rankLabel.frame) + [RatePlayerHeaderView IDWidth];
  if (CGRectGetMaxX(self.nameLabel.frame) > nameRightLimit) {
    CGFloat width = nameRightLimit - CGRectGetMaxX(self.avatarView.frame) - RATE_PLAYER_CELL_NAME_LEFT_MARGIN;
    [UIConfiguration setView:self.nameLabel width:width];
  }
  
  // score
  NSString *scoreStr;
  CGFloat scoreFloat = scoreInfo.thisScore;
  UIColor *scoreColor;
  if (scoreFloat == NO_VALUE_FOR_FLOAT) {
    scoreStr = TEXT_NONE;
    scoreColor = [UIConfiguration colorForHex:NO_SCORE_COLOR];
  }
  else if (scoreFloat < 7.0) {
    scoreStr = [NSString stringWithFormat:@"%.1f", scoreFloat];
    scoreColor = [UIColor blackColor];
  }
  else {
    scoreStr = [NSString stringWithFormat:@"%.1f", scoreFloat];
    scoreColor = [UIConfiguration colorForHex:HIGH_SCORE_COLOR];
  }
  [self configLabel:self.scoreLabel text:scoreStr textColor:scoreColor sizeToFit:NO];
  
  // rate label
  if (scoreInfo.canRate) {
    [self.rateLabel setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR]];
  }
  else {
    [self.rateLabel setBackgroundColor:[UIConfiguration colorForHex:NO_SCORE_COLOR]];
  }

  // tags
  CGFloat rightMost = CGRectGetMaxX(self.scoreLabel.frame);
  CGFloat xLimit = self.frame.size.width - [RatePlayerHeaderView rateWidth];
  
  for (UILabel *label in self.tagsArray) {
    [label setHidden:YES];
  }
  
  if (scoreInfo.thisTags) {
    int i = 0;
    for (GeekerTag *tag in scoreInfo.thisTags) {
      if (i == TAG_NUMBER_LIMIT)
        break;
      
      UILabel *label = self.tagsArray[i];
      NSMutableString *text = [NSMutableString stringWithString:tag.tagName];
      if (tag.up != 0) {
        [text appendString:[NSString stringWithFormat:@"%d", tag.up]];
      }
      [label configWithText:text
                  textColor:[UIColor whiteColor]
                       font:[UIFont fontWithName:RATE_CELL_FONT_NAME size:TAG_FONT_SIZE]
              numberOfLines:1];
      
      CGFloat leftMargin = i == 0 ? TAGS_LEFT_MARGIN : TAGS_INTERAL_MARGIN;
      CGFloat labelX = rightMost + leftMargin;
      CGFloat labelWidth = label.frame.size.width + TAG_PLUS_WIDTH;
      CGFloat labelHeight = self.frame.size.height - 2 * TAG_TOP_MARGIN;
      [UIConfiguration setView:label x:labelX];
      [UIConfiguration setView:label size:CGSizeMake(labelWidth, labelHeight)];
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

- (void)configLabel:(UILabel *)label
               text:(NSString *)text
          sizeToFit:(BOOL)sizeToFit
{
  [self configLabel:label text:text textColor:[UIColor blackColor] sizeToFit:sizeToFit];
}

- (void)configLabel:(UILabel *)label
               text:(NSString *)text
          textColor:(UIColor *)textColor
          sizeToFit:(BOOL)sizeToFit
{
  [label setText:text];
  [label setTextColor:textColor];
  [label setFont:[UIFont fontWithName:RATE_CELL_FONT_NAME size:NAME_FONT_SIZE]];
  [label setTextAlignment:NSTextAlignmentCenter];
  if (sizeToFit) {
    [label sizeToFit];
  }
  [UIConfiguration moveSubviewYToSuperviewCenter:self subview:label];
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
