//
//  HDYSoccerAPIClient.h
//  HDYSoccer
//
//  Created by bigyelow on 5/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <Foundation/Foundation.h>
@class AFHTTPRequestOperation;
@class HDYSoccerAPIError;
@class AFHTTPRequestOperationManager;

typedef void (^SucceededGettingDictionaryBlock)(NSDictionary *dictionary);
typedef void (^SucceededGettingArrayBlock)(NSArray *array);
typedef void (^SucceededGettingJsonStringBlock)(NSString *jsonString);
typedef void (^FailedBlock)(HDYSoccerAPIError * error);

@interface HDYSoccerAPIClient : NSObject

+ (HDYSoccerAPIClient *)newHttpClient;
+ (HDYSoccerAPIClient *)newHttpsClient;

+ (NSDictionary *)defaultParameters;
- (id)initWithBaseURL:(NSString *)baseURL;
- (NSString *)pathWithSubpath:(NSString *)subpath;
- (AFHTTPRequestOperation *)jsonOperationWithURLSubpath:(NSString *)subpath;
- (AFHTTPRequestOperationManager *)operationManager;
@end
