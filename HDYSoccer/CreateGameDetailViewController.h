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

@class ChooseFieldCell;
@class ChoosePlayerCell;
@class ContactCell;
@class CostCell;
@class RemarkCell;
@class ChooseTeamCell;
@class KeyboardTopView;

typedef NS_ENUM(NSUInteger, GameType)
{
  kGameTypePersonal,
  kGameTypeTeam
};

@interface CreateGameDetailViewController : HDYSoccerBaseTableViewController
<RMDateSelectionViewControllerDelegate, UITextFieldDelegate, UITextViewDelegate>

@property (nonatomic, assign) GameType gameType;
@property (nonatomic, strong) id createGameDelegate;

// game related params
@property (nonatomic, strong) NSDate *gameTime;
@property (nonatomic, copy) NSString *gameField;
@property (nonatomic, assign) NSInteger playerCount;
@property (nonatomic, strong) NSArray *players;
@property (nonatomic, copy) NSString *contact;
@property (nonatomic, copy) NSString *cost;
@property (nonatomic, copy) NSString *remarks;
@property (nonatomic, copy) NSString *teamID;

// cell
@property (nonatomic, strong) ChooseFieldCell *fieldCell;
@property (nonatomic, strong) NSIndexPath *fieldCellIndexPath;

@property (nonatomic, strong) ChoosePlayerCell *playerCell;
@property (nonatomic, strong) NSIndexPath *playerCellIndexPath;

@property (nonatomic, strong) ChooseTeamCell *teamCell;
@property (nonatomic, strong) NSIndexPath *teamCellIndexPath;

@property (nonatomic, strong) ContactCell *contactCell;
@property (nonatomic, strong) NSIndexPath *contactCellIndexPath;

@property (nonatomic, strong) CostCell *costCell;
@property (nonatomic, strong) NSIndexPath *costCellIndexPath;

@property (nonatomic, strong) RemarkCell *remarkCell;
@property (nonatomic, strong) NSIndexPath *remarkCellIndexPath;

// keyboard
@property (nonatomic, assign) CGRect keyboardRect;
@property (nonatomic, strong) KeyboardTopView *keyboardTopView;
@property (nonatomic, assign) BOOL keyboardShowed;

- (id)initWithStyle:(UITableViewStyle)style
           gameType:(GameType)gameType;
@end
