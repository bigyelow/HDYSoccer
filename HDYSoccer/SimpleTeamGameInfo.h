//
//  SimpleTeamGameInfo.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "BaseObject.h"

@interface SimpleTeamGameInfo : BaseObject

@property (nonatomic, copy, readonly) NSString *teamGameID;
@property (nonatomic, copy, readonly) NSString *teamName;
@property (nonatomic, copy, readonly) NSString *averageScore;
@property (nonatomic, copy, readonly) NSString *teamAvatarURL;
@property (nonatomic, copy, readonly) NSString *distance;
@property (nonatomic, copy, readonly) NSString *field;

@end
