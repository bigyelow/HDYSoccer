//
//  TeamGame.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "BaseObject.h"
#import "TeamScore.h"
#import "TeamGameRecords.h"

@interface TeamGame : BaseObject

@property (nonatomic, copy, readonly) NSString *teamGameID;
@property (nonatomic, copy, readonly) NSString *teamID;
@property (nonatomic, copy, readonly) NSString *teamAvatarURL;
@property (nonatomic, strong, readonly) TeamScore *teamScore;
@property (nonatomic, strong) NSArray *gameRecords;
@property (nonatomic, strong, readonly) NSDate *time;
@property (nonatomic, copy, readonly) NSString *field;
@property (nonatomic, assign, readonly) NSInteger playerCount;
@property (nonatomic, copy, readonly) NSString *totalCost;
@property (nonatomic, copy, readonly) NSString *contact;
@property (nonatomic, copy, readonly) NSString *remark;
@property (nonatomic, copy, readonly) NSString *gameName;

@end
