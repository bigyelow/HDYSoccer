//
//  Authorization.h
//  HDYSoccer
//
//  Created by bigyelow on 5/7/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Authorization : JSONModel

@property (nonatomic, copy) NSString *accessToken;
@property (nonatomic, copy) NSString *refreshToken;
@property (nonatomic, copy) NSString *expireIn;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *userName;

@end
