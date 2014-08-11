//
//  TeamTableCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/11/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SimpleTeamInfo;

#define TEAM_TABLE_CELL_ID @"teamTableCell"
#define TEAM_TABLE_CELL_HEIGHT 90

@interface TeamTableCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *memberCountLabel;
@property (nonatomic, strong) UILabel *recentRecordLabel;
@property (nonatomic, strong) UILabel *captainLabel;
@property (nonatomic, strong) UILabel *averageScoreLabel;

- (void)configWithTeamInfo:(SimpleTeamInfo *)info;
@end
