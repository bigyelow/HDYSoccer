//
//  ChoosePlayerCell.h
//  HDYSoccer
//
//  Created by bigyelow on 6/16/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CREATE_GAME_DETAIL_PLAYER_CELL_ID @"choosePlayerCell"

@interface ChoosePlayerCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *addFriendButton;
@end
