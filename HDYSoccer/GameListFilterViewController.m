//
//  GameListFilterViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 6/7/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GameListFilterViewController.h"
#import "GameListFilterTableViewCell.h"
#import "GameListFilterFieldTableViewCell.h"

@interface GameListFilterViewController ()

@end

#define FILTER_VIEW_TITLE @"选择时间和场地"
#define FILTER_BACKGROUND_IMAGE @"field4.jpg"

@implementation GameListFilterViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self setTitle:FILTER_VIEW_TITLE];
  [self configTopItems];
  
  [self.tableView setScrollEnabled:NO];
  
  // background
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  [self.tableView setBackgroundColor:[UIColor clearColor]];
  [Tools blurView:self.view image:[UIImage imageNamed:FILTER_BACKGROUND_IMAGE] blurRadius:1];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - top items
- (void)configTopItems
{
  // confirm item
  UIButton *confirmButton = [self topButtonWithImageName:TOP_CONFIRM_IMAGE];
  [UIConfiguration setView:confirmButton size:CGSizeMake(TOP_CONFIRM_BUTTON_WIDTH, TOP_CONFIRM_BUTTON_WIDTH)];
  [confirmButton addTarget:self action:@selector(confirmItemPressed) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithCustomView:confirmButton];
  [self.navigationItem setRightBarButtonItem:confirmItem];
  
  // cancel item
  UIButton *cancelButton = [self topButtonWithImageName:TOP_CANCEL_IMAGE];
  [UIConfiguration setView:cancelButton size:CGSizeMake(TOP_CANCEL_BUTTON_WIDTH, TOP_CANCEL_BUTTON_WIDTH)];
  [cancelButton addTarget:self action:@selector(cancelItemPressed) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
  [self.navigationItem setLeftBarButtonItem:cancelItem];
}

- (void)confirmItemPressed
{
  [self dismissViewControllerAnimated:YES completion:^{
    if ((self.filterDate || self.filterField)
        && self.reloadGameListDelegate
        && [self.reloadGameListDelegate
        respondsToSelector:@selector(reloadGameListWithParams:)]) {
          NSMutableDictionary *dic = [NSMutableDictionary dictionary];
          if (self.filterDate) {
            [dic setObject:self.filterDate forKey:PARAM_DATE];
          }
          if (self.filterField) {
            [dic setObject:self.filterField forKey:PARAM_FIELD];
          }
          [self.reloadGameListDelegate performSelector:@selector(reloadGameListWithParams:) withObject:dic];
    }
  }];
}

- (void)cancelItemPressed
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableview delegate and datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

#define SELECT_FIELD_TITLE @"选择场地"
#define SELECT_TIME_FORMAT_TITLE @"踢球时间：%@"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch (indexPath.section) {
    case 0: {
      NSString *cellID = GAME_LIST_FILTER_CELL_ID;
      GameListFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
      if (cell == nil) {
        cell = [[GameListFilterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
      }
      [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
      
      if (self.filterDate) {
        NSString *time = [Tools dateminuteToStr:self.filterDate preferUTC:NO];
        NSString *cellText = [NSString stringWithFormat:SELECT_TIME_FORMAT_TITLE, time];
        [cell.timeLabel setText:cellText];
        [cell.timeLabel setNumberOfLines:1];
        [cell.timeLabel sizeToFit];
      }
      
      return cell;
    }
      
    case 1: {
      NSString *cellID = GAME_LIST_FILTER_CELL_ID;
      GameListFilterFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
      if (cell == nil) {
        cell = [[GameListFilterFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
      }
      [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

      return cell;
    }
      
    default:
      break;
  }
  return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  
  switch (indexPath.section) {
    case 0:
      // select date
      [self openDateSelectionController];
      break;
      
    case 1:
      // select field
      break;
      
    default:
      break;
  }
}

#pragma mark - RMDAteSelectionViewController operations and delegate

#define MINUTE_INTERVAL 10.0f
#define SELECT_TIME_TITLE @"选择时间"

- (void)openDateSelectionController
{
  [RMDateSelectionViewController setLocalizedTitleForCancelButton:TEXT_CANCEL];
  [RMDateSelectionViewController setLocalizedTitleForSelectButton:TEXT_OK];
  
  RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
  dateSelectionVC.delegate = self;
  [dateSelectionVC.titleLabel setText:SELECT_TIME_TITLE];
  
  [dateSelectionVC setHideNowButton:YES];
  dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
  dateSelectionVC.datePicker.minuteInterval = MINUTE_INTERVAL;
  dateSelectionVC.datePicker.date = [NSDate date];
  
  [dateSelectionVC show];
}

- (void)dateSelectionViewController:(RMDateSelectionViewController *)vc didSelectDate:(NSDate *)aDate
{
  [self setFilterDate:aDate];
  [self.tableView reloadData];
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc
{
  
}

@end
