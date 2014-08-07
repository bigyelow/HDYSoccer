//
//  GameListFilterFieldTableViewCell.h
//  HDYSoccer
//
//  Created by bigyelow on 7/19/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GAME_LIST_FILTER_FIELD_CELL_ID @"game_list_filter_field_cell"
@interface GameListFilterFieldTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *fieldLabel;

- (void)configCellWithField:(NSString *)field;
@end
