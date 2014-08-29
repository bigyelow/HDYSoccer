//
//  ChooseParticipantViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 8/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ChooseTableViewController.h"
#import "ChooseTableCell.h"
#import "ChooseTableViewController+Network.h"
#import "SimpleGeekerInfo.h"
#import "SimpleTeamInfo.h"
#import "CommonButton.h"
#import "CPTransitionAnimator.h"

#define BOTTOM_BACK_HEIGHT 50
#define BOTTOM_BUTTON_HEIGHT 28
#define BOTTOM_BUTTON_LEFT_MARGIN 10
#define BOTTOM_BUTTON_INTERAL_MARGIN 7
#define BOTTOM_BUTTON_FONT_SIZE 15

@interface ChooseTableViewController ()

@end

@implementation ChooseTableViewController

- (id)initWithType:(ChooseTableType)type
           delegae:(id<ChooseTableViewDelegate>)delegate
{
  self = [super init];
  if (self) {
    self.type = type;
    self.chooseTableDelegate = delegate;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self configTableView];
  [self configBottomButtons];

  if (self.type == kChooseTableTypeFriend) {
    [self loadMyFriends];
  }
  else if (self.type == kChooseTableTypeTeam) {
    [self loadMyTeams];
  }
}

- (void)configTableView
{
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  [UIConfiguration setView:self.tableView height:self.view.frame.size.height - BOTTOM_BACK_HEIGHT];
  [self.tableView setContentInset:UIEdgeInsetsMake(STATUS_BAR_HEIGHT, 0, 0, 0)];
  [self.tableView setScrollIndicatorInsets:self.tableView.contentInset];
  
  UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0.5, self.view.frame.size.height)];
  [line setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR_CLEAR]];
  
  [self.view addSubview:line];
}


- (void)configBottomButtons
{
  CGFloat backY = CPTRANSITION_ENDFRAME_HEIGHT - BOTTOM_BACK_HEIGHT;
  CGFloat backWidth = CPTRANSITION_ENDFRAME_WIDTH;
  UIView *bottomBackView = [[UIView alloc] initWithFrame:CGRectMake(0, backY, backWidth, BOTTOM_BACK_HEIGHT)];
  
  [self.view addSubview:bottomBackView];
  
  // SEPERATOR
  UIView *seper = [[UIView alloc] initWithFrame:CGRectMake(0, 0, backWidth, 0.5)];
  [seper setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR_CLEAR]];
  
  [bottomBackView addSubview:seper];
  
  // cancel button
  CGFloat buttonWidth = (backWidth - 2 * BOTTOM_BUTTON_LEFT_MARGIN - BOTTOM_BUTTON_INTERAL_MARGIN) / 2;
  UIButton *cancelButton = [CommonButton cancelButtonWithFrame:CGRectMake(BOTTOM_BUTTON_LEFT_MARGIN, 0, buttonWidth, BOTTOM_BUTTON_HEIGHT)
                                                          font:[UIFont systemFontOfSize:BOTTOM_BUTTON_FONT_SIZE]];
  [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  [UIConfiguration moveSubviewYToSuperviewCenter:bottomBackView subview:cancelButton];
  
  [bottomBackView addSubview:cancelButton];
  
  // confirm button
  CGFloat confirmX = CGRectGetMaxX(cancelButton.frame) + BOTTOM_BUTTON_INTERAL_MARGIN;
  UIButton *confirmButton = [CommonButton confirmButtonWithFrame:CGRectMake(confirmX, 0,  buttonWidth, BOTTOM_BUTTON_HEIGHT)
                                                            font:[UIFont systemFontOfSize:BOTTOM_BUTTON_FONT_SIZE]];
  [confirmButton setEnabled:NO];
  [confirmButton addTarget:self action:@selector(confirmButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  [UIConfiguration moveSubviewYToSuperviewCenter:bottomBackView subview:confirmButton];
  
  self.confirmButton = confirmButton;
  [bottomBackView addSubview:confirmButton];
}

- (void)confirmButtonPressed
{
  __weak typeof(self) weakSelf = self;
  [self dismissViewControllerAnimated:YES completion:^{
    if (weakSelf.chooseTableDelegate
        && [weakSelf.chooseTableDelegate respondsToSelector:@selector(confirmWithChooseTableSelectedArray:)]) {
      [weakSelf.chooseTableDelegate confirmWithChooseTableSelectedArray:weakSelf.selectedArray];
    }
  }];
}

- (void)cancelButtonPressed
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (self.type == kChooseTableTypeFriend) {
    return [self.friendsArray count];
  }
  else if (self.type == kChooseTableTypeTeam) {
    return [self.teamsArray count];
  }
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return CHOOSE_TABLE_CELL_HEIGHT;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellID = CHOOSE_TABLE_CELL_ID;
  ChooseTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
  if (!cell) {
    cell = [[ChooseTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
  }
  
  NSString *imageURL;
  NSString *name;
  if (self.type == kChooseTableTypeFriend) {
    SimpleGeekerInfo *info = self.friendsArray[indexPath.row];
    imageURL = info.avatarURL;
    name = info.name;
  }
  else if (self.type == kChooseTableTypeTeam) {
    SimpleTeamInfo *info = self.teamsArray[indexPath.row];
    imageURL = info.teamAvatarURL;
    name = info.teamName;
  }
  
  [cell configCellWithImageURL:imageURL name:name];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  
  NSMutableArray *object = self.selectedArray[indexPath.row];
  
  UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
  if (cell.accessoryType == UITableViewCellAccessoryCheckmark) {
    cell.accessoryType = UITableViewCellAccessoryNone;
    
    NSNumber *number = [NSNumber numberWithBool:NO];
    [object replaceObjectAtIndex:2 withObject:number];
  }
  else {
    cell.accessoryType = UITableViewCellAccessoryCheckmark;
    
    NSNumber *number = [NSNumber numberWithBool:YES];
    [object replaceObjectAtIndex:2 withObject:number];
  }
  
  if (self.type == kChooseTableTypeTeam) {
    if (self.previousIndexPath && self.previousIndexPath.row != indexPath.row) {
      UITableViewCell *cell = [tableView cellForRowAtIndexPath:self.previousIndexPath];
      [cell setAccessoryType:UITableViewCellAccessoryNone];
      
      NSMutableArray *previousObject = self.selectedArray[self.previousIndexPath.row];
      [previousObject replaceObjectAtIndex:2 withObject:[NSNumber numberWithBool:NO]];
    }
    self.previousIndexPath = indexPath;
  }
  
  [self updateConfirmButton];
}

- (void)updateConfirmButton
{
  for (NSMutableArray *object in self.selectedArray) {
    NSNumber *number = object[2];
    if (number.boolValue) {
      [self.confirmButton setEnabled:YES];
      return;
    }
  }
  [self.confirmButton setEnabled:NO];
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
