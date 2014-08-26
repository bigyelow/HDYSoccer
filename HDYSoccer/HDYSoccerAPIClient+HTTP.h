//
//  HDYSoccerAPIClient+HTTP.h
//  HDYSoccer
//
//  Created by bigyelow on 5/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerAPIClient.h"

@interface HDYSoccerAPIClient (HTTP)

- (void)getGameListWithType:(NSString *)type
                   latitude:(NSString *)latitude
                 longtitude:(NSString *)longtitude
                       time:(NSString *)time
                      field:(NSString *)field
                      start:(NSInteger)start
                      count:(NSInteger)count
                  succeeded:(SucceededGettingDictionaryBlock)succeeded
                     failed:(FailedBlock)failed;
- (void)getPersonalGameWithID:(NSString *)personalGameID
                    succeeded:(SucceededGettingDictionaryBlock)succeeded
                       failed:(FailedBlock)failed;
- (void)getTeamGameWithID:(NSString *)teamGameID
                succeeded:(SucceededGettingDictionaryBlock)succeeded
                   failed:(FailedBlock)failed;
#pragma mark - COMMENT
- (void)getPersonalGameCommentsWithGameID:(NSString *)gameID
                                    start:(NSInteger)start
                                    count:(NSInteger)count
                                succeeded:(SucceededGettingArrayBlock)succeeded
                                   failed:(FailedBlock)failed;
- (void)getTeamGameCommentsWithGameID:(NSString *)gameID
                                start:(NSInteger)start
                                count:(NSInteger)count
                            succeeded:(SucceededGettingArrayBlock)succeeded
                               failed:(FailedBlock)failed;
#pragma mark - PLAYER AND TEMAS
- (void)getGeekerInfoWithGeekerID:(NSString *)geekerID
                        succeeded:(SucceededGettingDictionaryBlock)succeeded
                           failed:(FailedBlock)failed;
- (void)getTeamInfoWithTemaID:(NSString *)teamID
                    succeeded:(SucceededGettingDictionaryBlock)succeeded
                       failed:(FailedBlock)failed;

#pragma mark - Tags
- (void)getTagsSucceeded:(SucceededGettingArrayBlock)succeeded
                  failed:(FailedBlock)failed;
@end
