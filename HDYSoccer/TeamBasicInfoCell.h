//
//  TeamBasicInfoCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/18/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Team.h"

#define TEAM_BASIC_INFO_CELL_ID @"teamBasicInfoCell"

@interface TeamBasicInfoCell : UITableViewCell
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;

- (void)configCellWithTeam:(Team *)team;
+ (CGFloat)cellHeight;
@end
