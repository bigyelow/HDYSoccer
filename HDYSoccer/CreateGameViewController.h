//
//  CreateGameViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 6/8/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseTableViewController.h"

#define KEY_GAME_TYPE @"gameType"
#define KEY_GAME_OBJECT @"gameObject"

@protocol createGameDelegate <NSObject>

- (void)createGameSucceeded:(NSDictionary *)dic;
@end

@interface CreateGameViewController : HDYSoccerBaseTableViewController

@property (nonatomic, strong) id createGameDelegate;
@end
