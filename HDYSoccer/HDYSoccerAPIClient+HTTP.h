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
@end
