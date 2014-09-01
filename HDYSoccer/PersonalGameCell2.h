//
//  PersonalGameCell2.h
//  HDYSoccer
//
//  Created by bigyelow on 9/1/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PERSONAL_GAME_CELL2_ID @"personalGameCell2"
#define PERSONAL_GAEM_CELL2_HEIGHT 90

@class SimplePersonalGameInfo;

@interface PersonalGameCell2 : UICollectionViewCell

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *fieldLabel;
@property (nonatomic, strong) UILabel *participantNumberLabel;
@property (nonatomic, strong) UILabel *averageScoreLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *timeLabel;

- (void)configCellWithGameInfo:(SimplePersonalGameInfo *)gameInfo;
@end
