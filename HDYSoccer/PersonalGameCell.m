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
#define AVATAR_LEFT_MARGIN 0
#define AVATAR_TOP_MARGIN 7

// PARTICIPANT
#define PARTICIPANT_LEFT_MARGIN 10
#define PARTICIPANT_RIGHT_MARGIN 10
#define PARTICIPANT_WIDTH 35
#define PARTICIPANT_BOTTOM_MARGIN 3

// FIELD
#define FIELD_LEFT_MARGIN 10
#define FIELD_BOTTOM_MARGIN PARTICIPANT_BOTTOM_MARGIN

// SCORE
#define SCORE_TOP_MARGIN FIELD_BOTTOM_MARGIN
#define SCORE_LEFT_MARGIN FIELD_LEFT_MARGIN

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
    [self addSubview:distanceLabel];
    
    // AVATAR
    CGFloat avatarX = DISTANCE_BACK_WIDTH + AVATAR_LEFT_MARGIN;
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
    
    UILabel *fieldLabel = [[UILabel alloc] initWithFrame:CGRectMake(FIELD_LEFT_MARGIN, fieldBackHeight / 3, 0, 0)];
    [fieldLabel setTextColor:[UIColor blackColor]];
    [fieldLabel setFont:[UIFont systemFontOfSize:15]];
    
    self.fieldLabel = fieldLabel;
    [fieldBackView addSubview:fieldLabel];
    
    // PARTICIPANT
    CGFloat participantX = CGRectGetMaxX(fieldLabel.frame) + PARTICIPANT_LEFT_MARGIN;
    UILabel *participantLabel = [[UILabel alloc] initWithFrame:CGRectMake(participantX, 0, 0, 0)];
    [participantLabel setTextColor:[UIColor lightGrayColor]];
    [participantLabel setFont:[UIFont systemFontOfSize:12]];
    
    self.participantNumberLabel = participantLabel;
    [fieldBackView addSubview:participantLabel];
   
    // SCORE
    CGFloat scoreBackX = fieldBackX;
    CGFloat scoreBackY = CGRectGetMaxY(fieldBackView.frame);
    UIView *scoreBackView = [[UIView alloc] initWithFrame:CGRectMake(scoreBackX, scoreBackY, fieldBackWidth, fieldBackHeight)];
    
    self.scoreBackView = scoreBackView;
    [self addSubview:scoreBackView];
    
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(SCORE_TOP_MARGIN, SCORE_LEFT_MARGIN, 0, 0)];
    [scoreLabel setTextAlignment:NSTextAlignmentLeft];
    [scoreLabel setFont:[UIFont systemFontOfSize:13]];
    [scoreLabel setTextColor:[UIColor grayColor]];
    
    self.averageScoreLabel = scoreLabel;
    [scoreBackView addSubview:scoreLabel];
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
  [self.fieldLabel sizeToFit];
  
  CGFloat fieldWidth = self.fieldBackView.bounds.size.width
  - FIELD_LEFT_MARGIN - PARTICIPANT_LEFT_MARGIN
  - PARTICIPANT_WIDTH - PARTICIPANT_RIGHT_MARGIN;
  CGFloat fieldY = self.fieldBackView.frame.size.height - FIELD_BOTTOM_MARGIN - self.fieldLabel.frame.size.height;
  if (self.fieldLabel.frame.size.width > fieldWidth) {
    [UIConfiguration setView:self.fieldLabel width:fieldWidth];
  }
  [UIConfiguration setView:self.fieldLabel y:fieldY];
  
  // PARTICIPANT
  NSMutableString *participantsStr = [NSMutableString string];
  [participantsStr appendString:gameInfo.participantsNumber];
  if ([Tools isNilOrEmpty:gameInfo.totalNumberLimit] == NO) {
    [participantsStr appendString:[NSString stringWithFormat:@"/%@", gameInfo.totalNumberLimit]];
  }
  
  [self.participantNumberLabel setText:participantsStr];
  [self.participantNumberLabel sizeToFit];
  
  CGFloat participantY = self.fieldBackView.frame.size.height - PARTICIPANT_BOTTOM_MARGIN - self.participantNumberLabel.frame.size.height;
  CGFloat participantX = CGRectGetMaxX(self.fieldLabel.frame) + PARTICIPANT_LEFT_MARGIN;
  [UIConfiguration setView:self.participantNumberLabel origin:CGPointMake(participantX, participantY)];
  [UIConfiguration setView:self.participantNumberLabel width:PARTICIPANT_WIDTH];
  
  // SCORE
  if ([Tools isNilOrEmpty:gameInfo.averageScore] == NO) {
    NSString *scoreText = [NSString stringWithFormat:TEXT_GAME_AVERAGE_SCORE_TITLE, gameInfo.averageScore];
    [self.averageScoreLabel setText:scoreText];
    [self.averageScoreLabel sizeToFit];
    
    [UIConfiguration setView:self.averageScoreLabel origin:CGPointMake(SCORE_LEFT_MARGIN, SCORE_TOP_MARGIN)];
  }
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
