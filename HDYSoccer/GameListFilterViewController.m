//
//  GameListFilterViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 6/7/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GameListFilterViewController.h"

@interface GameListFilterViewController ()

@end

#define FILTER_VIEW_TITLE @"选择时间和场地"
@implementation GameListFilterViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self setTitle:FILTER_VIEW_TITLE];
  [self configTopItems];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - top items
- (void)configTopItems
{
  UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:TEXT_OK
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(confirmItemPressed)];
  
  UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithTitle:TEXT_CANCEL
                                                                 style:UIBarButtonItemStyleBordered
                                                                target:self
                                                                action:@selector(cancelItemPressed)];
  [self.navigationItem setRightBarButtonItem:confirmItem];
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

#define FILTER_CELL_ID @"filter_cell"

#define SELECT_TIME_TITLE @"选择时间"
#define SELECT_FIELD_TITLE @"选择场地"
#define SELECT_TIME_FORMAT_TITLE @"踢球时间：%@"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = FILTER_CELL_ID;
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
  }

  switch (indexPath.section) {
    case 0:
      if (!self.filterDate) {
        [cell.textLabel setText:SELECT_TIME_TITLE];
      }
      else {
        NSString *time = [Tools dateminuteToStr:self.filterDate preferUTC:NO];
        NSString *cellText = [NSString stringWithFormat:SELECT_TIME_FORMAT_TITLE, time];
        [cell.textLabel setText:cellText];
      }
      break;
      
    case 1:
      [cell.textLabel setText:SELECT_FIELD_TITLE];
      break;
      
    default:
      break;
  }
  return cell;
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