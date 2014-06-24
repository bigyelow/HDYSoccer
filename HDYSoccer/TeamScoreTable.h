//
//  TeamScoreTable.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "BaseObject.h"
@class TeamScoreCollection;

@interface TeamScoreTable : BaseObject

@property (nonatomic, copy, readonly) NSString *results;
@property (nonatomic, strong, readonly) TeamScoreCollection *homeTeamScore;
@property (nonatomic, strong, readonly) TeamScoreCollection *visitTeamScore;

@end
