//
//  ChooseTeamCell.h
//  HDYSoccer
//
//  Created by bigyelow on 6/17/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CREATE_GAME_DETAIL_TEAM_CELL_ID @"chooseTeamCell"
#define CHOOSE_TEAM_NORMAL_HEIGHT 44

@interface ChooseTeamCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UIButton *chooseTeamButton;
@property (nonatomic, strong) UIView *seperator;

- (void)configCellWithTeam:(NSArray *)team;
- (CGFloat)cellHeight;
@end
