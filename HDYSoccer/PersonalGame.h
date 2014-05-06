//
//  PersonalGame.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "JSONModel.h"
#import "SimpleGeekerInfo.h"

@interface PersonalGame : JSONModel

@property (nonatomic, copy, readonly) NSString *personalGameID;
@property (nonatomic, copy, readonly) NSString *time;
@property (nonatomic, copy, readonly) NSString *field;
@property (nonatomic, copy, readonly) NSString *numberOfPeople;
@property (nonatomic, copy, readonly) NSString *sponsor;
@property (nonatomic, copy, readonly) NSString *totalCost;
@property (nonatomic, copy, readonly) NSString *costPerPerson;
@property (nonatomic, copy, readonly) NSString *contact;
@property (nonatomic, copy, readonly) NSString *remark;
@property (nonatomic, copy, readonly) NSString *averageScore;
@property (nonatomic, strong, readonly) NSArray<SimpleGeekerInfo> *participants;

@end
