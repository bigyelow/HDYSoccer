//
//  GameDetailViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 6/25/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GameDetailViewController.h"
#import "CreateGameViewController.h"
#import "PersonalGame.h"
#import "TeamGame.h"
#import "GameDetailViewController+TopButtons.h"

@interface GameDetailViewController ()

@end

@implementation GameDetailViewController

- (id)initWithGameInfo:(NSDictionary *)gameInfo tableViewStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    [self initGameInfo:gameInfo];
  }
  return self;
}

- (void)initGameInfo:(NSDictionary *)gameInfo
{
  NSNumber *number = [gameInfo objectForKey:KEY_GAME_TYPE];
  self.gameType = number.integerValue;
  
  switch (self.gameType) {
    case kGameTypePersonal:
      self.personalGame = [gameInfo objectForKey:KEY_GAME_OBJECT];
      self.title = self.personalGame.gameName;
      break;
      
    case kGameTypeTeam:
      self.teamGame = [gameInfo objectForKey:KEY_GAME_OBJECT];
      self.title = self.teamGame.gameName;
      break;
      
    default:
      
      break;
  }
}


- (void)viewDidLoad
{
  [super viewDidLoad];

  [self configTopItems];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma makr - get methods
- (NSString *)contact
{
  NSString *str = @"";
  switch (self.gameType) {
    case kGameTypePersonal:
      str = self.personalGame.contact;
      break;
      
    case kGameTypeTeam:
      str = self.teamGame.contact;
      break;
      
    default:
      break;
  }
  
  return str;
}

- (NSString *)remarks
{
  NSString *str = @"";
  switch (self.gameType) {
    case kGameTypePersonal:
      str = self.personalGame.remark;
      break;
      
    case kGameTypeTeam:
      str = self.teamGame.remark;
      break;
      
    default:
      break;
  }
  
  return str;
}

- (NSString *)totalCost
{
  NSString *str = @"";
  switch (self.gameType) {
    case kGameTypePersonal:
      str = self.personalGame.totalCost;
      break;
      
    case kGameTypeTeam:
      str = self.teamGame.totalCost;
      break;
      
    default:
      break;
  }
  
  return str;
}

- (NSString *)time
{
  NSString *str = @"";
  switch (self.gameType) {
    case kGameTypePersonal:
      str = [Tools dateToStr:self.personalGame.time preferUTC:NO];
      break;
      
    case kGameTypeTeam:
      str = [Tools dateToStr:self.teamGame.time preferUTC:NO];
      break;
      
    default:
      break;
  }
  
  return str;
}

- (NSString *)field
{
  NSString *str = @"";
  switch (self.gameType) {
    case kGameTypePersonal:
      str = self.personalGame.field;
      break;
      
    case kGameTypeTeam:
      str = self.teamGame.field;
      break;
      
    default:
      break;
  }
  
  return str;
}

#pragma mark - tableview delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 7;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  NSString *title = @"";
  switch (section) {
    case 0:
      title = TEXT_TIME;
      break;
      
    case 1:
      title = TEXT_FIELD;
      break;
      
    case 3:
      title = TEXT_COST;
      break;
      
    case 4:
      title = TEXT_CONTACT;
      break;
      
    case 5:
      title = TEXT_REMARK;
      break;
      
    default:
      break;
  }
  
  return title;
}

#define GAEM_DETAIL_CELL_ID @"gameDetailCell"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = GAEM_DETAIL_CELL_ID;
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  }
  
  NSString *cellText = @"";
  
  switch (indexPath.section) {
    case 0:
      cellText = self.time;
      break;
      
    case 1:
      cellText = self.field;
      break;
      
    case 2: {
      if (self.gameType == kGameTypePersonal) {
        
      }
      else if (self.gameType == kGameTypeTeam) {
      
      }
      
      break;
    }
      
    case 3:
      cellText = self.totalCost;
      break;
      
    case 4:
      cellText = self.contact;
      break;
      
    case 5:
      cellText = self.remarks;
      break;

    default:
      break;
  }
  
  [cell.textLabel setText:cellText];
  return cell;
}
@end
