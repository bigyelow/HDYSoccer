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
#import "SimpleTeamGameInfo.h"
#import "HDYSoccerAPIError.h"
#import "Team.h"
#import "Comment.h"

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
  
  NSString *subPath = [NSString stringWithFormat:@"game/game_list/%@", type];
  NSString *path = [self pathWithSubpath:subPath];
  
  [self.operationManager GET:path
                  parameters:parameter
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSDictionary *dic = responseObject;
                       NSArray *list = [dic objectForKey:@"game_list"];
                       NSMutableArray *tempArray = [NSMutableArray array];
                       for (NSDictionary *gameDic in list) {
                         if ([type isEqualToString:@"personal"]) {
                           SimplePersonalGameInfo *simpleGameInfo = [SimplePersonalGameInfo objectWithDictionary:gameDic];
                           [tempArray addObject:simpleGameInfo];
                         }
                         else if ([type isEqualToString:@"team"]) {
                           SimpleTeamGameInfo *simpleGameInfo = [SimpleTeamGameInfo objectWithDictionary:gameDic];
                           [tempArray addObject:simpleGameInfo];
                         }
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

- (void)getTeamGameWithID:(NSString *)teamGameID
                succeeded:(SucceededGettingDictionaryBlock)succeeded
                   failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  
  NSString *subpath = [NSString stringWithFormat:@"game/team/%@", teamGameID];
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

#pragma mark - COMMENT
- (void)getPersonalGameCommentsWithGameID:(NSString *)gameID
                                    start:(NSInteger)start
                                    count:(NSInteger)count
                                succeeded:(SucceededGettingArrayBlock)succeeded
                                   failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  
  NSString *subpath = [NSString stringWithFormat:@"game/personal/%@/comments", gameID];
  NSString *path = [self pathWithSubpath:subpath];
  
  [self.operationManager GET:path
                  parameters:parameter
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSArray *resultArray = (NSArray *)responseObject;
                       NSMutableArray *temp = [NSMutableArray array];
                       
                       for (NSDictionary *dic in resultArray) {
                         Comment *comment = [Comment objectWithDictionary:dic];
                         [temp addObject:comment];
                       }
                       
                       succeeded(temp);
                     }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                       failed(hdyApiError);
                     }];
}

- (void)getTeamGameCommentsWithGameID:(NSString *)gameID
                                start:(NSInteger)start
                                count:(NSInteger)count
                            succeeded:(SucceededGettingArrayBlock)succeeded
                               failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  
  NSString *subpath = [NSString stringWithFormat:@"game/team/%@/comments", gameID];
  NSString *path = [self pathWithSubpath:subpath];
  
  [self.operationManager GET:path
                  parameters:parameter
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSArray *resultArray = (NSArray *)responseObject;
                       succeeded(resultArray);
                     }
                     failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                       failed(hdyApiError);
                     }];
}

#pragma mark - PLAYER AND TEMAS
- (void)getGeekerInfoWithGeekerID:(NSString *)geekerID
                        succeeded:(SucceededGettingDictionaryBlock)succeeded
                           failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  
  NSString *subpath = [NSString stringWithFormat:@"geeker/%@", geekerID];
  NSString *path = [self pathWithSubpath:subpath];
  
  [self.operationManager GET:path
                  parameters:parameter
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSDictionary *resultDic = responseObject;
                       succeeded(resultDic);
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                       failed(hdyApiError);
                     }];
}

- (void)getTeamInfoWithTemaID:(NSString *)teamID
                    succeeded:(SucceededGettingDictionaryBlock)succeeded
                       failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  
  NSString *subpath = [NSString stringWithFormat:@"team/%@", teamID];
  NSString *path = [self pathWithSubpath:subpath];
  
  [self.operationManager GET:path
                  parameters:parameter
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSDictionary *resultDic = responseObject;
                       succeeded(resultDic);
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                       failed(hdyApiError);
                     }];
}

#pragma mark - Tags
- (void)getTagsSucceeded:(SucceededGettingArrayBlock)succeeded
                  failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSString *subpath = [NSString stringWithFormat:@"tags/total_tags"];
  NSString *path = [self pathWithSubpath:subpath];
  
  [self.operationManager GET:path
                  parameters:nil
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSArray *array = responseObject;
                       succeeded(array);
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                       failed(hdyApiError);
                     }];
}
@end
