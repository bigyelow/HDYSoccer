//
//  TeamGameCell2.m
//  HDYSoccer
//
//  Created by bigyelow on 9/1/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "TeamGameCell2.h"
#import "SimpleTeamGameInfo.h"
#import "UIImageView+WebCache.h"

// CONTENT
#define CONTENT_HEIGHT 70

// HEADER
#define HEADER_HEIGHT 21

// FOOTER
#define FOOTER_HEIGHT (TEAM_GAME_CELL2_HEIGHT - CONTENT_HEIGHT - HEADER_HEIGHT)

// AVATAR
#define AVATAR_LEFT_MARGIN 10
#define AVATAR_TOP_MARGIN 7

// NAME
#define NAME_LEFT_MARGIN AVATAR_LEFT_MARGIN
#define NAME_TOP_MARGIN 4
#define NAME_HEIGTH (HEADER_HEIGHT - 2 * NAME_TOP_MARGIN)

// FIELD
#define FIELD_LEFT_MARGIN 10
#define FIELD_HEIGHT 17
#define FIELD_BOTTOM_MARGIN 0
#define FIELD_RIGHT_MARGIN 5

// RECORD
#define RECORD_TOP_MARGIN 4
#define RECORD_LEFT_MARGIN 11
#define RECORD_HEIGHT 14
#define RECORD_WIDTH 100

// FOOTER SEPERATOR
#define SEPER_LEFT_MARGIN (AVATAR_LEFT_MARGIN - 2)
#define SEPER_HEIGHT 0.5

// DISTANCE
#define DISTANCE_LEFT_MARGIN AVATAR_LEFT_MARGIN
#define DISTANCE_TOP_MARGIN NAME_TOP_MARGIN
#define DISTANCE_WIDTH 100
#define DISTANCE_HEIGHT (FOOTER_HEIGHT - 2 * DISTANCE_TOP_MARGIN)

// TIME
#define TIME_RIGHT_MARGIN 10
#define TIME_WIDTH 100
@implementation TeamGameCell2

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIColor whiteColor]];
    
    // HEADER
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, HEADER_HEIGHT)];
    
    [self addSubview:headerView];
    
    // NAME
    CGFloat nameWidth = frame.size.width - FIELD_RIGHT_MARGIN - NAME_LEFT_MARGIN;
    CGRect nameRect = CGRectMake(NAME_LEFT_MARGIN, NAME_TOP_MARGIN, nameWidth, NAME_HEIGTH);
    UILabel *nameLabel = [UIConfiguration labelWithFrame:nameRect
                                               textColor:[UIColor grayColor]
                                                    font:[UIFont systemFontOfSize:NAME_HEIGTH]
                                               alignment:NSTextAlignmentLeft];
    
    self.nameLabel = nameLabel;
    [headerView addSubview:nameLabel];
    
    // SEPER
    CGFloat seperY = HEADER_HEIGHT - SEPER_HEIGHT;
    UIView *seper = [[UIView alloc] initWithFrame:CGRectMake(SEPER_LEFT_MARGIN, seperY, frame.size.width - SEPER_LEFT_MARGIN, SEPER_HEIGHT)];
    [seper setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR_CLEAR]];
    
    [headerView addSubview:seper];
    
    // CONTENT
    UIView *contentView = [[UIView alloc] initWithFrame:CGRectMake(0, HEADER_HEIGHT, frame.size.width, CONTENT_HEIGHT)];
    
    [self addSubview:contentView];
    
    // AVATAR
    CGFloat avatarX = AVATAR_LEFT_MARGIN;
    CGFloat avatarWidth = CONTENT_HEIGHT - 2 * AVATAR_TOP_MARGIN;
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(avatarX, AVATAR_TOP_MARGIN, avatarWidth, avatarWidth)];
    [avatar.layer setCornerRadius:5];
    [avatar setClipsToBounds:YES];
    
    self.avatar = avatar;
    [contentView addSubview:avatar];
    
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
    [contentView addSubview:fieldLabel];
    
    // RECORD
    CGFloat recordX = CGRectGetMaxX(avatar.frame) + RECORD_LEFT_MARGIN;
    CGFloat recordY = CONTENT_HEIGHT / 2 + RECORD_TOP_MARGIN;
    UILabel *recordLabel = [UIConfiguration labelWithFrame:CGRectMake(recordX, recordY, RECORD_WIDTH, RECORD_HEIGHT)
                                                textColor:[UIColor grayColor]
                                                     font:[UIFont systemFontOfSize:RECORD_HEIGHT]
                                                alignment:NSTextAlignmentLeft];
    
    self.recordLabel = recordLabel;
    [contentView addSubview:recordLabel];
    
    // FOOTER
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, HEADER_HEIGHT + CONTENT_HEIGHT, frame.size.width, FOOTER_HEIGHT)];
    
    [self addSubview:footerView];
    
    // SEPER
    seper = [[UIView alloc] initWithFrame:CGRectMake(SEPER_LEFT_MARGIN, 0, frame.size.width - SEPER_LEFT_MARGIN, SEPER_HEIGHT)];
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

- (void)configCellWithGameInfo:(SimpleTeamGameInfo *)gameInfo
{
  [self.nameLabel setText:gameInfo.teamName];
  [self.avatar sd_setImageWithURL:[NSURL URLWithString:gameInfo.teamAvatarURL]];
  [self.fieldLabel setText:gameInfo.field];
  [self.recordLabel setText:[self formatRecordWithRecords:gameInfo.recentRecords]];
  
  // DISTANCE
  NSString *distanceStr = [NSString stringWithFormat:@"%@km", gameInfo.distance];
  [self.distanceLabel setText:distanceStr];
  
  // TIME
  NSString *time = [Tools dateminuteToStr:gameInfo.time preferUTC:NO];
  [self.timeLabel setText:time];
}

- (NSString *)formatRecordWithRecords:(NSArray *)array
{
  NSInteger winCount = [SimpleTeamGameInfo winCountOfRecord:array];
  NSInteger drawCount = [SimpleTeamGameInfo drawCountOfRecord:array];
  NSInteger loseCount = [SimpleTeamGameInfo loseCountOfRecord:array];
  
  
  NSMutableString *formatRecord = [NSMutableString string];
  if (winCount) {
    [formatRecord appendString:[NSString stringWithFormat:@"%zd%@", winCount, TEXT_WIN]];
  }
  if (drawCount) {
    [formatRecord appendString:[NSString stringWithFormat:@"%zd%@", drawCount, TEXT_DRAW]];
  }
  if (loseCount) {
    [formatRecord appendString:[NSString stringWithFormat:@"%zd%@", loseCount, TEXT_LOSE]];
  }
  
  return [formatRecord copy];
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
