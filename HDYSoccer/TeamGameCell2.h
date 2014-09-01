//
//  TeamGameCell2.h
//  HDYSoccer
//
//  Created by bigyelow on 9/1/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TEAM_GAME_CELL2_ID @"teamGameCell"
#define TEAM_GAME_CELL2_HEIGHT 111

@class SimpleTeamGameInfo;

@interface TeamGameCell2 : UICollectionViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *fieldLabel;
@property (nonatomic, strong) UILabel *recordLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *timeLabel;

- (void)configCellWithGameInfo:(SimpleTeamGameInfo *)gameInfo;
@end
