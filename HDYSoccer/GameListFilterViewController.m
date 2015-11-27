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
#import "FXBlurView.h"

@interface GameListFilterViewController ()

@end

@implementation GameListFilterViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self setTitle:@"选择时间和场地"];
  [self configTopItems];
  
  [self.tableView setScrollEnabled:NO];
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  [self.tableView registerClass:[GameListFilterFieldTableViewCell class]
         forCellReuseIdentifier:NSStringFromClass([GameListFilterFieldTableViewCell class])];
  [self.tableView registerClass:[GameListFilterTableViewCell class]
         forCellReuseIdentifier:NSStringFromClass([GameListFilterTableViewCell class])];
  
  // background
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
  [imageView setImage:[UIImage imageNamed:@"background_field1.jpg"]];
  [self.tableView setBackgroundView:imageView];
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
    if ((self.filterDate || self.filterField) && self.reloadGameListDelegate
        && [self.reloadGameListDelegate respondsToSelector:@selector(reloadGameListWithParams:)]) {
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

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch (indexPath.row) {
    case 0: {
      GameListFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GameListFilterTableViewCell class]) forIndexPath:indexPath];

      if (self.filterDate) {
        NSString *time = [Tools dateOnlyToStr:self.filterDate preferUTC:NO];
        NSString *cellText = [NSString stringWithFormat:@"踢球时间：%@", time];
        [cell.timeLabel setText:cellText];
        [cell.timeLabel setNumberOfLines:1];
        [cell.timeLabel sizeToFit];
      }
      
      return cell;
    }
      
    case 1: {
      GameListFilterFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GameListFilterFieldTableViewCell class]) forIndexPath:indexPath];

      if (self.filterField) {
        [cell configCellWithField:self.filterField];
      }
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
  
  switch (indexPath.row) {
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

- (void)openDateSelectionController
{
  [RMDateSelectionViewController setLocalizedTitleForCancelButton:TEXT_CANCEL];
  [RMDateSelectionViewController setLocalizedTitleForSelectButton:TEXT_OK];
  
  RMDateSelectionViewController *dateSelectionVC = [RMDateSelectionViewController dateSelectionController];
  dateSelectionVC.delegate = self;
  [dateSelectionVC.titleLabel setText:@"选择时间"];
  
  [dateSelectionVC setHideNowButton:YES];
  dateSelectionVC.datePicker.datePickerMode = UIDatePickerModeDate;
  dateSelectionVC.datePicker.minuteInterval = 10.0;
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
