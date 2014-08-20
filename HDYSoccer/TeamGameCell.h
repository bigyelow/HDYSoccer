//
//  TeamGameCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/20/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TEAM_GAME_CELL_ID @"teamGameCell"
#define TEAM_GAME_CELL_HEIGHT 70

@class SimpleTeamGameInfo;

@interface TeamGameCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *averageScoreLabel;
@property (nonatomic, strong) UILabel *fieldLabel;
@property (nonatomic, strong) UIView *topBackView;
@property (nonatomic, strong) UIView *bottomBackView;

- (void)configCellWithGameInfo:(SimpleTeamGameInfo *)gameInfo;
@end
