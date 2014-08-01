//
//  JoinGameCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/1/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CreateGameDetailViewController.h"

#define GAME_INFO_JOIN_CELL_ID @"gameInfoJoinCell"
#define JOIN_GAME_CELL_HEIGHT 50.0F


@interface JoinGameCell : UITableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
           gameType:(GameType)gameType;
@end
