//
//  RatePlayerCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/1/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "RatePlayerCell.h"
#import "SimpleGeekerInfo.h"
#import "UIImageView+WebCache.h"
#import "RatePlayerHeaderView.h"

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

// tag
#define TAG_NUMBER_LIMIT 2
#define TAG_BACKGROUND_COLOR @"#37ae84"

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
      [label.layer setCornerRadius:4];
      [label setHidden:YES];
      
      [self addSubview:label];
      [tempArray addObject:label];
    }
    self.tagsArray = [tempArray copy];
  }
  return self;
}

#define HIGH_SCORE_COLOR @"#ff5500"

- (void)configWithPlayerInfo:(SimpleGeekerInfo *)geekerInfo
{
  // avatar
  if (geekerInfo.avatarURL) {
    [self.avatarView setImageWithURL:[NSURL URLWithString:geekerInfo.avatarURL]];
  }
  else {
    [self.avatarView setImage:nil];
  }
  
  // rank
  [self configLabel:self.rankLabel text:@"9" sizeToFit:NO];

  // name
  [self configLabel:self.nameLabel text:geekerInfo.name sizeToFit:YES];
  CGFloat nameRightLimit = CGRectGetMaxX(self.rankLabel.frame) + [RatePlayerHeaderView IDWidth];
  if (CGRectGetMaxX(self.nameLabel.frame) > nameRightLimit) {
    CGFloat width = nameRightLimit - CGRectGetMaxX(self.avatarView.frame) - RATE_PLAYER_CELL_NAME_LEFT_MARGIN;
    [UIConfiguration setView:self.nameLabel width:width];
  }
  
  // score
  NSString *score = @"/";
  [self configLabel:self.scoreLabel text:score sizeToFit:NO];
  if ([score isEqualToString:TEXT_NONE]) {
    [self.scoreLabel setTextColor:[UIConfiguration colorForHex:@"#d5d5d5"]];
  }
  else if (score.integerValue >= 7) {
    [self.scoreLabel setTextColor:[UIConfiguration colorForHex:HIGH_SCORE_COLOR]];
  }
  
  // tags
  for (UILabel *label in self.tagsArray) {
    [label setHidden:YES];
  }
  
  NSArray *tags = @[@{@"tag_name":@"高质量短传",@"up":@"8"},@{@"tag_name":@"优质盘带",@"up":@"9"}];
  
  
}

- (void)configLabel:(UILabel *)label
               text:(NSString *)text
          sizeToFit:(BOOL)sizeToFit
{
  [label setText:text];
  [label setTextColor:[UIColor blackColor]];
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
