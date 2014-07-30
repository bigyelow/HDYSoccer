//
//  CreateGameDetailViewController+UIConfiguration.m
//  HDYSoccer
//
//  Created by bigyelow on 6/16/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CreateGameDetailViewController+TopButtons.h"
#import "HDYSoccerAPIClient+HTTPS.h"
#import "PersonalGame.h"
#import "TeamGame.h"
#import "GameDetailViewController.h"
#import "HDYSoccerNavigationController.h"
#import "CreateGameViewController.h"
#import "ChoosePlayerCell.h"
#import "ContactCell.h"
#import "CostCell.h"
#import "RemarkCell.h"
#import "PSPDFAlertView.h"

@implementation CreateGameDetailViewController (TopButtons)

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

- (void)cancelItemPressed
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)confirmItemPressed
{
  [self updateParamsFromInput];
  [self checkParams];
}

- (void)updateParamsFromInput
{
  // test
  if (!self.gameField) {
    self.gameField = @"";
  }
  
  // test
  if (!self.players) {
    self.players = @[];
  }
  
  // test
  if (!self.teamID) {
    self.teamID = @"";
  }
  
  self.playerCount = self.playerCell.textField.text.integerValue;
  if (!self.playerCount) {
    self.playerCount = 0;
  }
  
  self.contact = self.contactCell.textField.text;
  
  self.cost = self.costCell.textField.text;
  if (!self.cost) {
    self.cost = @"0";
  }
  
  self.remarks = self.remarkCell.textView.text;
  if (!self.remarks) {
    self.remarks = @"";
  }
}

- (void)checkParams
{
  if (!self.gameTime) { // time
    PSPDFAlertView *alertView = [[PSPDFAlertView alloc] initWithTitle:ALERT_NO_TIME];
    [alertView setCancelButtonWithTitle:TEXT_I_SEE
                                  block:nil];
    
    [alertView show];
  }
  else if (!self.contact
           || ![Tools verifyPhoneNumberLength:self.contact]
           || ![Tools verifyPhoneNumberFormat:self.contact]) { // contact
    PSPDFAlertView *alertView = [[PSPDFAlertView alloc] initWithTitle:ALERT_PHONE_INVALID];
    [alertView setCancelButtonWithTitle:TEXT_I_SEE
                                  block:nil];
    
    [alertView show];
  }
  else {
    NSString *time = [Tools dateminuteToStr:self.gameTime preferUTC:NO];
    [self createGameWithTime:time
                       field:self.gameField
                 playerCount:self.playerCount
                     players:self.players
                      teamID:self.teamID
                     contact:self.contact
                     remarks:self.remarks
                        cost:self.cost];
  }
}

//  NSString *time = @"2014-06-07 15:50";
//  NSString *field = @"中央财经大学";
//  NSInteger playerCount = 9;
//  NSArray *players = @[@"1231", @"323213", @"34214"];
//  NSString *contact = @"1520130542";
//  NSString *remarks = @"请做好准备";
//  NSString *cost = @"100";
//  NSString *teamID = @"213089";

- (void)createGameWithTime:(NSString *)time
                     field:(NSString *)field
               playerCount:(NSInteger)playerCount
                   players:(NSArray *)players
                    teamID:(NSString *)teamID
                   contact:(NSString *)contact
                   remarks:(NSString *)remarks
                      cost:(NSString *)cost
{
  switch (self.gameType) {
    case kGameTypePersonal: {
      HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];
      __weak typeof(self) weakSelf = self;
      
      [UIConfiguration showTipMessageToView:self.view title:TEXT_CREATING];
      [client createPersonalGameWithTime:time
                                   field:field
                             playerCount:playerCount
                                 players:players
                                 contact:contact
                                 remarks:remarks
                                    cost:cost
                               succeeded:^(NSDictionary *dictionary) {
                                 [UIConfiguration hideTipMessageOnView:weakSelf.view];
                                 
                                 PersonalGame *personalGame = [PersonalGame objectWithDictionary:dictionary];
//                                 SimpleGeekerInfo *participant = personalGame.participants[0];
//                                 NSDate *time = personalGame.time;
//                                 NSLog(@"%@", participant.geekerID);
//                                 NSLog(@"%@", time);
                                 
                                 [weakSelf dismissViewControllerAnimated:YES completion:^{
                                   NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                                   [dic setObject:[NSNumber numberWithInteger:kGameTypePersonal] forKey:KEY_GAME_TYPE];
                                   [dic setObject:personalGame forKey:KEY_GAME_OBJECT];
                                   
                                   [weakSelf openGameDetailViewControllerWithObject:dic];
                                 }];
                               } failed:^(HDYSoccerAPIError *error) {
                                 [UIConfiguration hideTipMessageOnView:weakSelf.view];
                                 
                               }];
      break;
    }
      
    case kGameTypeTeam: {
      HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];
      __weak typeof(self) weakSelf = self;
      
      [UIConfiguration showTipMessageToView:self.view title:TEXT_CREATING];
      [client createTeamGameWithTime:time
                               field:field
                         playerCount:playerCount
                              teamID:teamID
                             contact:contact
                             remarks:remarks
                                cost:cost
                           succeeded:^(NSDictionary *dictionary) {
                             [UIConfiguration hideTipMessageOnView:weakSelf.view];

                             TeamGame *teamGame = [TeamGame objectWithDictionary:dictionary];
//                             TeamGameRecords *record = teamGame.gameRecords[0];
//                             NSLog(@"%@", record.time);
                             
                             [weakSelf dismissViewControllerAnimated:YES completion:^{
                               NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                               [dic setObject:[NSNumber numberWithInteger:kGameTypeTeam] forKey:KEY_GAME_TYPE];
                               [dic setObject:teamGame forKey:KEY_GAME_OBJECT];
                               
                               [weakSelf openGameDetailViewControllerWithObject:dic];
                             }];
                           } failed:^(HDYSoccerAPIError *error) {
                             [UIConfiguration hideTipMessageOnView:weakSelf.view];
                             
                           }];
      break;
    }
      
    default:
      break;
  }
}

- (void)openGameDetailViewControllerWithObject:(NSDictionary *)object
{
  if (self.createGameDelegate && [self.createGameDelegate respondsToSelector:@selector(createGameSucceeded:)]) {
    [self.createGameDelegate performSelector:@selector(createGameSucceeded:) withObject:object];
  }
}
@end
