//
//  GameRecordCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/25/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TeamGameRecords;

#define GAME_RECORD_CELL_ID @"gameRecordCell"
#define GAME_RECORD_CELL_HEIGHT 56

@interface GameRecordCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *homeTeamLabel;
@property (nonatomic, strong) UILabel *guestTeamLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) TeamGameRecords *record;

- (void)configWithRecord:(TeamGameRecords *)record;
@end
