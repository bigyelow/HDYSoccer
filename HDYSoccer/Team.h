//
//  Team.h
//  HDYSoccer
//
//  Created by bigyelow on 8/18/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "BaseObject.h"
#import "TeamScore.h"
#import "TeamGameRecords.h"

@interface Team : BaseObject

@property (nonatomic, copy) NSString *teamID;
@property (nonatomic, copy) NSString *teamName;
@property (nonatomic, copy) NSString *teamAvatarURL;
@property (nonatomic, copy) NSString *coach;
@property (nonatomic, copy) NSString *captain;
@property (nonatomic, strong) TeamScore *teamScore;
@property (nonatomic, strong) NSArray *gameRecords;
@property (nonatomic, strong) NSArray *members;

@end
