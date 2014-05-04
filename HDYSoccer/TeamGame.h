//
//  TeamGame.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "JSONModel.h"

@interface TeamGame : JSONModel

@property (nonatomic, copy, readonly) NSString *teamGameID;
@property (nonatomic, copy, readonly) NSString *time;
@property (nonatomic, copy, readonly) NSString *field;
@property (nonatomic, copy, readonly) NSString *numberOfPeople;
@property (nonatomic, copy, readonly) NSString *teamScore;
@property (nonatomic, copy, readonly) NSString *gameRecord;
@property (nonatomic, copy, readonly) NSString *totalCost;
@property (nonatomic, copy, readonly) NSString *contact;
@property (nonatomic, copy, readonly) NSString *remark;

@end
