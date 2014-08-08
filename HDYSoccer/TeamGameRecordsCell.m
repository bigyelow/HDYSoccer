//
//  TeamGameRecordsCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/8/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "TeamGameRecordsCell.h"
#import "GameListFilterTableViewCell.h"
#import "TeamGameRecords.h"

#define SCORE_WIDTH 60

#define SEPERATOR_WIDTH 0.5

@implementation TeamGameRecordsCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [UIConfiguration setView:self height:TEAM_GAME_RECORD_CELL_HEIGHT];
    CGFloat teamBackWidth = (self.frame.size.width - SCORE_WIDTH) / 2;
    CGFloat teamBackHeight = self.frame.size.height;
    
    // home team
    self.homeTeamLabel = [[UILabel alloc] init];
    UIView *homeView = [self scoreViewWithFrame:CGRectMake(0, 0, teamBackWidth, teamBackHeight) label:self.homeTeamLabel];
    [self addSubview:homeView];
    
    // guest team
    self.guestTeamLabel = [[UILabel alloc] init];
    CGFloat guestX = CGRectGetMaxX(homeView.frame) + SCORE_WIDTH;
    UIView *guestView = [self scoreViewWithFrame:CGRectMake(guestX , 0, teamBackWidth, teamBackHeight) label:self.guestTeamLabel];
    [self addSubview:guestView];
    
    // score
    self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(homeView.frame), 0, SCORE_WIDTH, self.frame.size.height)];
    [self.scoreLabel setTextColor:[UIColor lightGrayColor]];
    [self.scoreLabel setTextAlignment:NSTextAlignmentCenter];
    [self.scoreLabel setFont:[UIFont fontWithName:GLOBAL_FONT_NAME size:13]];
    
    [self addSubview:self.scoreLabel];
    
    // bottom seperator
    CGFloat seperatorY = self.frame.size.height - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.frame.size.width, GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT)];
    [seperator setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR]];
    
    [self addSubview:seperator];
  }
  return self;
}

- (UIView *)scoreViewWithFrame:(CGRect)frame
                         label:(UILabel *)label
{
  UIView *view = [[UIView alloc] initWithFrame:frame];
  [view setBackgroundColor:[UIColor whiteColor]];
  
  // seperator line
  UIView *leftSeperator = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SEPERATOR_WIDTH, frame.size.height)];
  [leftSeperator setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR]];
  [view addSubview:leftSeperator];
  
  UIView *rightSeperator = [[UIView alloc] initWithFrame:CGRectMake(frame.size.width - SEPERATOR_WIDTH, 0, SEPERATOR_WIDTH, frame.size.height)];
  [rightSeperator setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR]];
  [view addSubview:rightSeperator];
  
  // label
  [label setFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
  [label setFont:[UIFont systemFontOfSize:13]];
  [label setTextAlignment:NSTextAlignmentCenter];
  [label setTextColor:[UIColor blackColor]];
  [view addSubview:label];
  
  return view;
}

- (void)configCellWithGameRecord:(TeamGameRecords *)record
{
  [self.homeTeamLabel setText:record.homeTeamName];
  [self.guestTeamLabel setText:record.guestTeamName];
  [self.scoreLabel setText:record.score];
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
