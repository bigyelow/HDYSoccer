//
//  HDYSoccerAPIClient.m
//  HDYSoccer
//
//  Created by bigyelow on 5/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerAPIClient.h"
#import "HDYSoccerAPIClientParams.h"
#import "AppContextParams.h"
#import "AppContext.h"
#import "AFNetworking.h"

@implementation HDYSoccerAPIClient
{
  NSString *_baseURL;
  
  // header
  NSString *_headerAccept;
  NSString *_headerUserAgent;
  NSString *_headerAuthorization;
  
  AFHTTPRequestOperationManager *_operationManager;
}

+ (HDYSoccerAPIClient *)newHttpClient
{
  HDYSoccerAPIClient *client = [[HDYSoccerAPIClient alloc] initWithBaseURL:API_HTTP_BASE_URL];
  
  return client;
}

+ (HDYSoccerAPIClient *)newHttpsClient
{
  HDYSoccerAPIClient *client = [[HDYSoccerAPIClient alloc] initWithBaseURL:API_HTTPS_BASE_URL];
  
  return client;
}

- (id)initWithBaseURL:(NSString *)baseURL
{
  self = [super init];
  if (self) {
    _baseURL = baseURL;
    _headerAccept = @"application/json";
  }
  
  return self;
}

- (AFHTTPRequestOperationManager *)operationManager
{
  if (!_operationManager) {
    _operationManager  = [[AFHTTPRequestOperationManager alloc] init];
    [_operationManager.requestSerializer setValue:_headerAccept forHTTPHeaderField:@"Accept"];
    [_operationManager.requestSerializer setValue:[self headerUserAgent] forHTTPHeaderField:@"UserAgent"];
  }
  
#warning only set YES when debuging, should change it to NO later
  [self updateOperationManagerAuth:YES];
  
  return _operationManager;
}

- (void)updateOperationManagerAuth:(BOOL)allowInvalidCert
{
  if ([_baseURL hasPrefix:@"https"]) {
    [_operationManager.requestSerializer setValue:[AppContext appContext].auth.accessToken forHTTPHeaderField:@"Authorization"];
    
    AFSecurityPolicy *policy = [[AFSecurityPolicy alloc] init];
    [policy setAllowInvalidCertificates:allowInvalidCert];
    _operationManager.securityPolicy = policy;
  }
}

- (NSString *)headerUserAgent
{
  if (!_headerUserAgent) {
    _headerUserAgent = [[self class] clientParameter];
  }
  
  return _headerUserAgent;
}

+ (NSString *)clientParameter
{
  static NSString * param = nil;
  static dispatch_once_t onceToken = 0;
  dispatch_once(&onceToken, ^{
    NSString *clientParameter = nil;
    UIDevice *device = [UIDevice currentDevice];
    NSMutableArray *params = [NSMutableArray array];
    
    NSString *s = nil;
    // system info
    s = [NSString stringWithFormat:@"system_info:%@_%@", [device systemName], [device systemVersion]];
    [params addObject:s];
    
    // version
    s = [NSString stringWithFormat:@"version_string:%@", [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"]];
    [params addObject:s];
    
    clientParameter = [[params componentsJoinedByString:@"|"] copy];
    param = clientParameter;
  });
  
  return param;
}

+ (NSDictionary *)defaultParameters
{
  static NSMutableDictionary *parameters = nil;
  if (parameters == nil) {
    parameters = [[NSMutableDictionary alloc] initWithCapacity:3];
    [parameters setObject:APP_NAME forKey:@"app_name"];
    [parameters setObject:API_KEY forKey:@"api_key"];
    [parameters setObject:@"json" forKey:@"alt"];
  }
  
  return parameters;
}

- (AFHTTPRequestOperation *)jsonOperationWithURLSubpath:(NSString *)subpath
{
  NSString *string = [self pathWithSubpath:subpath];
  NSURL *url = [NSURL URLWithString:string];
  NSURLRequest *request = [NSURLRequest requestWithURL:url];
  
  AFHTTPRequestOperation *operation = [[AFHTTPRequestOperation alloc] initWithRequest:request];
  operation.responseSerializer = [AFJSONResponseSerializer serializer];
  
  return operation;
}

- (NSString *)pathWithSubpath:(NSString *)subpath
{
  return [NSString  stringWithFormat:@"%@%@", _baseURL, subpath];
}
@end
