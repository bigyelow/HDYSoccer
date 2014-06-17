//
//  CreateGameViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 6/8/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CreateGameViewController.h"
#import "CreateGameDetailViewController.h"

#define CREATE_GAME_TITLE @"创建约球"

@interface CreateGameViewController ()

@end

@implementation CreateGameViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self setTitle:CREATE_GAME_TITLE];
  
  [self configTopItems];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)configTopItems
{
  UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:TEXT_CANCEL
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self
                                                                action:@selector(cancelItemPressed)];
  [self.navigationItem setLeftBarButtonItem:cancelItem];
}

- (void)cancelItemPressed
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableview delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

#define CREATE_GAME_CELL_ID @"createGameCell"

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = CREATE_GAME_CELL_ID;
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
  }
  
  switch (indexPath.section) {
    case 0:
      [cell.textLabel setText:CREATE_PERSONAL_GAME];
      break;
      
    case 1:
      [cell.textLabel setText:CREATE_TEAM_GAME];
      break;
      
    default:
      break;
  }
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:NO];

  GameType gameType = kGameTypePersonal;
  switch (indexPath.section) {
    case 0:
      gameType = kGameTypePersonal;
      break;
      
    case 1:
      gameType = kGameTypeTeam;
      break;
  
    default:
      break;
  }
  
  
  CreateGameDetailViewController *createCtr = [[CreateGameDetailViewController alloc]
                                               initWithStyle:UITableViewStyleGrouped
                                               gameType:gameType];
  [self.navigationController pushViewController:createCtr animated:YES];
}

@end
