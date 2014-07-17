//
//  HDYSoccerGameCell.h
//  HDYSoccer
//
//  Created by bigyelow on 3/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SimplePersonalGameInfo;
@class SimpleTeamGameInfo;

@interface HDYSoccerGameCell : UICollectionViewCell

@property (nonatomic, strong) UIImageView *imageView;
@property (nonatomic, strong) UIView *infoView;
@property (nonatomic, strong) UILabel *participantLabel;
@property (nonatomic, strong) UILabel *averageScoreLabel;
@property (nonatomic, strong) UILabel *distanceLabel;
@property (nonatomic, strong) UILabel *fieldLabel;

- (void)configWithPersonalGameInfo:(SimplePersonalGameInfo *)gameInfo;
- (void)configWithTeamGameInfo:(SimpleTeamGameInfo *)gameInfo;
@end
