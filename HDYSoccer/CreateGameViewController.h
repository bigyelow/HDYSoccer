//
//  CreateGameViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 6/8/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseTableViewController.h"

#define CREATE_PERSONAL_GAME @"创建小场活动"
#define CREATE_TEAM_GAME @"创建大场比赛"

#define KEY_GAME_TYPE @"gameType"
#define KEY_GAME_OBJECT @"gameObject"

@protocol createGameDelegate <NSObject>

- (void)createGameSucceeded:(NSDictionary *)dic;
@end

@interface CreateGameViewController : HDYSoccerBaseTableViewController

@property (nonatomic, strong) id createGameDelegate;
@end
