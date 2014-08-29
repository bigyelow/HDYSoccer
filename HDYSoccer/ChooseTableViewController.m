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
#define BOTTOM_BUTTON_HEIGHT 25
#define BOTTOM_BUTTON_LEFT_MARGIN 10
#define BOTTOM_BUTTON_INTERAL_MARGIN 7
#define BOTTOM_BUTTON_FONT_SIZE 15

@interface ChooseTableViewController ()

@end

@implementation ChooseTableViewController

- (id)initWithType:(ChooseTableType)type
{
  self = [super init];
  if (self) {
    self.type = type;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self configTableView];
  [self configBottomButtons];

  [self loadMyFriends];
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
  [confirmButton addTarget:self action:@selector(confirmButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  [UIConfiguration moveSubviewYToSuperviewCenter:bottomBackView subview:confirmButton];
  
  [bottomBackView addSubview:confirmButton];
}

- (void)confirmButtonPressed
{
  [self dismissViewControllerAnimated:YES completion:nil];
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
  return [self.friendsArray count];
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
    
  }
  
  [cell configCellWithImageURL:imageURL name:name];
  
  return cell;
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
