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
@class RemarkCellForGameInfo;

@interface GameDetailViewController : HDYSoccerBaseTableViewController

@property (nonatomic, assign) GameType gameType;
@property (nonatomic, strong) PersonalGame *personalGame;
@property (nonatomic, strong) TeamGame *teamGame;

// game info
@property (nonatomic, copy) NSString *gameID;
@property (nonatomic, copy) NSString *time;
@property (nonatomic, copy) NSString *field;
@property (nonatomic, copy) NSString *totalCost;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *remarks;

@property (nonatomic, assign) BOOL newCreated;

// cell
@property (nonatomic, strong) RemarkCellForGameInfo *remarkCell;

- (id)initWithGameInfo:(NSDictionary *)gameInfo tableViewStyle:(UITableViewStyle)style;
- (id)initWithgameID:(NSString *)gameID
            gameType:(GameType)gameType
      tableviewStyle:(UITableViewStyle)style;
@end
