//
//  CreateGameViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 6/8/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CreateGameViewController.h"

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
#define CREATE_PERSONAL_GAME @"创建小场活动"
#define CREATE_TEAM_GAME @"创建大场比赛"
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
