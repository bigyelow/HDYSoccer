//
//  GameListFilterTableViewCell.h
//  HDYSoccer
//
//  Created by bigyelow on 7/19/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GAME_LIST_FILTER_CELL_ID @"game_list_filter_cell"

#define GAME_LIST_FILTER_CELL_BACKGROUND_COLOR @"#0d0d0d"
#define GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT 0.5
#define GAME_LIST_FILTER_CELL_SEPERATOR_COLOR @"#808080"

@interface GameListFilterTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *timeLabel;

@end
