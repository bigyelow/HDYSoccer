//
//  CreateGameDetailViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 6/8/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CreateGameDetailViewController.h"
#import "CreateGameViewController.h"
#import "ChoosePlayerCell.h"
#import "ContactCell.h"
#import "CostCell.h"
#import "RemarkCell.h"
#import "ChooseTeamCell.h"
#import "CreateGameDetailViewController+TopButtons.h"
#import "FXBlurView.h"

#define BACKGROUND_IMAGE_NAME @"background_field1.jpg"

@interface CreateGameDetailViewController ()
{
  CGFloat _lastContentOffsetY; // detect scroll view direction
}

@end

@implementation CreateGameDetailViewController

- (id)initWithStyle:(UITableViewStyle)style
           gameType:(GameType)gameType
{
  self = [super initWithStyle:style];
  if (self) {
    [self setGameType:gameType];
  }
  
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  

  [self configTopItems];
  
  if (self.gameType == kGameTypePersonal) {
    [self setTitle:CREATE_PERSONAL_GAME];
  }
  else if (self.gameType == kGameTypeTeam) {
    [self setTitle:CREATE_TEAM_GAME];
  }
  
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];

  // keyboard observer
  [self configKeyBoardEvents];
  
  // background
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
  [imageView setImage:[UIImage imageNamed:BACKGROUND_IMAGE_NAME]];
  [self.tableView setBackgroundView:imageView];
}

- (void)dealloc
{
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - keyboard operations
- (void)configKeyBoardEvents
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(showKeyBoard:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(hideKeyboard:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)resignAllTheResponder
{
  if ([self.playerCell.textField isFirstResponder]) {
    [self.playerCell.textField resignFirstResponder];
  }
  else if ([self.contactCell.textField isFirstResponder]) {
    [self.contactCell.textField resignFirstResponder];
  }
  else if ([self.costCell.textField isFirstResponder]) {
    [self.costCell.textField resignFirstResponder];
  }
  else if ([self.remarkCell.textView isFirstResponder]) {
    [self.remarkCell.textView resignFirstResponder];
  }
  else if ([self.teamCell.textField isFirstResponder]) {
    [self.teamCell.textField resignFirstResponder];
  }
}

- (void)showKeyBoard:(NSNotification *)notification
{
  CGRect keyboardRect = [UIConfiguration keyBoardRect:notification];
  NSIndexPath *indexPath;
  
  if ([self.playerCell.textField isFirstResponder]) {
    indexPath = [self.tableView indexPathForCell:self.playerCell];
  }
  else if ([self.contactCell.textField isFirstResponder]) {
    indexPath = [self.tableView indexPathForCell:self.contactCell];
  }
  else if ([self.costCell.textField isFirstResponder]) {
    indexPath = [self.tableView indexPathForCell:self.costCell];
  }
  else if ([self.remarkCell.textView isFirstResponder]) {
    indexPath = [self.tableView indexPathForCell:self.remarkCell];
  }
  else if ([self.teamCell.textField isFirstResponder]) {
    indexPath = [self.tableView indexPathForCell:self.teamCell];
  }
  
  if (indexPath) {
    [self moveCellAboveKeyboard:indexPath keyboardRect:keyboardRect];
  }
}

- (void)hideKeyboard:(NSNotification *)notification
{
  UIEdgeInsets contentInsets = UIEdgeInsetsZero;
  
  [UIView animateWithDuration:0.4
                        delay:0.0
                      options:UIViewAnimationOptionCurveLinear
                   animations:^{
                     self.tableView.contentInset = contentInsets;
                     self.tableView.scrollIndicatorInsets = contentInsets;
                   }
                   completion:nil];
}

#define KEYBOARD_TOP_MARGIN 10.0f
- (void)moveCellAboveKeyboard:(NSIndexPath *)indexPath
                 keyboardRect:(CGRect)keyboardRect
{
  CGRect cellRect = [self.tableView rectForRowAtIndexPath:indexPath];
  
  UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardRect.size.height, 0.0);
  self.tableView.contentInset = contentInsets;
  self.tableView.scrollIndicatorInsets = contentInsets;
  
  CGRect aRect = self.view.frame;
  aRect.size.height -= keyboardRect.size.height;
  
  if (!CGRectContainsPoint(aRect, cellRect.origin) ) {
    [self.tableView scrollRectToVisible:cellRect animated:YES];
  }
}

#pragma mark - tableview delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

#define CREATE_GAME_DETAIL_CELL_ID @"creatGameDetailCell"

#define SELECT_TIME_TITLE @"选择时间"
#define SELECT_FIELD_TITLE @"选择场地"

#define SELECT_TEAM_TITLE @"选择球队"
#define SELECT_FRIENDS_TITLE @"邀请我的好友"
#define CONTACE_TITLE @"联系方式"
#define REMARKS_TITLE @"备注"
#define COST_TITLE @"费用"
#define COST_TITLE_PERPERSON @"人均"

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section == 5) {
    return REMARK_CELL_FIELD_HEIGHT;
  }
  return 44.0f;
}

#define SELECT_TIME_FORMAT_TITLE @"踢球时间：%@"
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *identifier = CREATE_GAME_DETAIL_CELL_ID;
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
  if (!cell) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                  reuseIdentifier:identifier];
    [cell setSelectionStyle:UITableViewCellSelectionStyleGray];
    [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];
  }
  
  NSString *cellTitle;
  
  switch (indexPath.section) {
    case 0:
      if (!self.gameTime) {
        cellTitle = SELECT_TIME_TITLE;
      }
      else {
        NSString *time = [Tools dateminuteToStr:self.gameTime preferUTC:NO];
        cellTitle = [NSString stringWithFormat:SELECT_TIME_FORMAT_TITLE, time];
      }
      break;
      
    case 1:
      cellTitle = SELECT_FIELD_TITLE;
      break;
      
    case 2:
      if (self.gameType == kGameTypePersonal) {
        ChoosePlayerCell *cell = [[ChoosePlayerCell alloc]
                                  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CREATE_GAME_DETAIL_PLAYER_CELL_ID];
        self.playerCell = cell;
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
      }
      else if (self.gameType == kGameTypeTeam) {
        ChooseTeamCell *cell = [[ChooseTeamCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier:CREATE_GAME_DETAIL_TEAM_CELL_ID];
        self.teamCell = cell;
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
      }
      break;
      
    case 3: {
      ContactCell *cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:CREATE_GAME_DETAIL_CONTACT_CELL_ID
                                                       title:CONTACE_TITLE];
      self.contactCell = cell;
      [cell setBackgroundColor:[UIColor clearColor]];
      return cell;
    }
      
    case 4: {
      CostCell *cell = [[CostCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CREATE_GAEM_DETAIL_COST_CELL_ID
                                                 title:COST_TITLE];
      self.costCell = cell;
      [cell setBackgroundColor:[UIColor clearColor]];
      return cell;
    }
      
    case 5: {
      RemarkCell *cell = [[RemarkCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:CREATE_GAME_DETAIL_REMAR_CELL_ID];
      self.remarkCell = cell;
      [cell setBackgroundColor:[UIColor clearColor]];
      return cell;
    }
      
    default:
      break;
  }
  
  [cell.textLabel setText:cellTitle];
  
  [cell setBackgroundColor:[UIColor clearColor]];
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  
  switch (indexPath.section) {
    case 0:
      [self openDateSelectionController];
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
  [self setGameTime:aDate];
  [self.tableView reloadData];
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc
{

}

#pragma mark - UIScrollView delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
  CGFloat scrollOffset = scrollView.contentOffset.y;
  CGFloat scrollViewHeight = scrollView.frame.size.height;
  CGFloat scrollContentSizeHeight = scrollView.contentSize.height;

  if (_lastContentOffsetY > scrollOffset
      && scrollOffset + scrollViewHeight < scrollContentSizeHeight) {
    [self resignAllTheResponder];
  }

  _lastContentOffsetY = scrollView.contentOffset.y;
}

@end
