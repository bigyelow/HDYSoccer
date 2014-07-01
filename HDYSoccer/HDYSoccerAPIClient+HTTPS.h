//
//  HDYSoccerAPIClient+HTTPS.h
//  HDYSoccer
//
//  Created by bigyelow on 6/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerAPIClient.h"

@interface HDYSoccerAPIClient (HTTPS)

#pragma mark - user management operations
- (void)registerWithEmail:(NSString *)email
                    phone:(NSString *)phone
                 password:(NSString *)psw
                succeeded:(SucceededGettingDictionaryBlock)succeeded
                   failed:(FailedBlock)failed;
- (void)loginWithUserName:(NSString *)name
                   passwd:(NSString *)psw
                succeeded:(SucceededGettingDictionaryBlock)succeeded
                   failed:(FailedBlock)failed;

#pragma mark - game
- (void)createPersonalGameWithTime:(NSString *)time
                             field:(NSString *)field
                       playerCount:(NSInteger)playerCount
                           players:(NSArray *)players
                           contact:(NSString *)contact
                           remarks:(NSString *)remarks
                              cost:(NSString *)cost
                         succeeded:(SucceededGettingDictionaryBlock)succeeded
                            failed:(FailedBlock)failed;
- (void)createTeamGameWithTime:(NSString *)time
                         field:(NSString *)field
                   playerCount:(NSInteger)playerCount
                        teamID:(NSString *)teamID
                       contact:(NSString *)contact
                       remarks:(NSString *)remarks
                          cost:(NSString *)cost
                     succeeded:(SucceededGettingDictionaryBlock)succeeded
                        failed:(FailedBlock)failed;
#pragma mark - geeker
- (void)getMyFriendsSucceeded:(SucceededGettingArrayBlock)succeeded
                       failed:(FailedBlock)failed;
@end
