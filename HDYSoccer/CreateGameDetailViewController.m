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
#import "GameListFilterFieldTableViewCell.h"
#import "GameListFilterTableViewCell.h"
#import "KeyboardTopView.h"
#import "ChooseFieldCell.h"
#import "ChooseTableViewController.h"
#import "CPTransitionAnimator.h"

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

#pragma mark - interation
- (void)addFriendButtonPressed
{
  ChooseTableViewController *vc = [[ChooseTableViewController alloc] initWithType:kChooseTableTypeFriend];
  [vc setTransitioningDelegate:self];
  [vc setModalPresentationStyle:UIModalPresentationCustom];
  [self presentViewController:vc animated:YES completion:nil];
}

#pragma mark - keyboard operations
- (void)configKeyBoardEvents
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
  
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification
{

  // keyboard top view
  if (!self.keyboardTopView) {
    CGFloat topWidth = self.view.bounds.size.width;
    KeyboardTopView *topView = [[KeyboardTopView alloc] initWithFrame:CGRectMake(0, self.view.bounds.size.height, topWidth, KEYBOARD_TOP_VIEW_HEIGHT)];
    
    self.keyboardTopView = topView;
    [self.keyboardTopView.confirmButton addTarget:self action:@selector(resignAllTheResponder) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:topView];
  }

  CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
  CGFloat keyBoardViewHeight = keyboardRect.size.height + KEYBOARD_TOP_VIEW_HEIGHT;
  CGFloat topY = self.view.frame.size.height - keyBoardViewHeight;
  
  // animations settings
  NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
  UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
  
  [UIView animateWithDuration:duration
                        delay:0
                      options:option
                   animations:^{
                     [UIConfiguration setView:self.keyboardTopView y:topY];
                   } completion:nil];
  
  [self.tableView setContentInset:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, keyBoardViewHeight, 0)];
  [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, keyBoardViewHeight, 0)];
  
  // config cell position
  NSIndexPath *indexPath;
  if ([self.playerCell.textField isFirstResponder]) {
    indexPath = self.playerCellIndexPath;
  }
  else if ([self.fieldCell.textView isFirstResponder]) {
    indexPath = self.fieldCellIndexPath;
  }
  else if ([self.contactCell.textField isFirstResponder]) {
    indexPath = self.contactCellIndexPath;
  }
  else if ([self.costCell.textField isFirstResponder]) {
    indexPath = self.costCellIndexPath;
  }
  else if ([self.remarkCell.textView isFirstResponder]) {
    indexPath = self.remarkCellIndexPath;
  }
  else if ([self.teamCell.textField isFirstResponder]) {
    indexPath = self.teamCellIndexPath;
  }
  if (indexPath) {
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
  }
}

// keyboard will hide
- (void)keyboardWillHide:(NSNotification *)notification
{
  self.keyboardShowed = NO;
  
  NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
  UIViewAnimationCurve option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
  
  // animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationDuration:duration];
  [UIView setAnimationCurve:option];
  
  [UIConfiguration setView:self.keyboardTopView y:self.view.frame.size.height];
  [self.tableView setContentInset:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, 0, 0)];
  [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, 0, 0)];
  
  [UIView commitAnimations];
}

- (void)resignAllTheResponder
{
  if ([self.playerCell.textField isFirstResponder]) {
    [self.playerCell.textField resignFirstResponder];
  }
  else if ([self.fieldCell.textView isFirstResponder]) {
    [self.fieldCell.textView resignFirstResponder];
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
#define SELECT_TEAM_TITLE @"选择球队"
#define SELECT_FRIENDS_TITLE @"邀请我的好友"
#define REMARKS_TITLE @"备注"
#define COST_TITLE_PERPERSON @"人均"

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (indexPath.section == 1) {
    return CHOOSE_FIELD_CELL_HEIGHT;
  }
  if (indexPath.section == 5) {
    return REMARK_CELL_FIELD_HEIGHT;
  }
  return 44.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch (indexPath.section) {
    case 0: {
      NSString *cellID = GAME_LIST_FILTER_CELL_ID;
      GameListFilterTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
      if (cell == nil) {
        cell = [[GameListFilterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
      }
      
      if (self.gameTime) {
        NSString *time = [Tools dateminuteToStr:self.gameTime preferUTC:NO];
        NSString *cellText = [NSString stringWithFormat:TEXT_SELECT_TIME_FORMAT_TITLE, time];
        [cell.timeLabel setText:cellText];
        [cell.timeLabel setNumberOfLines:1];
        [cell.timeLabel sizeToFit];
      }
      
      return cell;
    }
      
    case 1: {
      NSString *cellID = CHOOSE_FIELD_CELL_ID;
      ChooseFieldCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
      if (cell == nil) {
        cell = [[ChooseFieldCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
      }
      
      self.fieldCell = cell;
      self.fieldCellIndexPath = indexPath;
      self.fieldCell.textView.delegate = self;
      return cell;
    }
      
    case 2:
      if (self.gameType == kGameTypePersonal) {
        ChoosePlayerCell *cell = [[ChoosePlayerCell alloc]
                                  initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CREATE_GAME_DETAIL_PLAYER_CELL_ID];
        self.playerCell = cell;
        self.playerCell.textField.delegate = self;
        self.playerCellIndexPath = indexPath;
        [cell setBackgroundColor:[UIColor clearColor]];
        
        [cell.addFriendButton addTarget:self action:@selector(addFriendButtonPressed) forControlEvents:UIControlEventTouchUpInside];
        
        return cell;
      }
      else if (self.gameType == kGameTypeTeam) {
        ChooseTeamCell *cell = [[ChooseTeamCell alloc] initWithStyle:UITableViewCellStyleDefault
                                                     reuseIdentifier:CREATE_GAME_DETAIL_TEAM_CELL_ID];
        self.teamCell = cell;
        self.teamCell.textField.delegate = self;
        self.teamCellIndexPath = indexPath;
        [cell setBackgroundColor:[UIColor clearColor]];
        return cell;
      }
      break;
      
    case 3: {
      CostCell *cell = [[CostCell alloc] initWithStyle:UITableViewCellStyleDefault
                                       reuseIdentifier:CREATE_GAEM_DETAIL_COST_CELL_ID
                                                 title:TEXT_COST_TITLE];
      self.costCell = cell;
      self.costCell.textField.delegate = self;
      self.costCellIndexPath = indexPath;
      [cell setBackgroundColor:[UIColor clearColor]];
      return cell;
    }
      
    case 4: {
      ContactCell *cell = [[ContactCell alloc] initWithStyle:UITableViewCellStyleDefault
                                             reuseIdentifier:CREATE_GAME_DETAIL_CONTACT_CELL_ID
                                                       title:TEXT_CONTACT];
      self.contactCell = cell;
      self.contactCell.textField.delegate = self;
      self.contactCellIndexPath = indexPath;
      [cell setBackgroundColor:[UIColor clearColor]];
      return cell;
    }
      
    case 5: {
      RemarkCell *cell = [[RemarkCell alloc] initWithStyle:UITableViewCellStyleDefault
                                           reuseIdentifier:CREATE_GAME_DETAIL_REMAR_CELL_ID];
      self.remarkCell = cell;
      self.remarkCell.textView.delegate = self;
      self.remarkCellIndexPath = indexPath;
      [cell setBackgroundColor:[UIColor clearColor]];
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
      [self resignAllTheResponder];
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
  [self.tableView beginUpdates];
  [self.tableView reloadRowsAtIndexPaths:@[[NSIndexPath indexPathForRow:0 inSection:0]] withRowAnimation:UITableViewRowAnimationFade];
  [self.tableView endUpdates];
}

- (void)dateSelectionViewControllerDidCancel:(RMDateSelectionViewController *)vc
{

}

#pragma mark - UITextView delegate

- (void)textViewDidBeginEditing:(UITextView *)textView
{
  if (self.keyboardShowed) {
    NSIndexPath *indexPath;
    if ([self.fieldCell.textView isFirstResponder]) {
      indexPath = self.fieldCellIndexPath;
    }
    else if ([self.remarkCell.textView isFirstResponder]) {
      indexPath = self.remarkCellIndexPath;
    }
    [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
  }
}

#pragma mark - UITextField delegate

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
  if (self.keyboardShowed) {
    NSIndexPath *indexPath;
    if ([self.playerCell.textField isFirstResponder]) {
      indexPath = self.playerCellIndexPath;
    }
    else if ([self.contactCell.textField isFirstResponder]) {
      indexPath = self.contactCellIndexPath;
    }
    else if ([self.costCell.textField isFirstResponder]) {
      indexPath = self.costCellIndexPath;
    }
    else if ([self.teamCell.textField isFirstResponder]) {
      indexPath = self.teamCellIndexPath;
    }
    
    if (indexPath) {
      [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionBottom animated:YES];
    }
  }
}

#pragma mark - UIViewControllerTransitioningDelegate Methods

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented
                                                                  presentingController:(UIViewController *)presenting
                                                                      sourceController:(UIViewController *)source
{
  
  CPTransitionAnimator *animator = [CPTransitionAnimator new];
  //Configure the animator
  animator.presenting = YES;
  return animator;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
  CPTransitionAnimator *animator = [CPTransitionAnimator new];
  return animator;
}

@end
