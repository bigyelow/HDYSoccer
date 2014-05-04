//
//  TeamScore.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "JSONModel.h"
#import "SimpleGeekerInfo.h"

@interface TeamScore : JSONModel

@property (nonatomic, copy, readonly) NSString *teamScore;
@property (nonatomic, strong, readonly) SimpleGeekerInfo *simpleGeekerInfo;

@end
