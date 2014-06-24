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
@end
