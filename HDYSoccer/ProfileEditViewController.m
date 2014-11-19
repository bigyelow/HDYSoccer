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

#import "KeyboardTopView.h"

static NSInteger const kMinHeight = 150;
static NSInteger const kMaxHeight = 230;

@interface ProfileEditViewController ()
{
  Geeker *_soccer;
  NSDate *_pickedDate;
  NSString *_pickedHeight, *_pickedPosition, *_posit1, *_posit2;
  ProfileEditHeaderView *_headerView;
  SimpleEditCell *_nameCell, *_positionCell, *_birthdayCell, *_heightCell;
  UIPickerView *_positionPickerView, *_heightPickerView;
  
  NSArray *_dataArray;
  NSMutableArray *_positionsArray;
}

@end

@implementation ProfileEditViewController

- (id)initWithSoccer:(Geeker *)soccer
{
  self = [super init];
  if (self) {
    _soccer = soccer;
    
    _positionsArray = [NSMutableArray arrayWithObject:TEXT_NOT_SELECTED];
    [_positionsArray addObjectsFromArray:[Tools positionsArray]];
    _posit1 = _posit2 = TEXT_NOT_SELECTED;
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
  _nameCell = cell;
  return cell;
}

- (SimpleEditCell *)positionCell
{
  SimpleEditCell *cell = [[SimpleEditCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:NSStringFromClass([SimpleEditCell class])];
  [cell setTitle:TEXT_POSITION];
  
  CGFloat topWidth = self.view.bounds.size.width;
  KeyboardTopView *keyboardTopView = [[KeyboardTopView alloc] initWithFrame:CGRectMake(0, 0, topWidth, KEYBOARD_TOP_VIEW_HEIGHT)];
  [keyboardTopView.confirmButton addTarget:self action:@selector(positionPicked) forControlEvents:UIControlEventTouchUpInside];
  [cell setInputAccessoryView:keyboardTopView];
  
  UIPickerView *positionPicker = [UIPickerView new];
  [positionPicker setBackgroundColor:[UIColor whiteColor]];
  [positionPicker setDelegate:self];
  [positionPicker setDataSource:self];
  [cell setInputView:positionPicker];
  _positionPickerView = positionPicker;
  
  _positionCell = cell;
  return cell;
}

- (SimpleEditCell *)birthdayCell
{
  SimpleEditCell *cell = [[SimpleEditCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:NSStringFromClass([SimpleEditCell class])];
  [cell setTitle:TEXT_BIRTHDAY];
  
  CGFloat topWidth = self.view.bounds.size.width;
  KeyboardTopView *keyboardTopView = [[KeyboardTopView alloc] initWithFrame:CGRectMake(0, 0, topWidth, KEYBOARD_TOP_VIEW_HEIGHT)];
  [keyboardTopView.confirmButton addTarget:self action:@selector(datePicked) forControlEvents:UIControlEventTouchUpInside];
  [cell setInputAccessoryView:keyboardTopView];
  
  UIDatePicker *datePicker = [UIDatePicker new];
  [datePicker setDatePickerMode:UIDatePickerModeDate];
  [datePicker setBackgroundColor:[UIColor whiteColor]];
  [datePicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
  [cell setInputView:datePicker];
  
  _birthdayCell = cell;

  return cell;
}

- (SimpleEditCell *)heightCell
{
  SimpleEditCell *cell = [[SimpleEditCell alloc] initWithStyle:UITableViewCellStyleDefault
                                               reuseIdentifier:NSStringFromClass([SimpleEditCell class])];
  [cell setTitle:TEXT_HEIGHT];
  
  CGFloat topWidth = self.view.bounds.size.width;
  KeyboardTopView *keyboardTopView = [[KeyboardTopView alloc] initWithFrame:CGRectMake(0, 0, topWidth, KEYBOARD_TOP_VIEW_HEIGHT)];
  [keyboardTopView.confirmButton addTarget:self action:@selector(heightPicked) forControlEvents:UIControlEventTouchUpInside];
  [cell setInputAccessoryView:keyboardTopView];
  
  UIPickerView *heightPicker = [UIPickerView new];
  [heightPicker setBackgroundColor:[UIColor whiteColor]];
  [heightPicker setDelegate:self];
  [heightPicker setDataSource:self];
  [cell setInputView:heightPicker];
  _heightPickerView = heightPicker;
  
  _heightCell = cell;
  return cell;
}

#pragma mark - actions

// position
- (void)positionPicked
{
  [_positionCell setText:_pickedPosition];
  [_positionCell resignFirstResponder];
}

// date
- (void)datePicked
{
  [_birthdayCell setText:[Tools dateOnlyToStr:_pickedDate preferUTC:NO]];
  [_birthdayCell resignFirstResponder];
}

- (void)datePickerDateChanged:(UIDatePicker *)paramDatePicker
{
  _pickedDate = paramDatePicker.date;
}

// height
- (void)heightPicked
{
  [_heightCell setText:_pickedHeight];
  [_heightCell resignFirstResponder];
}

// tableView
- (void)tableViewTapped:(UITapGestureRecognizer *)gest
{
  for (SimpleEditCell *cell in _dataArray) {
    [cell resignFirstResponder];
  }
}

#pragma mark - pickerview delegate and datasource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
  if (pickerView == _heightPickerView) {
    return 1;
  }
  else if (pickerView == _positionPickerView) {
    return 2;
  }
  return 0;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
  if (pickerView == _heightPickerView) {
    return kMaxHeight - kMinHeight + 1;
  }
  else if (pickerView == _positionPickerView) {
    return _positionsArray.count;
  }
  
  return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
  if (pickerView == _heightPickerView) {
    NSString *title = [NSString stringWithFormat:@"%ldcm", (long)kMinHeight + row];
    return title;
  }
  else if (pickerView == _positionPickerView) {
    return _positionsArray[row];
  }
  return nil;
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
  if (pickerView == _heightPickerView) {
    _pickedHeight = [NSString stringWithFormat:@"%ldcm", (long)kMinHeight + row];
  }
  else if (pickerView == _positionPickerView) {
    switch (component) {
      case 0:
        _posit1 = _positionsArray[row];
        break;
        
      case 1:
        _posit2 = _positionsArray[row];
        break;
        
      default:
        break;
    }
    
    NSMutableString *positions = [NSMutableString string];
    if (![_posit1 isEqualToString:TEXT_NOT_SELECTED]) {
      [positions appendString:_posit1];
    }
    if (![_posit2 isEqualToString:TEXT_NOT_SELECTED] && ![_posit2 isEqualToString:_posit1]) {
      [positions appendString:[NSString stringWithFormat:@",%@",_posit2]];
    }
    _pickedPosition = positions;
  }
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
