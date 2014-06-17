//
//  CreateGameDetailViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 6/8/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseTableViewController.h"
#import "RMDateSelectionViewController.h"

#define GAME_TIME_KEY @"gameTime"
#define GAME_FILED_KEY @"gameField"
#define GAME_PLAYERS_KEY @"gamePlayers"
#define GAME_TEAM_KEY @"gameTeam"
#define GAME_CONTACT_KEY @"gameContact"
#define GAME_COST_KEY @"gameCost"
#define GAME_COST_PER_PERSON_KEY @"gameCostPerPerson"
#define GAME_REMARKS_KEY @"gameRemarks"

@class ChoosePlayerCell;
@class ContactCell;
@class CostCell;
@class RemarkCell;
@class ChooseTeamCell;

typedef NS_ENUM(NSUInteger, GameType)
{
  kGameTypePersonal,
  kGameTypeTeam
};

@interface CreateGameDetailViewController : HDYSoccerBaseTableViewController
<RMDateSelectionViewControllerDelegate>

@property (nonatomic, assign) GameType gameType;

// game related params
@property (nonatomic, strong) NSDate *gameTime;

// cell
@property (nonatomic, strong) ChoosePlayerCell *playerCell;
@property (nonatomic, strong) ChooseTeamCell *teamCell;
@property (nonatomic, strong) ContactCell *contactCell;
@property (nonatomic, strong) CostCell *costCell;
@property (nonatomic, strong) RemarkCell *remarkCell;

// ui

- (id)initWithStyle:(UITableViewStyle)style
           gameType:(GameType)gameType;
@end
