//
//  PersonalGame.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "BaseObject.h"
#import "SimpleGeekerInfo.h"

@interface PersonalGame : BaseObject

@property (nonatomic, copy, readonly) NSString *personalGameID;
@property (nonatomic, strong, readonly) NSDate *time;
@property (nonatomic, copy, readonly) NSString *field;
@property (nonatomic, assign, readonly) NSInteger playerCount;
@property (nonatomic, strong, readonly) SimpleGeekerInfo *sponsor;
@property (nonatomic, copy, readonly) NSString *totalCost;
@property (nonatomic, copy, readonly) NSString *costPerPerson;
@property (nonatomic, copy, readonly) NSString *contact;
@property (nonatomic, copy, readonly) NSString *remark;
@property (nonatomic, copy, readonly) NSString *averageScore;
@property (nonatomic, strong, readonly) NSArray *participants;
@property (nonatomic, copy, readonly) NSString *gameName;

@end
