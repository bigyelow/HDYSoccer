//
//  GameDetailViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 6/25/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseTableViewController.h"
#import "CreateGameDetailViewController.h"

@class PersonalGame;
@class TeamGame;
@interface GameDetailViewController : HDYSoccerBaseTableViewController

@property (nonatomic, assign) GameType gameType;
@property (nonatomic, strong) PersonalGame *personalGame;
@property (nonatomic, strong) TeamGame *teamGame;

- (id)initWithGameInfo:(NSDictionary *)gameInfo tableViewStyle:(UITableViewStyle)style;
@end
