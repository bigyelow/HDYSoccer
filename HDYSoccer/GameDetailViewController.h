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

// game info
@property (nonatomic, strong) NSString *time;
@property (nonatomic, strong) NSString *field;
@property (nonatomic, strong) NSString *totalCost;
@property (nonatomic, strong) NSString *contact;
@property (nonatomic, strong) NSString *remarks;

- (id)initWithGameInfo:(NSDictionary *)gameInfo tableViewStyle:(UITableViewStyle)style;
@end
