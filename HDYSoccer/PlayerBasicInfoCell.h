//
//  SoccerBasicInfoCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/13/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PLAYER_BASIC_INFO_CELL_ID @"playerBasicCell"

@class Geeker;

@interface PlayerBasicInfoCell : UITableViewCell
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *positionLabel;

+ (CGFloat)cellHeight;
- (void)configCellWithPlayer:(Geeker *)player;
@end
