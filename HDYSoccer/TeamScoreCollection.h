//
//  TeamScore.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "BaseObject.h"
#import "SimpleGeekerInfo.h"

@interface TeamScoreCollection : BaseObject

@property (nonatomic, copy, readonly) NSString *teamScore;
@property (nonatomic, strong, readonly) NSArray *geekerList;

@end
