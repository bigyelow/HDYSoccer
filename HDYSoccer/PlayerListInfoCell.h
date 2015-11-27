//
//  PlayerListInfoCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/13/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PLAYER_LIST_CELL_ID @"playerListCell"
#define PLAYER_LIST_CELL_HEIGHT 30

@interface PlayerListInfoCell : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIView *bottomSeper;
@property (nonatomic, strong) UIView *topSeper;

- (void)configCellWithTitle:(NSString *)title
                       info:(NSString *)info
              hasBottomLine:(BOOL)hasBottomLine;
@end
