//
//  Geeker.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "JSONModel.h"

@interface Geeker : JSONModel

@property (nonatomic, copy, readonly) NSString *geekerID;
@property (nonatomic, copy, readonly) NSString *avatarURL;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *score;
@property (nonatomic, copy, readonly) NSString *position;
@property (nonatomic, copy, readonly) NSString *character;
@property (nonatomic, strong, readonly) NSArray *recentStatusScore;
@property (nonatomic, copy, readonly) NSString *status;

@end
