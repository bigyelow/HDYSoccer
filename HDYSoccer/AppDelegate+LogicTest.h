//
//  AppDelegate+LogicTest.h
//  HDYSoccer
//
//  Created by bigyelow on 6/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate (LogicTest)

// user management
- (void)testRegister;
- (void)testLogin;
- (void)testLogout;

// game
- (void)testLoadGameList;
- (void)testCreatePersonalGame;
- (void)testGetPersonalGame;

// geeker
- (void)testGetMyFriends;
- (void)testGetGeekerInfo;
@end
