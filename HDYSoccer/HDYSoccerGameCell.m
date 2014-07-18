//
//  HDYSoccerGameCell.m
//  HDYSoccer
//
//  Created by bigyelow on 3/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameCell.h"
#import "UIConfiguration+Color.h"
#import "GameViewParams.h"
#import "SimplePersonalGameInfo.h"
#import "SimpleTeamGameInfo.h"
#import "UIImageView+WebCache.h"

@implementation HDYSoccerGameCell

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
    [self.contentView setBackgroundColor:[UIColor clearColor]];
    
    [self.contentView.layer setBorderWidth:0.5];
    [self.contentView.layer setBorderColor:[UIColor grayColor].CGColor];
    
    CGFloat imageH = CGRectGetHeight(self.contentView.frame) / 4 * 3;
    CGFloat infoH = CGRectGetHeight(self.contentView.frame) - imageH;
    // image
    if (!self.imageView) {
      UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
//      [UIConfiguration setView:imageView height:imageH];
      self.imageView = imageView;
      [self.contentView addSubview:self.imageView];
    }
    // info
    if (!self.infoView) {
      UIView *infoView = [[UIView alloc] initWithFrame:self.contentView.bounds];
      [UIConfiguration setView:infoView y:imageH];
      [UIConfiguration setView:infoView height:infoH];
      
      [infoView setBackgroundColor:[UIConfiguration colorForHex:@"#f0f0f0"]];
      [infoView setAlpha:0.9];
      [self.contentView addSubview:infoView];
      
      self.infoView = infoView;
    }
	}
	return self;
}

#define TEXT_LEFT_MARGIN 7.0f
#define TEXT_TOP_MARGIN 3.0f
#define PARTICIPANT_FONT_SIZE 14.0f
#define SCORE_LEFT_MARGIN 0.0f
#define FIELD_TOP_MARGIN 2.0f
#define DISTANCE_LEFT_MARGIN 0.0f
#define DISTANCE_WIDTH 50.0f

#define FIELD_FONT_SIZE 12.0f
#define FIELD_FONT_COLOR @"#9c9c9c"
#define PARTICIPANT_FONT_COLOR @"#4c4c4c"

#define GAMELIST_CELL_FONT_NAME @"Verdana"

- (void)configWithPersonalGameInfo:(SimplePersonalGameInfo *)gameInfo
{
  [self.imageView setImageWithURL:[NSURL URLWithString:gameInfo.avatarURL] placeholderImage:nil];
  
  // participants
  NSMutableString *participantsStr = [NSMutableString string];
  [participantsStr appendString:gameInfo.participantsNumber];
  if ([Tools isNilOrEmpty:gameInfo.totalNumberLimit] == NO) {
    [participantsStr appendString:[NSString stringWithFormat:@"/%@", gameInfo.totalNumberLimit]];
  }
  self.participantLabel = [[UILabel alloc] initWithFrame:CGRectZero];
  [self.participantLabel setText:participantsStr];
  [self.participantLabel setTextColor:[UIConfiguration colorForHex:PARTICIPANT_FONT_COLOR]];
  [self.participantLabel setFont:[UIFont fontWithName:GAMELIST_CELL_FONT_NAME size:PARTICIPANT_FONT_SIZE]];
  [self.participantLabel sizeToFit];
  [UIConfiguration setView:self.participantLabel x:TEXT_LEFT_MARGIN];
  [UIConfiguration setView:self.participantLabel y:TEXT_TOP_MARGIN];
  
  [self.infoView addSubview:self.participantLabel];
  
  // average score
  if ([Tools isNilOrEmpty:gameInfo.averageScore] == NO) {
    CGFloat scoreX = CGRectGetMaxX(self.participantLabel.frame) + SCORE_LEFT_MARGIN;
    self.averageScoreLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    NSString *scoreText = [NSString stringWithFormat:TEXT_GAME_AVERAGE_SCORE_TITLE, gameInfo.averageScore];
    [self.averageScoreLabel setText:scoreText];
    [self.averageScoreLabel setTextColor:[UIConfiguration colorForHex:PARTICIPANT_FONT_COLOR]];
    [self.averageScoreLabel setFont:[UIFont fontWithName:GAMELIST_CELL_FONT_NAME size:PARTICIPANT_FONT_SIZE]];
    [self.averageScoreLabel sizeToFit];
    [UIConfiguration setView:self.averageScoreLabel x:scoreX];
    [UIConfiguration setView:self.averageScoreLabel y:TEXT_TOP_MARGIN];

    [self.infoView addSubview:self.averageScoreLabel];
  }
  
  // field
  if ([Tools isNilOrEmpty:gameInfo.field] == NO) {
    CGFloat fieldY = CGRectGetMaxY(self.participantLabel.frame) + FIELD_TOP_MARGIN;
    self.fieldLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    [self.fieldLabel setText:gameInfo.field];
    [self.fieldLabel setFont:[UIFont systemFontOfSize:FIELD_FONT_SIZE]];
    [self.fieldLabel setTextColor:[UIConfiguration colorForHex:FIELD_FONT_COLOR]];
    [self.fieldLabel setNumberOfLines:1];
    [self.fieldLabel sizeToFit];
    
    CGFloat maxWidth = CGRectGetWidth(self.contentView.frame) - TEXT_LEFT_MARGIN - DISTANCE_WIDTH;
    if (CGRectGetWidth(self.fieldLabel.frame) > maxWidth) {
      [UIConfiguration setView:self.fieldLabel width:maxWidth];
    }
    [UIConfiguration setView:self.fieldLabel x:TEXT_LEFT_MARGIN];
    [UIConfiguration setView:self.fieldLabel y:fieldY];
    
    [self.infoView addSubview:self.fieldLabel];
  }
  
  // distance
  if ([Tools isNilOrEmpty:gameInfo.distance] == NO) {
    CGFloat distanceX = CGRectGetMaxX(self.fieldLabel.frame) + DISTANCE_LEFT_MARGIN;
    self.distanceLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    NSString *distanceStr = [NSString stringWithFormat:TEXT_DISTANCE, gameInfo.distance];
    [self.distanceLabel setText:distanceStr];
    [self.distanceLabel setFont:[UIFont fontWithName:GAMELIST_CELL_FONT_NAME size:FIELD_FONT_SIZE]];
    [self.distanceLabel setTextColor:[UIConfiguration colorForHex:FIELD_FONT_COLOR]];
    [self.distanceLabel sizeToFit];
    [UIConfiguration setView:self.distanceLabel width:DISTANCE_WIDTH];
    [UIConfiguration setView:self.distanceLabel x:distanceX];
    [UIConfiguration setView:self.distanceLabel y:CGRectGetMinY(self.fieldLabel.frame)];
    
    [self.infoView addSubview:self.distanceLabel];
  }
}

- (void)configWithTeamGameInfo:(SimpleTeamGameInfo *)gameInfo
{
  [self.imageView setImageWithURL:[NSURL URLWithString:gameInfo.teamAvatarURL] placeholderImage:nil];
}

@end
