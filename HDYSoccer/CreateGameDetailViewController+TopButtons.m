//
//  CreateGameDetailViewController+UIConfiguration.m
//  HDYSoccer
//
//  Created by bigyelow on 6/16/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CreateGameDetailViewController+TopButtons.h"
#import "HDYSoccerAPIClient+HTTPS.h"
#import "MRProgress.h"
#import "PersonalGame.h"
#import "TeamGame.h"
#import "GameDetailViewController.h"
#import "HDYSoccerNavigationController.h"
#import "CreateGameViewController.h"

@implementation CreateGameDetailViewController (TopButtons)

- (void)configTopItems
{
  UIBarButtonItem *confirmItem = [[UIBarButtonItem alloc] initWithTitle:TEXT_OK
                                                                  style:UIBarButtonItemStyleBordered
                                                                 target:self
                                                                 action:@selector(confirmItemPressed)];
  
  [self.navigationItem setRightBarButtonItem:confirmItem];
}

- (void)confirmItemPressed
{
  NSString *time = @"2014-06-07 15:50";
  NSString *field = @"中央财经大学";
  NSInteger playerCount = 9;
  NSArray *players = @[@"1231", @"323213", @"34214"];
  NSString *contact = @"1520130542";
  NSString *remarks = @"请做好准备";
  NSString *cost = @"100";
  // team
  NSString *teamID = @"213089";
  
  switch (self.gameType) {
    case kGameTypePersonal: {
      HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];
      __weak typeof(self) weakSelf = self;
      
      [UIConfiguration showTipMessageToView:self.navigationController.view title:TEXT_CREATING];
      [client createPersonalGameWithTime:time
                                   field:field
                             playerCount:playerCount
                                 players:players
                                 contact:contact
                                 remarks:remarks
                                    cost:cost
                               succeeded:^(NSDictionary *dictionary) {
                                 [UIConfiguration hideTipMessageOnView:weakSelf.navigationController.view];
                                 
                                 PersonalGame *personalGame = [PersonalGame objectWithDictionary:dictionary];
                                 SimpleGeekerInfo *participant = personalGame.participants[0];
                                 NSDate *time = personalGame.time;
                                 NSLog(@"%@", participant.geekerID);
                                 NSLog(@"%@", time);
                                 
                                 [weakSelf dismissViewControllerAnimated:YES completion:^{
                                   NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                                   [dic setObject:[NSNumber numberWithInteger:kGameTypePersonal] forKey:KEY_GAME_TYPE];
                                   [dic setObject:personalGame forKey:KEY_GAME_OBJECT];
                                   
                                   [weakSelf openGameDetailViewControllerWithObject:dic];
                                 }];
                               } failed:^(HDYSoccerAPIError *error) {
                                 [UIConfiguration hideTipMessageOnView:weakSelf.navigationController.view];
                                 
                               }];
      break;
    }
      
    case kGameTypeTeam: {
      HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];
      __weak typeof(self) weakSelf = self;
      
      [UIConfiguration showTipMessageToView:self.navigationController.view title:TEXT_CREATING];
      [client createTeamGameWithTime:time
                               field:field
                         playerCount:playerCount
                              teamID:teamID
                             contact:contact
                             remarks:remarks
                                cost:cost
                           succeeded:^(NSDictionary *dictionary) {
                             [UIConfiguration hideTipMessageOnView:weakSelf.navigationController.view];

                             TeamGame *teamGame = [TeamGame objectWithDictionary:dictionary];
                             TeamGameRecords *record = teamGame.gameRecords[0];
                             NSLog(@"%@", record.time);
                             
                             [weakSelf dismissViewControllerAnimated:YES completion:^{
                               NSMutableDictionary *dic = [NSMutableDictionary dictionary];
                               [dic setObject:[NSNumber numberWithInteger:kGameTypeTeam] forKey:KEY_GAME_TYPE];
                               [dic setObject:teamGame forKey:KEY_GAME_OBJECT];
                               
                               [weakSelf openGameDetailViewControllerWithObject:dic];
                             }];
                           } failed:^(HDYSoccerAPIError *error) {
                             [UIConfiguration hideTipMessageOnView:weakSelf.navigationController.view];
                             
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
