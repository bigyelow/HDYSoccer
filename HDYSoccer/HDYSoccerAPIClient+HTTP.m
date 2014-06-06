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
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  [parameter setObject:type forKey:@"type"];
  [parameter setObject:time forKey:@"time"];
  [parameter setObject:field forKey:@"field"];
  [parameter setObject:[NSNumber numberWithInteger:start] forKey:@"start"];
  [parameter setObject:[NSNumber numberWithInteger:count] forKey:@"count"];
  if (latitude) {
    [parameter setObject:latitude forKey:@"lat"];
  }
  if (longtitude) {
    [parameter setObject:longtitude forKey:@"log"];
  }
  
  NSString *path = [self pathWithSubpath:@"game/game_list"];
  
  [self.operationManager GET:path
                  parameters:parameter
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSDictionary *dic = responseObject;
                       NSArray *list = [dic objectForKey:@"game_list"];
                       NSMutableArray *tempArray = [NSMutableArray array];
                       for (NSDictionary *gameDic in list) {
                         SimplePersonalGameInfo *simpleGameInfo = [SimplePersonalGameInfo objectWithDictionary:gameDic];
                         [tempArray addObject:simpleGameInfo];
                       }
                       NSMutableDictionary *tempDic = [NSMutableDictionary dictionaryWithDictionary:dic];
                       [tempDic setObject:tempArray forKey:@"game_list"];
                       succeeded(tempDic);
                       
                  } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                    HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
#warning todo - implement failed method
                    failed(hdyApiError);
                  }];
}

- (void)getPersonalGameWithID:(NSString *)personalGameID
                    succeeded:(SucceededGettingDictionaryBlock)succeeded
                       failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
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
