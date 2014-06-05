//
//  AppContext.h
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Location.h"
#import "Authorization.h"

@interface AppContext : NSObject

@property (nonatomic, strong) Authorization *auth;
@property (nonatomic, strong) Location *location;
@property (nonatomic, assign) BOOL isLogin;
@property (nonatomic, copy) NSString *appVersion;

- (void)synchronize;
- (void)updateInfoWithAuth:(Authorization *)auth;
- (void)clearInfo;
+ (AppContext *)appContext;
@end
