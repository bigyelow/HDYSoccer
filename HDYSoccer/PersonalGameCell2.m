//
//  PersonalGameCell2.m
//  HDYSoccer
//
//  Created by bigyelow on 9/1/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "PersonalGameCell2.h"
#import "SimplePersonalGameInfo.h"
#import "UIImageView+WebCache.h"

// CONTENT
#define CONTENT_HEIGHT 70

// FOOTER
#define FOOTER_HEIGHT (PERSONAL_GAEM_CELL2_HEIGHT - CONTENT_HEIGHT)

// AVATAR
#define AVATAR_LEFT_MARGIN 10
#define AVATAR_TOP_MARGIN 7

// FIELD
#define FIELD_LEFT_MARGIN 10
#define FIELD_HEIGHT 17
#define FIELD_BOTTOM_MARGIN 0
#define FIELD_RIGHT_MARGIN 5

// SCORE
#define SCORE_TOP_MARGIN 4
#define SCORE_LEFT_MARGIN 11
#define SCORE_HEIGHT 14
#define SCORE_WIDTH 20

// MEMBER
#define MEMBER_LEFT_MARGIN 5
#define MEMBER_HEIGHT SCORE_HEIGHT
#define MEMBER_WIDTH 40

// FOOTER SEPERATOR
#define SEPER_LEFT_MARGIN (AVATAR_LEFT_MARGIN - 2)
#define SEPER_HEIGHT 0.5

// DISTANCE
#define DISTANCE_LEFT_MARGIN AVATAR_LEFT_MARGIN
#define DISTANCE_TOP_MARGIN 4
#define DISTANCE_WIDTH 100
#define DISTANCE_HEIGHT (FOOTER_HEIGHT - 2 * DISTANCE_TOP_MARGIN)

// TIME
#define TIME_RIGHT_MARGIN 10
#define TIME_WIDTH 100

@implementation PersonalGameCell2

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIColor whiteColor]];

    // CONTENT
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, CONTENT_HEIGHT)];
    
    [self addSubview:contentView];
    
    // AVATAR
    CGFloat avatarX = AVATAR_LEFT_MARGIN;
    CGFloat avatarWidht = CONTENT_HEIGHT - 2 * AVATAR_TOP_MARGIN;
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(avatarX, AVATAR_TOP_MARGIN, avatarWidht, avatarWidht)];
    [avatar.layer setCornerRadius:5];
    [avatar setClipsToBounds:YES];
    
    self.avatar = avatar;
    [self addSubview:avatar];
    
    // FIELD
    CGFloat fieldX = CGRectGetMaxX(avatar.frame) + FIELD_LEFT_MARGIN;
    CGFloat fieldY = CONTENT_HEIGHT / 2 - FIELD_BOTTOM_MARGIN - FIELD_HEIGHT;
    CGFloat fieldWidth = frame.size.width - fieldX - FIELD_RIGHT_MARGIN;
    CGRect fieldRect = CGRectMake(fieldX, fieldY, fieldWidth, FIELD_HEIGHT);
    UILabel *fieldLabel = [UIConfiguration labelWithFrame:fieldRect
                                                textColor:[UIColor blackColor]
                                                     font:[UIFont systemFontOfSize:FIELD_HEIGHT]
                                                alignment:NSTextAlignmentLeft];
    
    self.fieldLabel = fieldLabel;
    [self addSubview:fieldLabel];

    // SCORE
    CGFloat scoreX = CGRectGetMaxX(avatar.frame) + SCORE_LEFT_MARGIN;
    CGFloat scoreY = CONTENT_HEIGHT / 2 + SCORE_TOP_MARGIN;
    UILabel *scoreLabel = [UIConfiguration labelWithFrame:CGRectMake(scoreX, scoreY, SCORE_WIDTH, SCORE_HEIGHT)
                                                textColor:[UIColor grayColor]
                                                     font:[UIFont systemFontOfSize:SCORE_HEIGHT]
                                                alignment:NSTextAlignmentLeft];
    
    self.averageScoreLabel = scoreLabel;
    [self addSubview:scoreLabel];
    
    // MEMBER
    CGFloat memberX = CGRectGetMaxX(scoreLabel.frame) + MEMBER_LEFT_MARGIN;
    UILabel *memberLabel = [UIConfiguration labelWithFrame:CGRectMake(memberX, scoreY, MEMBER_WIDTH, MEMBER_HEIGHT)
                                                 textColor:[UIColor grayColor]
                                                      font:[UIFont systemFontOfSize:MEMBER_HEIGHT]
                                                 alignment:NSTextAlignmentLeft];
    
    self.participantNumberLabel = memberLabel;
    [self addSubview:memberLabel];
    
    // FOOTER
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, CONTENT_HEIGHT, frame.size.width, FOOTER_HEIGHT)];
    
    [self addSubview:footerView];
    
    // SEPER
    UIView *seper = [[UIView alloc] initWithFrame:CGRectMake(SEPER_LEFT_MARGIN, 0, frame.size.width - SEPER_LEFT_MARGIN, SEPER_HEIGHT)];
    [seper setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR_CLEAR]];
    
    [footerView addSubview:seper];
    
    // DISTANCE
    UILabel *distanceLabel = [UIConfiguration labelWithFrame:CGRectMake(DISTANCE_LEFT_MARGIN, DISTANCE_TOP_MARGIN, DISTANCE_WIDTH, DISTANCE_HEIGHT)
                                                   textColor:[UIColor lightGrayColor]
                                                        font:[UIFont systemFontOfSize:DISTANCE_HEIGHT]
                                                   alignment:NSTextAlignmentLeft];
    
    self.distanceLabel = distanceLabel;
    [footerView addSubview:distanceLabel];
    
    // TIME
    CGFloat timeX = frame.size.width - TIME_WIDTH - TIME_RIGHT_MARGIN;
    UILabel *timeLabel = [UIConfiguration labelWithFrame:CGRectMake(timeX, DISTANCE_TOP_MARGIN, TIME_WIDTH, DISTANCE_HEIGHT)
                                               textColor:[UIColor lightGrayColor]
                                                    font:[UIFont systemFontOfSize:DISTANCE_HEIGHT]
                                               alignment:NSTextAlignmentCenter];
    
    self.timeLabel = timeLabel;
    [footerView addSubview:timeLabel];
  }
  return self;
}

- (void)configCellWithGameInfo:(SimplePersonalGameInfo *)gameInfo
{
  [self.avatar setImageWithURL:[NSURL URLWithString:gameInfo.avatarURL]];
  [self.fieldLabel setText:gameInfo.field];
  
  NSString *scoreText = [NSString stringWithFormat:TEXT_GAME_AVERAGE_SCORE_TITLE, gameInfo.averageScore];
  [self.averageScoreLabel setText:scoreText];
  
  // PARTICIPANT
  NSMutableString *participantsStr = [NSMutableString string];
  [participantsStr appendString:gameInfo.participantsNumber];
  if ([Tools isNilOrEmpty:gameInfo.totalNumberLimit] == NO) {
    [participantsStr appendString:[NSString stringWithFormat:@"/%@", gameInfo.totalNumberLimit]];
  }
  
  [self.participantNumberLabel setText:participantsStr];
  
  // DISTANCE
  NSString *distanceStr = [NSString stringWithFormat:@"%@km", gameInfo.distance];
  [self.distanceLabel setText:distanceStr];
  
  // TIME
  NSString *time = [Tools dateminuteToStr:gameInfo.time preferUTC:NO];
  [self.timeLabel setText:time];
}
/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
