//
//  TeamTableCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/11/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "TeamTableCell.h"
#import "SimpleTeamInfo.h"
#import "UIImageView+WebCache.h"
#import "UILabel+Customize.h"

// BACKGROUND
#define BACKGROUND_BOTTOM_MARGIN 10

// content
#define CONTENT_RIGHT_MARING 10

// AVATAR
#define AVATAR_TOP_MARGIN 15
#define AVATAR_LEFT_MARGIN 10

// name
#define NAME_TOP_MARGIN (AVATAR_TOP_MARGIN)
#define NAME_LEFT_MARGIN 10

// member count
#define MEMBER_COUNT_TOP_MARGIN (NAME_TOP_MARGIN + 1)
#define MEMBER_COUNT_LEFT_MARGIN 4

// recent record
#define RECENT_RECORD_TOP_MARGIN MEMBER_COUNT_TOP_MARGIN
#define RECENT_RECORD_LEFT_MARGIN 5

// AVERAGE SCORE
#define SCORE_TOP_MARGIN 10
#define SCORE_LEFT_MARGIN 10
#define SCORE_HEIGHT 28

// CAPTAIN
#define CAPTAIN_TOP_MARGIN MEMBER_COUNT_TOP_MARGIN
#define CAPTAIN_LEFT_MARGIN 0

@implementation TeamTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [UIConfiguration setView:self height:TEAM_TABLE_CELL_HEIGHT];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // BACKGROUND
    CGFloat backgroundHeight = self.frame.size.height - BACKGROUND_BOTTOM_MARGIN;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, backgroundHeight)];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:backgroundView];
    
    // AVATAR
    CGFloat avatarWidth = backgroundView.frame.size.height - 2 * AVATAR_TOP_MARGIN;
    UIImageView *avatar = [[UIImageView alloc]
                           initWithFrame:CGRectMake(AVATAR_LEFT_MARGIN, AVATAR_TOP_MARGIN, avatarWidth, avatarWidth)];
    [avatar.layer setCornerRadius:5];
    [avatar setClipsToBounds:YES];
    
    self.avatar = avatar;
    [backgroundView addSubview:avatar];
    
    // name
    CGFloat nameX = CGRectGetMaxX(avatar.frame) + NAME_LEFT_MARGIN;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, NAME_TOP_MARGIN, 0, 0)];
    
    self.nameLabel = nameLabel;
    [backgroundView addSubview:nameLabel];
    
    // member count
    self.memberCountLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, MEMBER_COUNT_TOP_MARGIN, 0, 0)];
    
    [backgroundView addSubview:self.memberCountLabel];
    
    // recent record
    self.recentRecordLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, RECENT_RECORD_TOP_MARGIN, 0, 0)];
    
    [backgroundView addSubview:self.recentRecordLabel];
    
    // SCORE
    CGFloat scoreX = CGRectGetMaxX(avatar.frame) + SCORE_LEFT_MARGIN;
    CGFloat scoreY = CGRectGetMaxY(nameLabel.frame) + SCORE_TOP_MARGIN;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(scoreX, scoreY, 0, 0)];
    [label setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_GREEN_COLOR]];
    [label setClipsToBounds:YES];
    [label setTextAlignment:NSTextAlignmentCenter];
    [label.layer setCornerRadius:14];
    
    self.averageScoreLabel = label;
    [backgroundView addSubview:self.averageScoreLabel];

//    // captain
//    self.captainLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, CAPTAIN_TOP_MARGIN, 0, 0)];
//    
//    [backgroundView addSubview:self.captainLabel];
  }
  return self;
}

- (void)configWithTeamInfo:(SimpleTeamInfo *)info
{
  // avatar
  [self.avatar setImageWithURL:[NSURL URLWithString:info.teamAvatarURL]];
  
  // name
  [self.nameLabel configWithText:info.teamName
                       textColor:[UIColor blackColor]
                            font:[UIFont systemFontOfSize:16]
                   numberOfLines:1];
  
  CGFloat rightMost = CGRectGetMaxX(self.nameLabel.frame);
  
  // member count
  [self.memberCountLabel configWithText:[NSString stringWithFormat:@"%d%@", info.memberCount, TEXT_MAN]
                              textColor:[UIColor lightGrayColor]
                                   font:[UIFont fontWithName:GLOBAL_FONT_NAME size:13]
                          numberOfLines:1];
  CGFloat countX = rightMost + MEMBER_COUNT_LEFT_MARGIN;
  [UIConfiguration setView:self.memberCountLabel x:countX];
  
  rightMost = CGRectGetMaxX(self.memberCountLabel.frame);
  
  // recent record
  CGFloat xLimit = self.frame.size.width - CONTENT_RIGHT_MARING;
  [self.recentRecordLabel configWithText:[self formatRecordWithRecords:info.recentRecords]
                               textColor:[UIColor lightGrayColor]
                                    font:[UIFont fontWithName:GLOBAL_FONT_NAME size:13]
                           numberOfLines:1];
  CGFloat recordX = rightMost + RECENT_RECORD_LEFT_MARGIN;
  [UIConfiguration setView:self.recentRecordLabel x:recordX];
  rightMost = CGRectGetMaxX(self.recentRecordLabel.frame);
  
  if (rightMost > xLimit) {
    [UIConfiguration setView:self.recentRecordLabel width:xLimit - self.recentRecordLabel.frame.origin.x];
  }
  
  // score
  [self.averageScoreLabel configWithText:[NSString stringWithFormat:@"%@:%@", TEXT_TEAM_AVERAGE_SCORE, info.averageScore]
                               textColor:[UIColor whiteColor]
                                    font:[UIFont systemFontOfSize:12]
                           numberOfLines:1];
  CGFloat scoreY = CGRectGetMaxY(self.nameLabel.frame) + SCORE_TOP_MARGIN;
  CGFloat scoreWidth = self.averageScoreLabel.frame.size.width + 20;
  [UIConfiguration setView:self.averageScoreLabel size:CGSizeMake(scoreWidth, SCORE_HEIGHT)];
  [UIConfiguration setView:self.averageScoreLabel y:scoreY];
  
//  CGFloat xLimit = self.frame.size.width - CONTENT_RIGHT_MARING;
//  // captain
//  if (![Tools isNilOrEmpty:info.captain]) {
//    [self.captainLabel configWithText:[NSString stringWithFormat:@"/%@:%@", TEXT_CAPTAIN, info.captain]
//                            textColor:[UIColor lightGrayColor] 
//                                 font:[UIFont fontWithName:GLOBAL_FONT_NAME size:13]
//                        numberOfLines:1];
//    CGFloat captainX = rightMost + CAPTAIN_LEFT_MARGIN;
//    [UIConfiguration setView:self.captainLabel x:captainX];
//    
//    rightMost = CGRectGetMaxX(self.captainLabel.frame);
//    
//    if (rightMost > xLimit) {
//      [UIConfiguration setView:self.captainLabel width:xLimit - self.captainLabel.frame.origin.x];
//    }
//  }
}

- (NSString *)formatRecordWithRecords:(NSArray *)array
{
  NSInteger winCount = 0;
  NSInteger drawCount = 0;
  NSInteger loseCount = 0;
  
  for (NSNumber *result in array) {
    switch (result.integerValue) {
      case GameResultWin:
        winCount++;
        break;
        
      case GameResultDraw:
        drawCount++;
        break;
        
      default:
        loseCount++;
        break;
    }
  }
  
  NSMutableString *formatRecord = [NSMutableString string];
  if (winCount) {
    [formatRecord appendString:[NSString stringWithFormat:@"%d%@", winCount, TEXT_WIN]];
  }
  if (drawCount) {
    [formatRecord appendString:[NSString stringWithFormat:@"%d%@", drawCount, TEXT_DRAW]];
  }
  if (loseCount) {
    [formatRecord appendString:[NSString stringWithFormat:@"%d%@", loseCount, TEXT_LOSE]];
  }
  
  return [formatRecord copy];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
