//
//  TeamGameRecords.h
//  HDYSoccer
//
//  Created by bigyelow on 6/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "BaseObject.h"

@interface TeamGameRecords : BaseObject

@property (nonatomic, copy) NSString *homeTeamID;
@property (nonatomic, copy) NSString *homeTeamName;
@property (nonatomic, copy) NSString *guestTeamID;
@property (nonatomic, copy) NSString *guestTeamName;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, copy) NSString *score;
@end
