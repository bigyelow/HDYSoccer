//
//  TeamGameRecordsCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/8/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeamGameRecords;

#define GAME_INFO_TEAM_GAME_RECORD_CELL_ID @"gameInfotTeamGameRecordCell"
#define TEAM_GAME_RECORD_CELL_HEIGHT 30

@interface TeamGameRecordsCell : UITableViewCell

@property (nonatomic, strong) UILabel *homeTeamLabel;
@property (nonatomic, strong) UILabel *guestTeamLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
- (void)configCellWithGameRecord:(TeamGameRecords *)record;
@end
