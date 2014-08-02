//
//  RatePlayerCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/1/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GAME_INFO_RATE_PLAYER_CELL_ID @"gameInfoRatePlayerCell"
#define RATE_PLAYER_CELL_HEIGHT 30.0F
#define RATE_PLAYER_CELL_NAME_LEFT_MARGIN 3.0F
#define RATE_PLAYER_CELL_AVATAR_TOP_MARGIN 5.0F
#define RATE_PLAYER_CELL_AVATAR_LEFT_MARGIN 13.0f

@class SimpleGeekerInfo;

@interface RatePlayerCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *rankLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) NSArray *tagsArray;

- (void)configWithPlayerInfo:(SimpleGeekerInfo *)geekerInfo;
@end
