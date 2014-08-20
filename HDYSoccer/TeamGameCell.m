//
//  TeamGameCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/20/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "TeamGameCell.h"
#import "SimpleTeamGameInfo.h"
#import "UIImageView+WebCache.h"

// DISTANCE
#define DISTANCE_BACK_WIDTH (self.frame.size.width / 7)
#define DISTANCE_LEFT_MARGIN 1
#define DISTANCE_WIDTH (DISTANCE_BACK_WIDTH - 2 * DISTANCE_LEFT_MARGIN)

// AVATAR
#define AVATAR_LEFT_MARGIN 0
#define AVATAR_TOP_MARGIN 7

// AVERAGE SCORE
#define SCORE_LEFT_MARGIN 10
#define SCORE_RIGHT_MARGIN 10
#define SCORE_WIDTH 35
#define SCORE_BOTTOM_MARGIN 3

// NAME
#define NAME_LEFT_MARGIN 10
#define NAME_BOTTOM_MARGIN SCORE_BOTTOM_MARGIN

// FIELD
#define FIELD_TOP_MARGIN SCORE_BOTTOM_MARGIN
#define FIELD_LEFT_MARGIN NAME_LEFT_MARGIN

@implementation TeamGameCell

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
    
    // TOP BACK VIEW
    CGFloat topBackX = CGRectGetMaxX(avatar.frame);
    CGFloat topBackHeight = frame.size.height / 2;
    CGFloat topBackWidth = frame.size.width - topBackX;
    UIView *topBackView = [[UIView alloc] initWithFrame:CGRectMake(topBackX, 0, topBackWidth, topBackHeight)];
    
    self.topBackView = topBackView;
    [self addSubview:topBackView];
    
    // NAME
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(NAME_LEFT_MARGIN, topBackHeight / 3, 0, 0)];
    [nameLabel setTextColor:[UIColor blackColor]];
    [nameLabel setFont:[UIFont systemFontOfSize:15]];
    
    self.nameLabel = nameLabel;
    [topBackView addSubview:nameLabel];
    
    // SCORE
    CGFloat scoreX = CGRectGetMaxX(nameLabel.frame) + SCORE_LEFT_MARGIN;
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(scoreX, 0, 0, 0)];
    [scoreLabel setTextColor:[UIColor lightGrayColor]];
    [scoreLabel setFont:[UIFont systemFontOfSize:13]];
    
    self.averageScoreLabel = scoreLabel;
    [topBackView addSubview:scoreLabel];
    
    // SEPERATOR
    CGFloat seperHeight = 1;
    CGFloat seperY = topBackHeight;
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperY, topBackWidth, seperHeight)];
    [seperator setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR]];
    
//    [topBackView addSubview:seperator];
    
    // BOTTOM BACK VIEW
    CGFloat bottomBackX = topBackX;
    CGFloat bottomBackY = CGRectGetMaxY(topBackView.frame);
    UIView *bottomBackView = [[UIView alloc] initWithFrame:CGRectMake(bottomBackX, bottomBackY, topBackWidth, topBackHeight)];
    
    self.bottomBackView = bottomBackView;
    [self addSubview:bottomBackView];
    
    // FIELD
    UILabel *fieldLabel = [[UILabel alloc] initWithFrame:CGRectMake(FIELD_TOP_MARGIN, FIELD_LEFT_MARGIN, 0, 0)];
    [fieldLabel setTextAlignment:NSTextAlignmentLeft];
    [fieldLabel setFont:[UIFont systemFontOfSize:13]];
    [fieldLabel setTextColor:[UIColor grayColor]];
    
    self.fieldLabel = fieldLabel;
    [bottomBackView addSubview:fieldLabel];
  }
  return self;
}

- (void)configCellWithGameInfo:(SimpleTeamGameInfo *)gameInfo
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
  [self.avatar setImageWithURL:[NSURL URLWithString:gameInfo.teamAvatarURL]];
  
  // NAME
  [self.nameLabel setText:gameInfo.teamName];
  [self.nameLabel sizeToFit];
  
  CGFloat nameWidth = self.topBackView.bounds.size.width
  - NAME_LEFT_MARGIN - SCORE_LEFT_MARGIN
  - SCORE_WIDTH - SCORE_RIGHT_MARGIN;
  CGFloat nameY = self.topBackView.frame.size.height - NAME_BOTTOM_MARGIN - self.nameLabel.frame.size.height;
  if (self.nameLabel.frame.size.width > nameWidth) {
    [UIConfiguration setView:self.nameLabel width:nameWidth];
  }
  [UIConfiguration setView:self.nameLabel y:nameY];
  
  // SCORE
  [self.averageScoreLabel setText:gameInfo.averageScore];
  [self.averageScoreLabel sizeToFit];
  
  CGFloat scoreY = self.topBackView.frame.size.height - SCORE_BOTTOM_MARGIN - self.averageScoreLabel.frame.size.height;
  CGFloat scoreX = CGRectGetMaxX(self.nameLabel.frame) + SCORE_LEFT_MARGIN;
  [UIConfiguration setView:self.averageScoreLabel origin:CGPointMake(scoreX, scoreY)];
  [UIConfiguration setView:self.averageScoreLabel width:SCORE_WIDTH];
  
  // FIELD
  [self.fieldLabel setText:gameInfo.field];
  [self.fieldLabel sizeToFit];
  
  [UIConfiguration setView:self.fieldLabel origin:CGPointMake(FIELD_LEFT_MARGIN, FIELD_TOP_MARGIN)];
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
