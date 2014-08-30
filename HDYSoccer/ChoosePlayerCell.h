//
//  ChoosePlayerCell.h
//  HDYSoccer
//
//  Created by bigyelow on 6/16/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CREATE_GAME_DETAIL_PLAYER_CELL_ID @"choosePlayerCell"
#define CHOOSE_PLAYER_CELL_NORMAL_HEIGHT 44

@interface ChoosePlayerCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *addFriendButton;
@property (nonatomic, strong) UIView *seperator;

- (void)configCellWithPlayers:(NSArray *)playersArray
                   cellHeight:(CGFloat)cellHeight;
- (CGFloat)cellHeight:(NSArray *)playersArray;
@end
