//
//  HDYSoccerAPIClient+HTTPS.m
//  HDYSoccer
//
//  Created by bigyelow on 6/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerAPIClient+HTTPS.h"
#import "AFNetworking.h"
#import "HDYSoccerAPIError.h"
#import "PersonalGame.h"
#import "TeamGame.h"
#import "SimpleGeekerInfo.h"
#import "ParticipantsScore.h"
#import "SimpleTeamInfo.h"
#import "GeekerAbility.h"

@implementation HDYSoccerAPIClient (HTTPS)

#pragma mark - user management operations
- (void)registerWithEmail:(NSString *)email
                    phone:(NSString *)phone
                 password:(NSString *)psw
                succeeded:(SucceededGettingDictionaryBlock)succeeded
                   failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  [parameter setObject:email forKey:@"email"];
  [parameter setObject:phone forKey:@"telephone"];
  [parameter setObject:psw forKey:@"passwd"];
  
  NSString *path = [self pathWithSubpath:@"user/register"];
  [self.operationManager POST:path
                   parameters:parameter
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSDictionary *resultDic = responseObject;
                        succeeded(resultDic);
                        
                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                        failed(hdyApiError);
                      }];
}

- (void)loginWithUserName:(NSString *)name
                   passwd:(NSString *)psw
                succeeded:(SucceededGettingDictionaryBlock)succeeded
                   failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  [parameter setObject:name forKey:@"user"];
  [parameter setObject:psw forKey:@"passwd"];
  
  NSString *path = [self pathWithSubpath:@"user/login"];
  [self.operationManager POST:path
                   parameters:parameter
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSDictionary *resultDic = responseObject;
                        succeeded(resultDic);
                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                        failed(hdyApiError);
                      }];
}

#pragma mark - game
- (void)createPersonalGameWithTime:(NSString *)time
                             field:(NSString *)field
                       playerCount:(NSInteger)playerCount
                           players:(NSArray *)players
                           contact:(NSString *)contact
                           remarks:(NSString *)remarks
                              cost:(NSString *)cost
                         succeeded:(SucceededGettingDictionaryBlock)succeeded
                            failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  
  [parameter setObject:time forKey:@"time"];
  [parameter setObject:field forKey:@"field"];
  [parameter setObject:[NSNumber numberWithInteger:playerCount] forKey:@"player_count"];
  [parameter setObject:players forKey:@"players"];
  [parameter setObject:contact forKey:@"contact"];
  [parameter setObject:remarks forKey:@"remarks"];
  [parameter setObject:cost forKey:@"cost"];
  
  NSString *path = [self pathWithSubpath:@"game/create_game/person"];
  [self.operationManager POST:path
                   parameters:parameter
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSDictionary *resultDic = responseObject;
                        succeeded(resultDic);
                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                        failed(hdyApiError);
                      }];
}

- (void)createTeamGameWithTime:(NSString *)time
                         field:(NSString *)field
                   playerCount:(NSInteger)playerCount
                        teamID:(NSString *)teamID
                       contact:(NSString *)contact
                       remarks:(NSString *)remarks
                          cost:(NSString *)cost
                     succeeded:(SucceededGettingDictionaryBlock)succeeded
                        failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  [parameter setObject:time forKey:@"time"];
  [parameter setObject:field forKey:@"field"];
  [parameter setObject:[NSNumber numberWithInteger:playerCount] forKey:@"player_count"];
  [parameter setObject:teamID forKey:@"team_id"];
  [parameter setObject:contact forKey:@"contact"];
  [parameter setObject:remarks forKey:@"remarks"];
  [parameter setObject:cost forKey:@"cost"];
  
  NSString *path = [self pathWithSubpath:@"game/create_game/team"];
  [self.operationManager POST:path
                   parameters:parameter
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSDictionary *resultDic = responseObject;
                        succeeded(resultDic);
                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                        failed(hdyApiError);
                      }];
}

- (void)ratePlayerInPersonalGameWithPlayerID:(NSString *)playerID
                                   thisScore:(NSString *)thisScore
                                    thisTags:(NSString *)thisTags
                                    hasScore:(BOOL)hasScore
                                   succeeded:(SucceededGettingArrayBlock)succeeded
                                      failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  [parameter setObject:playerID forKey:@"geeker_id"];
  [parameter setObject:thisScore forKey:@"this_score"];
  [parameter setObject:thisTags forKey:@"this_tags"];
  [parameter setObject:[NSNumber numberWithBool:hasScore] forKey:@"has_score"];
  
  NSString *path = [self pathWithSubpath:@"game/personal/rate"];
  [self.operationManager POST:path
                   parameters:path
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSArray *array = [responseObject copy];
                        NSMutableArray *tempArray = [NSMutableArray array];
                        
                        for (NSDictionary *dic in array) {
                          ParticipantsScore *score = [[ParticipantsScore alloc] initWithDictionary:dic];
                          [tempArray addObject:score];
                        }
                        
                        succeeded(tempArray);
                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                        failed(hdyApiError);
                      }];
}

#pragma mark - geeker
- (void)getMyFriendsSucceeded:(SucceededGettingArrayBlock)succeeded
                       failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  
  NSString *path = [self pathWithSubpath:@"geeker/geeker_list"];
  [self.operationManager GET:path
                  parameters:parameter
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSArray *resultArray = responseObject;
                       NSMutableArray *tempArray = [NSMutableArray array];
                       for (NSDictionary *dic in resultArray) {
                         SimpleGeekerInfo *geekerInfo = [SimpleGeekerInfo objectWithDictionary:dic];
                         [tempArray addObject:geekerInfo];
                       }
                       succeeded(tempArray);
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                       failed(hdyApiError);
                     }];
}

#pragma mark - team
- (void)getMyTeamsSucceeded:(SucceededGettingArrayBlock)succeeded
                     failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  
  NSString *path = [self pathWithSubpath:@"team/team_list"];
  [self.operationManager GET:path
                  parameters:parameter
                     success:^(AFHTTPRequestOperation *operation, id responseObject) {
                       NSArray *resultArray = responseObject;
                       NSMutableArray *tempArray = [NSMutableArray array];
                       for (NSDictionary *dic in resultArray) {
                         SimpleTeamInfo *teamInfo = [SimpleTeamInfo objectWithDictionary:dic];
                         [tempArray addObject:teamInfo];
                       }
                       succeeded(tempArray);
                     } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                       HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                       failed(hdyApiError);
                     }];
}

#pragma mark - comment
- (void)sendCommentToPersonalGame:(NSString *)gameID
                          Content:(NSString *)content
                        succeeded:(SucceededGettingDictionaryBlock)succeeded
                           failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  [parameter setObject:content forKey:@"content"];
  
  NSString *pathStr = [NSString stringWithFormat:@"game/personal/%@/comment", gameID];
  NSString *path = [self pathWithSubpath:pathStr];
  [self.operationManager POST:path
                   parameters:parameter
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSDictionary *resultDic = responseObject;
                        succeeded(resultDic);
                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                        failed(hdyApiError);
                      }];
}

- (void)sendCommentToTeamGame:(NSString *)gameID
                      Content:(NSString *)content
                    succeeded:(SucceededGettingDictionaryBlock)succeeded
                       failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  [parameter setObject:content forKey:@"content"];
  
  NSString *pathStr = [NSString stringWithFormat:@"game/team/%@/comment", gameID];
  NSString *path = [self pathWithSubpath:pathStr];
  [self.operationManager POST:path
                   parameters:parameter
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSDictionary *resultDic = responseObject;
                        succeeded(resultDic);
                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                        failed(hdyApiError);
                      }];
}

- (void)sendReplyToPersonalGame:(NSString *)gameID
                      commentID:(NSString *)commentID
                        content:(NSString *)content
                      succeeded:(SucceededGettingDictionaryBlock)succeeded
                         failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  [parameter setObject:content forKey:@"content"];
  
  NSString *pathStr = [NSString stringWithFormat:@"game/personal/%@/comment/%@/reply", gameID, commentID];
  NSString *path = [self pathWithSubpath:pathStr];
  [self.operationManager POST:path
                   parameters:parameter
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSDictionary *resultDic = responseObject;
                        succeeded(resultDic);
                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                        failed(hdyApiError);
                      }];
}

- (void)sendReplyToTeamGame:(NSString *)gameID
                  commentID:(NSString *)commentID
                    content:(NSString *)content
                  succeeded:(SucceededGettingDictionaryBlock)succeeded
                     failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  [parameter setObject:content forKey:@"content"];
  
  NSString *pathStr = [NSString stringWithFormat:@"game/team/%@/comment/%@/reply", gameID, commentID];
  NSString *path = [self pathWithSubpath:pathStr];
  [self.operationManager POST:path
                   parameters:parameter
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSDictionary *resultDic = responseObject;
                        succeeded(resultDic);
                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                        failed(hdyApiError);
                      }];
}

#pragma mark - rate

- (void)ratePlayerAbilityWithPlayerID:(NSString *)playerID
                          abilityType:(PlayerAbility)abilityType
                                score:(NSInteger)score
                            succeeded:(SucceededGettingDictionaryBlock)succeeded
                               failed:(FailedBlock)failed
{
  NSParameterAssert(succeeded != NULL);
  NSParameterAssert(failed != NULL);
  
  NSMutableDictionary *parameter = [NSMutableDictionary dictionaryWithDictionary:
                                    [HDYSoccerAPIClient defaultParameters]];
  [parameter setObject:[GeekerAbility abilityStringFromAbility:abilityType] forKey:@"ability_name"];
  [parameter setObject:[NSNumber numberWithInteger:score] forKey:@"score"];
  
  NSString *pathStr = [NSString stringWithFormat:@"rate/geeker/%@", playerID];
  NSString *path = [self pathWithSubpath:pathStr];
  
  [self.operationManager POST:path
                   parameters:parameter
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        NSDictionary *resultDic = responseObject;
                        succeeded(resultDic);
                      }
                      failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                        failed(hdyApiError);
                      }];
}

@end
