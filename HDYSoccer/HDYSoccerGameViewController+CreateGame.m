//
//  HDYSoccerGameViewController+CreateGame.m
//  HDYSoccer
//
//  Created by bigyelow on 6/8/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameViewController+CreateGame.h"
#import "HDYSoccerNavigationController.h"
#import "GameDetailViewController.h"

@implementation HDYSoccerGameViewController (CreateGame)

- (void)configTopCreateButton
{
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd
                                                                        target:self
                                                                        action:@selector(createGameButtonPressed)];
  [self.navigationItem setRightBarButtonItem:item];
}

- (void)createGameButtonPressed
{
  CreateGameViewController *viewCtr = [[CreateGameViewController alloc] initWithStyle:UITableViewStyleGrouped];
  HDYSoccerNavigationController *navCtr = [[HDYSoccerNavigationController alloc] initWithRootViewController:viewCtr];
  
  [viewCtr setCreateGameDelegate:self];
  
  [self presentViewController:navCtr animated:YES completion:nil];
}

#pragma mark - create game delegate
- (void)createGameSucceeded:(NSDictionary *)dic
{ 
  GameDetailViewController *viewCtr = [[GameDetailViewController alloc] initWithGameInfo:dic
                                                                          tableViewStyle:UITableViewStyleGrouped];
  HDYSoccerNavigationController *navCtr = [[HDYSoccerNavigationController alloc] initWithRootViewController:viewCtr];
  
  [self presentViewController:navCtr animated:YES completion:nil];
}
@end
