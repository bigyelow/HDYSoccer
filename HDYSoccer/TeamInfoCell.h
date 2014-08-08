//
//  TeamInfoCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/7/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TeamGame;

#define GAME_INFO_TEAM_INFO_CELL_ID @"gameInfoTeamInfoCell"
@interface TeamInfoCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
           teamInfo:(TeamGame *)teamInfo;
+ (CGFloat)heightForCell;
@end
