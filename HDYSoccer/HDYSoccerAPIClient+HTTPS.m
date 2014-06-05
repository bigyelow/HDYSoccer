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

@implementation HDYSoccerAPIClient (HTTPS)

#pragma mark - user management operations
- (void)registerWithEmail:(NSString *)email
                    phone:(NSString *)phone
                 password:(NSString *)psw
                succeeded:(SucceededGettingJsonStringBlock)succeeded
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
                        succeeded(operation.responseString);
                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                        failed(hdyApiError);
                      }];
}

- (void)loginWithUserName:(NSString *)name
                   passwd:(NSString *)psw
                succeeded:(SucceededGettingJsonStringBlock)succeeded
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
                   parameters:path
                      success:^(AFHTTPRequestOperation *operation, id responseObject) {
                        succeeded(operation.responseString);
                      } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
                        HDYSoccerAPIError *hdyApiError = [HDYSoccerAPIError convertNSError:error];
                        failed(hdyApiError);
                      }];
}

#pragma mark - game

@end
