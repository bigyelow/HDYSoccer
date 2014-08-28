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
- (void)ratePlayerInPersonalGameWithPlayerID:(NSString *)playerID
                                   thisScore:(NSString *)thisScore
                                    thisTags:(NSString *)thisTags
                                    hasScore:(BOOL)hasScore
                                   succeeded:(SucceededGettingArrayBlock)succeeded
                                      failed:(FailedBlock)failed;
#pragma mark - geeker
- (void)getMyFriendsSucceeded:(SucceededGettingArrayBlock)succeeded
                       failed:(FailedBlock)failed;

#pragma mark - team
- (void)getMyTeamsSucceeded:(SucceededGettingArrayBlock)succeeded
                     failed:(FailedBlock)failed;
#pragma mark - comment
- (void)sendCommentToPersonalGame:(NSString *)gameID
                          Content:(NSString *)content
                        succeeded:(SucceededGettingDictionaryBlock)succeeded
                           failed:(FailedBlock)failed;
- (void)sendCommentToTeamGame:(NSString *)gameID
                      Content:(NSString *)content
                    succeeded:(SucceededGettingDictionaryBlock)succeeded
                       failed:(FailedBlock)failed;
- (void)sendReplyToPersonalGame:(NSString *)gameID
                      commentID:(NSString *)commentID
                        content:(NSString *)content
                      succeeded:(SucceededGettingDictionaryBlock)succeeded
                         failed:(FailedBlock)failed;

- (void)sendReplyToTeamGame:(NSString *)gameID
                  commentID:(NSString *)commentID
                    content:(NSString *)content
                  succeeded:(SucceededGettingDictionaryBlock)succeeded
                     failed:(FailedBlock)failed;
@end
