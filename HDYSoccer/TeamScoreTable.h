//
//  TeamScoreTable.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "JSONModel.h"
#import "TeamScore.h"

@interface TeamScoreTable : JSONModel

@property (nonatomic, copy, readonly) NSString *results;
@property (nonatomic, strong, readonly) TeamScore *homeTeamScore;
@property (nonatomic, strong, readonly) TeamScore *visitTeamScore;

@end
