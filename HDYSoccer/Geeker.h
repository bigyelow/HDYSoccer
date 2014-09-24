//
//  Geeker.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "BaseObject.h"
#import "SimpleGeekerInfo.h"
@class GeekerAbility;

@interface Geeker : BaseObject

@property (nonatomic, copy, readonly) NSString *geekerID;
@property (nonatomic, copy, readonly) NSString *avatarURL;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *score;
@property (nonatomic, strong) NSArray *position;
@property (nonatomic, copy) NSString *birthDate;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) GeekerStatus status;
@property (nonatomic, strong) GeekerAbility *ability;
@property (nonatomic, strong, readonly) NSArray *tagsArray;
@property (nonatomic, assign) CGFloat averageGameScore;
@property (nonatomic, assign) BOOL isFriend;
@end
