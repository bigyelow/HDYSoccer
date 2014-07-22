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
  UIImage *image = [UIImage imageNamed:@"plus-50.png"];
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  [button setBackgroundImage:image forState:UIControlStateNormal];
  [UIConfiguration setView:button size:CGSizeMake(25, 25)];
  [button addTarget:self action:@selector(createGameButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
  
  NSMutableArray *rightItems = [self.navigationItem.rightBarButtonItems mutableCopy];
  [rightItems insertObject:item atIndex:0];
  [self.navigationItem setRightBarButtonItems:rightItems];
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
