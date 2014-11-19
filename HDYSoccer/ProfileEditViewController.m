//
//  ProfileEditViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 11/2/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ProfileEditViewController.h"
#import "Geeker.h"
#import "ProfileEditHeaderView.h"
#import "SimpleEditCell.h"

@interface ProfileEditViewController ()
{
  Geeker *_soccer;
  ProfileEditHeaderView *_headerView;
  
  NSArray *_dataArray;
}

@end

@implementation ProfileEditViewController

- (id)initWithSoccer:(Geeker *)soccer
{
  self = [super init];
  if (self) {
    _soccer = soccer;
  }
  
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self setTitle:[NSString stringWithFormat:@"%@的个人资料", _soccer.name]];
  [self configTableView];
  [self configHeader];
  [self registerKeyboardNotification];
}

- (void)dealloc
{
  [self unregisterKeyboardNotification];
}

- (void)configTableView
{
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  
  [self initCells];
  
  UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTapped:)];
  [self.tableView addGestureRecognizer:gest];
}

- (void)configHeader
{
  _headerView = [[ProfileEditHeaderView alloc] init];
  [_headerView updateWithImageURLStr:_soccer.avatarURL];
  CGSize headerSize = [_headerView sizeThatFits:CGSizeMake(self.view.bounds.size.width, 0)];
  [UIConfiguration setView:_headerView size:headerSize];
  
  [self.tableView setTableHeaderView:_headerView];
  [self.tableView reloadData];
}

- (void)tableViewTapped:(UITapGestureRecognizer *)gest
{
  for (SimpleEditCell *cell in _dataArray) {
    [cell resignFirstResponder];
  }
}


#pragma mark - tableview delegate and datasource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  UITableViewCell *cell =  _dataArray[indexPath.row];
  
  return cell;
}

#pragma mark - init cells

- (void)initCells
{
  _dataArray = @[[self nameCell], [self positionCell], [self birthdayCell], [self heightCell]];
}

- (SimpleEditCell *)nameCell
{
  SimpleEditCell *cell = [[SimpleEditCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:NSStringFromClass([SimpleEditCell class])];
  [cell setTitle:TEXT_NAME];
  return cell;
}

- (SimpleEditCell *)positionCell
{
  SimpleEditCell *cell = [[SimpleEditCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:NSStringFromClass([SimpleEditCell class])];
  [cell setTitle:TEXT_POSITION];
  
  
  
  return cell;
}

- (SimpleEditCell *)birthdayCell
{
  SimpleEditCell *cell = [[SimpleEditCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:NSStringFromClass([SimpleEditCell class])];
  [cell setTitle:TEXT_BIRTHDAY];
  return cell;
}

- (SimpleEditCell *)heightCell
{
  SimpleEditCell *cell = [[SimpleEditCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:NSStringFromClass([SimpleEditCell class])];
  [cell setTitle:TEXT_HEIGHT];
  return cell;
}

#pragma mark - Keyboard related
- (void)registerKeyboardNotification
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
}

- (void)unregisterKeyboardNotification
{
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardWillHideNotification
                                                object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardDidShowNotification
                                                object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
  CGRect keyboardRect = [UIConfiguration keyBoardRect:notification];
  
  [self.tableView setContentInset:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, keyboardRect.size.height, 0)];
  [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, keyboardRect.size.height, 0)];
}

- (void)keyboardWillHide:(NSNotification *)notification
{
  [self.tableView setContentInset:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, 0, 0)];
  [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, 0, 0)];
}


@end
