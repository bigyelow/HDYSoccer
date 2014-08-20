//
//  PersonalGameCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/20/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PERSONAL_GAME_CELL_ID @"personalGameCell"
#define PERSONAL_GAEM_CELL_HEIGHT 70

@class SimplePersonalGameInfo;

@interface PersonalGameCell : UICollectionViewCell

@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *fieldLabel;
@property (nonatomic, strong) UILabel *participantNumberLabel;
@property (nonatomic, strong) UILabel *averageScoreLabel;
@property (nonatomic, strong) UIView *fieldBackView;
@property (nonatomic, strong) UIView *scoreBackView;

- (void)configCellWithGameInfo:(SimplePersonalGameInfo *)gameInfo;
@end
