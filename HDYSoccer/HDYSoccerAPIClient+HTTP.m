//
//  HDYSoccerAPIClient+HTTP.m
//  HDYSoccer
//
//  Created by bigyelow on 5/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerAPIClient+HTTP.h"
#import "AFNetworking.h"
#import "PersonalGameList.h"
#import "HDYSoccerAPIError.h"

@implementation HDYSoccerAPIClient (HTTP)

#pragma mark - Game
- (void)getGameListWithType:(NSString *)type
                   latitude:(NSString *)latitude
                 longtitude:(NSString *)longtitude
                       time:(NSString *)time
                      field:(NSString *)field
                      start:(NSInteger)start
                      count:(NSInteger)count
                  succeeded:(SucceededGettingDictionaryBlock)succeeded
                     failed:(FailedBlock)failed
{
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  [parameter setObject:type forKey:@"type"];
  [parameter setObject:latitude forKey:@"lat"];
  [parameter setObject:longtitude forKey:@"log"];
  [parameter setObject:time forKey:@"time"];
  [parameter setObject:field forKey:@"field"];
  [parameter setObject:[NSNumber numberWithInteger:start] forKey:@"start"];
  [parameter setObject:[NSNumber numberWithInteger:count] forKey:@"count"];
  
  NSString *path = [self pathWithSubpath:@"game/game_list"];
  [self.operationManager GET:path
                  parameters:parameter
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                    NSDictionary *resultDic = (NSDictionary *)responseObject;
                    succeeded(resultDic);
                  }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
#warning todo - implement failed method
                    failed(hdyApiError);
                  }];
}

- (void)getPersonalGameWithID:(NSString *)personalGameID
                    succeeded:(SucceededGettingDictionaryBlock)succeeded
                       failed:(FailedBlock)failed
{
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];

  NSString *subpath = [NSString stringWithFormat:@"game/personal/%@", personalGameID];
  NSString *path = [self pathWithSubpath:subpath];
  [self.operationManager GET:path
                  parameters:parameter
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSDictionary *resultDic = (NSDictionary *)responseObject;
                       succeeded(resultDic);
                     }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                       failed(hdyApiError);
                     }];
}

@end
