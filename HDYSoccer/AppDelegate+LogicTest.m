//
//  AppDelegate+LogicTest.m
//  HDYSoccer
//
//  Created by bigyelow on 6/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "AppDelegate+LogicTest.h"
#import "HDYSoccerAPIClient+HTTP.h"
#import "HDYSoccerAPIClient+HTTPS.h"
#import "AppContext.h"
#import "PersonalGameList.h"
#import "TeamGameList.h"
#import "PersonalGame.h"
#import "Geeker.h"

@implementation AppDelegate (LogicTest)

#pragma mark - user management
- (void)testRegister
{
  HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];
  
  NSString *email = @"duyu1010@163.com";
  NSString *psw = @"mdafasdfa";
  NSString *phone = @"12319012391";

  [client registerWithEmail:email
                      phone:phone
                   password:psw
                  succeeded:^(NSDictionary *dictionary) {
                    Authorization *auth = [Authorization objectWithDictionary:dictionary];
                    [[AppContext appContext] updateInfoWithAuth:auth];
                  } failed:^(HDYSoccerAPIError *error) {

                  }];
}

- (void)testLogin
{
  HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];
  
  NSString *userName = @"bigyelow";
  NSString *passwd = @"mmkdas;f";
  
  [client loginWithUserName:userName
                     passwd:passwd
                  succeeded:^(NSDictionary *dictionary) {
                    Authorization *auth = [Authorization objectWithDictionary:dictionary];
                    [[AppContext appContext] updateInfoWithAuth:auth];
                    
                  } failed:^(HDYSoccerAPIError *error) {

                  }];
}

- (void)testLogout
{
  [[AppContext appContext] clearInfo];
}

#pragma mark - game
- (void)testLoadGameList
{
  NSString *type = @"team";
  NSString *lat = [AppContext appContext].location.latitude;
  NSString *log = [AppContext appContext].location.longtitude;
#warning time, field need to formating
  NSString *time = @"dda";
  NSString *field = @"对外经贸大学";
  NSInteger start = 0;
  NSInteger count = 100;
  
  HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];
  
  [client getGameListWithType:type
                     latitude:lat
                   longtitude:log
                         time:time
                        field:field
                        start:start
                        count:count
                    succeeded:^(NSDictionary *dictionary) {
                      if ([type isEqualToString:@"personal"]) {
                        PersonalGameList *list = [PersonalGameList objectWithDictionary:dictionary];
                        NSLog(@"%zd", [list.gameList count]);
                      }
                      else if ([type isEqualToString:@"team"]) {
                        TeamGameList *list = [TeamGameList objectWithDictionary:dictionary];
                        NSLog(@"%zd", [list.gameList count]);
                      }
                    } failed:^(HDYSoccerAPIError *error) {

                    }];
}

- (void)testCreatePersonalGame
{
  NSString *time = @"2014-06-07 15:50";
  NSString *field = @"中央财经大学";
  NSInteger playerCount = 9;
  NSArray *players = @[@"1231", @"323213", @"34214"];
  NSString *contact = @"1520130542";
  NSString *remarks = @"请做好准备";
  NSString *cost = @"100";
  
  HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];
  [client createPersonalGameWithTime:time
                               field:field
                         playerCount:playerCount
                             players:players
                             contact:contact
                             remarks:remarks
                                cost:cost
                           succeeded:^(NSDictionary *dictionary) {
                             PersonalGame *personalGame = [PersonalGame objectWithDictionary:dictionary];
                             SimpleGeekerInfo *participant = personalGame.participants[0];
                             NSDate *time = personalGame.time;
                             NSLog(@"%@", participant.geekerID);
                             NSLog(@"%@", time);
                           } failed:^(HDYSoccerAPIError *error) {
                             
                           }];
}

- (void)testGetPersonalGame
{
  NSString *gameID = @"1000";
  
  HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];
  [client getPersonalGameWithID:gameID
                      succeeded:^(NSDictionary *dictionary) {
                        PersonalGame *personalGame = [PersonalGame objectWithDictionary:dictionary];
                        SimpleGeekerInfo *participant = personalGame.participants[0];
                        NSDate *time = personalGame.time;
                        NSLog(@"%@", participant.geekerID);
                        NSLog(@"%@", time);
                      } failed:^(HDYSoccerAPIError *error) {
                        
                      }];
}

- (void)testGetMyFriends
{
  HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];
  [client getMyFriendsSucceeded:^(NSArray *array) {
    SimpleGeekerInfo *info = array[0];
    NSLog(@"%@", info.name);
  } failed:^(HDYSoccerAPIError *error) {
    
  }];
}

- (void)testGetGeekerInfo
{
  HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];
  NSString *geekerID = @"1000";
  [client getGeekerInfoWithGeekerID:geekerID
                          succeeded:^(NSDictionary *dictionary) {
                            Geeker *geeker = [Geeker objectWithDictionary:dictionary];
                            NSLog(@"%@", geeker.name);
                          } failed:^(HDYSoccerAPIError *error) {
                            
                          }];
}

@end
