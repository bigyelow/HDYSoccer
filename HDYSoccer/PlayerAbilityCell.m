//
//  PlayerAbilityCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/14/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "PlayerAbilityCell.h"
#import "GeekerAbility.h"
#import "UILabel+Customize.h"
#import "UICountingLabel.h"

// TITLE
#define TITLE_LEFT_MARGIN 10

// SCORE
#define SCORE_BAR_RIGHT_MARGIN 50
#define SCORE_BAR_TOP_MARGIN 1
#define SCORE_BAR_WIDTH 175
#define SCORE_BAR_BACKGOURND_COLOR @"#DADADA"

#define SCORE_RIGHT_MARGIN 20

// ANIMATION
#define SCORE_ANIMATION_DURATION 2

@implementation PlayerAbilityCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [UIConfiguration setView:self height:PLAYER_ABILITY_CELL_HEIGHT];
    
    // NAME
    UILabel *abilityNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LEFT_MARGIN, 0, 0, 0)];
    [abilityNameLabel setTextAlignment:NSTextAlignmentLeft];
    
    self.abilityNameLabel = abilityNameLabel;
    [self addSubview:abilityNameLabel];
    
    // SCORE BAR
    CGFloat scoreBackHeight = self.frame.size.height - 2 * SCORE_BAR_TOP_MARGIN;
    CGFloat scoreBackX = self.frame.size.width - SCORE_BAR_RIGHT_MARGIN - SCORE_BAR_WIDTH;
    UIView *scoreBackView = [[UIView alloc] initWithFrame:CGRectMake(scoreBackX, SCORE_BAR_TOP_MARGIN, SCORE_BAR_WIDTH, scoreBackHeight)];
    [scoreBackView setBackgroundColor:[UIConfiguration colorForHex:SCORE_BAR_BACKGOURND_COLOR]];
    
    [self addSubview:scoreBackView];
    
    CGRect scoreFrontRect = CGRectMake(scoreBackX, SCORE_BAR_TOP_MARGIN, 0, scoreBackHeight);
    UIView *scoreFrontView = [[UIView alloc] initWithFrame:scoreFrontRect];
    [scoreFrontView setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR]];
    
    self.scoreBar = scoreFrontView;
    [self addSubview:scoreFrontView];
    
    // SCORE
    CGFloat scoreX = self.frame.size.width - SCORE_RIGHT_MARGIN;
    UICountingLabel *scoreLabel = [[UICountingLabel alloc] initWithFrame:CGRectMake(scoreX, 0, 0, 0)];
    scoreLabel.format = @"%d";
    [scoreLabel setTextAlignment:NSTextAlignmentRight];
    [scoreLabel configWithText:@"100"
                     textColor:[UIConfiguration colorForHex:SCORE_BAR_BACKGOURND_COLOR]
                          font:[UIFont systemFontOfSize:15]
                 numberOfLines:1];

    self.scoreLabel = scoreLabel;
    [self addSubview:scoreLabel];
    
  }
  return self;
}

- (void)configCellWithAbilityName:(NSString *)abilityName
                     abilityScore:(NSInteger)abilityScore
                        animation:(BOOL)animation
{
  // NAME
  [self.abilityNameLabel configWithText:abilityName
                              textColor:[UIColor blackColor]
                                   font:[UIFont systemFontOfSize:15]
                          numberOfLines:1];
  [UIConfiguration moveSubviewYToSuperviewCenter:self subview:self.abilityNameLabel];
  
  // SCORE LABEL
  CGFloat scoreX = self.frame.size.width - SCORE_RIGHT_MARGIN - self.scoreLabel.frame.size.width;
  [UIConfiguration setView:self.scoreLabel x:scoreX];
  [UIConfiguration moveSubviewYToSuperviewCenter:self subview:self.scoreLabel];
  
  // SCORE
  if (animation) {
    __weak typeof(self) weakSelf = self;
    
    [self.scoreLabel setCompletionBlock:^{
      [weakSelf.scoreLabel setTextColor:[weakSelf colorForScore:abilityScore]];
    }];
    [self.scoreLabel countFrom:0 to:abilityScore withDuration:SCORE_ANIMATION_DURATION];
    
    // SCORE BAR
    CGFloat scoreBarWidth = 0;
    [UIConfiguration setView:self.scoreBar width:scoreBarWidth];

    [UIView animateWithDuration:SCORE_ANIMATION_DURATION
                     animations:^{
                       CGFloat scoreBarWidth = (CGFloat)abilityScore / 100 * SCORE_BAR_WIDTH;
                       [UIConfiguration setView:weakSelf.scoreBar width:scoreBarWidth];
                     }];
  }
  else {
    // SCORE BAR
    CGFloat scoreBarWidth = (CGFloat)abilityScore / 100 * SCORE_BAR_WIDTH;
    [UIConfiguration setView:self.scoreBar width:scoreBarWidth];
    
    // SCORE LABEL
    [self.scoreLabel setTextColor:[self colorForScore:abilityScore]];
    [self.scoreLabel setText:[NSString stringWithFormat:@"%ld", (long)abilityScore]];
  }
}

- (UIColor *)colorForScore:(NSInteger)score
{
  if (score >= kScoreGradeTop) {
    return [UIConfiguration colorForHex:SCORE_TOP_COLOR];
  }
  else if (score >= kScoreGradeMiddle) {
    return [UIConfiguration colorForHex:SCORE_MIDDLE_COLOR];
  }
  else {
    return [UIConfiguration colorForHex:SCORE_BOTTOM_COLOR];
  }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
