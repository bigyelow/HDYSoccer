//
//  SettingsViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 1/2/15.
//  Copyright (c) 2015 bigyelow. All rights reserved.
//

#import "SettingsViewController.h"
#import "REFrostedViewController.h"

#import "PSPDFAlertView.h"

@interface SettingsViewController ()

@property (nonatomic, strong) NSArray *tableViewCells;
@property (nonatomic, strong) UITableViewCell *logoutCell;

@end

@implementation SettingsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self setTitle:@"设置"];
  [self configTopMenuButton];
  [self _soc_configCells];
  
  [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(_soc_panGestureRecognized:)]];
}

#pragma mark - configuration

- (void)_soc_configCells
{
  if (!_tableViewCells) {
    _tableViewCells = @[@[[self _soc_LogoutCell]]];
  }
}

- (UITableViewCell *)_soc_LogoutCell
{
  if (!_logoutCell) {
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
    [cell.textLabel setText:@"退出登录"];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    _logoutCell = cell;
  }
  
  return _logoutCell;
}


#pragma mark - TableView delegate and datasource


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return _tableViewCells.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSArray *array = _tableViewCells[section];
  return array.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return _tableViewCells[indexPath.section][indexPath.row];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (_tableViewCells[indexPath.section][indexPath.row] == _logoutCell) {
    PSPDFAlertView *alertView = [[PSPDFAlertView alloc] initWithTitle:nil message:@"确定要退出登录？"];
    [alertView addButtonWithTitle:@"确定" block:^(NSInteger buttonIndex) {
      [[AppContext appContext] clearInfo];
    }];
    [alertView setCancelButtonWithTitle:@"取消" block:nil];
    [alertView setCancelButtonIndex:0];
    [alertView show];
  }
  
  [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


#pragma mark - Gesture recognizer

- (void)_soc_panGestureRecognized:(UIPanGestureRecognizer *)sender
{
  // Dismiss keyboard (optional)
  [self.view endEditing:YES];
  [self.frostedViewController.view endEditing:YES];
  
  // Present the view controller
  [self.frostedViewController panGestureRecognized:sender];
}

@end
