//
//  PersonalGameCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/20/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "PersonalGameCell.h"
#import "SimplePersonalGameInfo.h"
#import "UIImageView+WebCache.h"

// DISTANCE
#define DISTANCE_BACK_WIDTH (self.frame.size.width / 7)
#define DISTANCE_LEFT_MARGIN 1
#define DISTANCE_WIDTH (DISTANCE_BACK_WIDTH - 2 * DISTANCE_LEFT_MARGIN)

// AVATAR
#define AVATAR_LEFT_MARGIN 10
#define AVATAR_TOP_MARGIN 7

// FIELD
#define FIELD_LEFT_MARGIN 10
#define FIELD_BOTTOM_MARGIN PARTICIPANT_BOTTOM_MARGIN
#define FIELD_HEIGHT 15

// SCORE
#define SCORE_TOP_MARGIN FIELD_BOTTOM_MARGIN
#define SCORE_LEFT_MARGIN FIELD_LEFT_MARGIN
#define SCORE_WIDTH 20
#define SCORE_HEIGHT 20

// PARTICIPANT
#define PARTICIPANT_LEFT_MARGIN 5
#define PARTICIPANT_RIGHT_MARGIN 10
#define PARTICIPANT_WIDTH 35
#define PARTICIPANT_BOTTOM_MARGIN 2
#define PARTICIPANT_HEIGHT SCORE_HEIGHT

// TIME
#define TIME_LEF_MARGIN PARTICIPANT_LEFT_MARGIN
#define TIME_WIDTH 100
#define TIME_HEIGHT SCORE_HEIGHT

@implementation PersonalGameCell

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIColor whiteColor]];
    
    // DISTANCE
    UILabel *distanceLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, frame.size.height / 2, 0, 0)];
    [distanceLabel setTextColor:[UIColor lightGrayColor]];
    [distanceLabel setFont:[UIFont systemFontOfSize:11]];
    [distanceLabel setTextAlignment:NSTextAlignmentCenter];
    
    self.distanceLabel = distanceLabel;
//    [self addSubview:distanceLabel];
    
    // AVATAR
    CGFloat avatarX = AVATAR_LEFT_MARGIN;
    CGFloat avatarWidht = frame.size.height - 2 * AVATAR_TOP_MARGIN;
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(avatarX, AVATAR_TOP_MARGIN, avatarWidht, avatarWidht)];
    [avatar.layer setCornerRadius:5];
    [avatar setClipsToBounds:YES];

    self.avatar = avatar;
    [self addSubview:avatar];
    
    // FIELD
    CGFloat fieldBackX = CGRectGetMaxX(avatar.frame);
    CGFloat fieldBackHeight = frame.size.height / 2;
    CGFloat fieldBackWidth = frame.size.width - fieldBackX;
    UIView *fieldBackView = [[UIView alloc] initWithFrame:CGRectMake(fieldBackX, 0, fieldBackWidth, fieldBackHeight)];
    
    self.fieldBackView = fieldBackView;
    [self addSubview:fieldBackView];
    
    CGFloat fieldY = self.fieldBackView.frame.size.height - FIELD_BOTTOM_MARGIN - FIELD_HEIGHT;
    UILabel *fieldLabel = [[UILabel alloc] initWithFrame:CGRectMake(FIELD_LEFT_MARGIN, fieldY, fieldBackWidth, FIELD_HEIGHT)];
    [fieldLabel setTextColor:[UIColor blackColor]];
    [fieldLabel setFont:[UIFont systemFontOfSize:15]];
    
    self.fieldLabel = fieldLabel;
    [fieldBackView addSubview:fieldLabel];
   
    // SCORE
    CGFloat scoreBackX = fieldBackX;
    CGFloat scoreBackY = CGRectGetMaxY(fieldBackView.frame);
    UIView *scoreBackView = [[UIView alloc] initWithFrame:CGRectMake(scoreBackX, scoreBackY, fieldBackWidth, fieldBackHeight)];
    
    self.scoreBackView = scoreBackView;
    [self addSubview:scoreBackView];
    
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCORE_LEFT_MARGIN, SCORE_TOP_MARGIN, SCORE_WIDTH, SCORE_HEIGHT)];
    [scoreLabel setTextAlignment:NSTextAlignmentLeft];
    [scoreLabel setFont:[UIFont systemFontOfSize:13]];
    [scoreLabel setTextColor:[UIColor grayColor]];
    
    self.averageScoreLabel = scoreLabel;
    [scoreBackView addSubview:scoreLabel];
    
    // PARTICIPANT
    CGFloat participantX = CGRectGetMaxX(scoreLabel.frame) + PARTICIPANT_LEFT_MARGIN;
    UILabel *participantLabel = [[UILabel alloc] initWithFrame:CGRectMake(participantX, SCORE_TOP_MARGIN, PARTICIPANT_WIDTH, PARTICIPANT_HEIGHT)];
    [participantLabel setTextColor:[UIColor grayColor]];
    [participantLabel setTextAlignment:NSTextAlignmentLeft];
    [participantLabel setFont:[UIFont systemFontOfSize:13]];
    
    self.participantNumberLabel = participantLabel;
    [scoreBackView addSubview:participantLabel];
    
    // TIME
    CGFloat timeX = CGRectGetMaxX(participantLabel.frame) + TIME_LEF_MARGIN;
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeX, SCORE_TOP_MARGIN, TIME_WIDTH, TIME_HEIGHT)];
    [timeLabel setTextColor:[UIColor grayColor]];
    [timeLabel setTextAlignment:NSTextAlignmentLeft];
    [timeLabel setFont:[UIFont systemFontOfSize:13]];
    
    self.timeLabel = timeLabel;
//    [scoreBackView addSubview:timeLabel];
  }
  return self;
}

- (void)configCellWithGameInfo:(SimplePersonalGameInfo *)gameInfo
{
  // DISTANCE
  NSString *distanceStr = [NSString stringWithFormat:@"%@km", gameInfo.distance];
  [self.distanceLabel setText:distanceStr];
  [self.distanceLabel sizeToFit];
  
  [UIConfiguration setView:self.distanceLabel width:DISTANCE_WIDTH];
  
  CGFloat centerX = DISTANCE_BACK_WIDTH / 2;
  CGFloat centerY = self.frame.size.height / 2;
  [self.distanceLabel setCenter:CGPointMake(centerX, centerY)];
  
  // AVATAR
  [self.avatar setImageWithURL:[NSURL URLWithString:gameInfo.avatarURL]];
  
  // FIELD
  [self.fieldLabel setText:gameInfo.field];
  
  // SCORE
  if ([Tools isNilOrEmpty:gameInfo.averageScore] == NO) {
    NSString *scoreText = [NSString stringWithFormat:TEXT_GAME_AVERAGE_SCORE_TITLE, gameInfo.averageScore];
    [self.averageScoreLabel setText:scoreText];
  }
  
  // PARTICIPANT
  NSMutableString *participantsStr = [NSMutableString string];
  [participantsStr appendString:gameInfo.participantsNumber];
  if ([Tools isNilOrEmpty:gameInfo.totalNumberLimit] == NO) {
    [participantsStr appendString:[NSString stringWithFormat:@"/%@", gameInfo.totalNumberLimit]];
  }
  
  [self.participantNumberLabel setText:participantsStr];
  
  // TIME
  NSString *time = [Tools dateminuteToStr:gameInfo.time preferUTC:NO];
  time = [time substringFromIndex:5];
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
