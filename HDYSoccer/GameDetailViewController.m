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

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
