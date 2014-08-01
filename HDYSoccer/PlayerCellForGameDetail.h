//
//  PlayerCellForGameDetail.h
//  HDYSoccer
//
//  Created by bigyelow on 7/31/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GAME_INFO_PLAYER_CELL_ID @"gameInfoPlayerCell"
#define GAME_INFO_PLAYER_CELL_HEIGHT 50

@class SimpleGeekerInfo;

@interface PlayerCellForGameDetail : UITableViewCell

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UIImageView *sponsorView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) NSArray *tagLabelsArray;
@property (nonatomic, strong) UIView *seperator;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier;

- (void)configWithPlayerInfo:(SimpleGeekerInfo *)geekerInfo
                   isSponsor:(BOOL)isSporsor;
@end
