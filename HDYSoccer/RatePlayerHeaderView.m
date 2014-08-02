//
//  RatePlayerHeaderView.m
//  HDYSoccer
//
//  Created by bigyelow on 8/1/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "RatePlayerHeaderView.h"
#import "RatePlayerCell.h"

#define BACKGROUND_COLOR @"#f3f3f3"
#define TEXT_COLOR @"#9f9f9f"

@implementation RatePlayerHeaderView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIConfiguration colorForHex:BACKGROUND_COLOR]];
    CGFloat labelHeigth = frame.size.height;
    
    // rank
    CGRect rankRect = CGRectMake(0, 0, [[self class] rankWidth], labelHeigth);
    UILabel *rankLabel = [self labelWithFrame:rankRect text:TEXT_RANK];
    
    [self addSubview:rankLabel];
    
    // ID
    CGFloat nameX = CGRectGetMaxX(rankLabel.frame);
    CGRect nameRect = CGRectMake(nameX, 0, [[self class] IDWidth], labelHeigth);
    UILabel *nameLabel = [self labelWithFrame:nameRect text:TEXT_ID];
    
    [self addSubview:nameLabel];
    
    // score
    CGFloat scoreX = CGRectGetMaxX(nameLabel.frame);
    CGRect scoreRect = CGRectMake(scoreX, 0, [[self class] scoreWidth], labelHeigth);
    UILabel *scoreLabel = [self labelWithFrame:scoreRect text:TEXT_SCORE_OF_THIS_GAME];
    
    [self addSubview:scoreLabel];
    
    // tags
    CGFloat tagX = CGRectGetMaxX(scoreLabel.frame);
    CGRect tagRect = CGRectMake(tagX, 0, [[self class] tagWidth:frame.size.width], labelHeigth);
    UILabel *tagLabel = [self labelWithFrame:tagRect text:TEXT_TAGS_GOT];
    [tagLabel setBackgroundColor:[UIColor blueColor]];
    
    [self addSubview:tagLabel];
  }
  return self;
}

- (UILabel *)labelWithFrame:(CGRect)frame
                       text:(NSString *)text
{
  UILabel *label = [[UILabel alloc] initWithFrame:frame];
  [label setText:text];
  [label setTextColor:[UIConfiguration colorForHex:TEXT_COLOR]];
  [label setFont:[UIFont systemFontOfSize:11.0f]];
  [label setTextAlignment:NSTextAlignmentCenter];
  
  return label;
}

+ (CGFloat)rankWidth
{
  return 30.0;
}

+ (CGFloat)rateWidth
{
  return 30.0f;
}

+ (CGFloat)scoreWidth
{
  return 50.0f;
}

+ (CGFloat)IDWidth
{
  CGFloat avatarWidth = RATE_PLAYER_CELL_HEIGHT - 2 * RATE_PLAYER_CELL_AVATAR_TOP_MARGIN;
  CGFloat nameLeftMargin = RATE_PLAYER_CELL_NAME_LEFT_MARGIN;
  return RATE_PLAYER_CELL_AVATAR_LEFT_MARGIN + avatarWidth + nameLeftMargin + 60;
}

+ (CGFloat)tagWidth:(CGFloat)viewWidth
{
  return viewWidth - [self rankWidth] - [self rateWidth] - [self scoreWidth] - [self IDWidth];
}

@end
