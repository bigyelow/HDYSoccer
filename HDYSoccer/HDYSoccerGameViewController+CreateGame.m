//
//  HDYSoccerGameViewController+CreateGame.m
//  HDYSoccer
//
//  Created by bigyelow on 6/8/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameViewController+CreateGame.h"
#import "CreateGameViewController.h"
#import "HDYSoccerNavigationController.h"

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
  
  [self presentViewController:navCtr animated:YES completion:nil];
}
@end
