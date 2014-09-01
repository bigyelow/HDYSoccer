//
//  SimplePersonalGameInfo.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "BaseObject.h"

@interface SimplePersonalGameInfo : BaseObject

@property (nonatomic, copy, readonly) NSString *personalGameID;
@property (nonatomic, copy, readonly) NSString *avatarURL;
@property (nonatomic, copy, readonly) NSString *averageScore;
@property (nonatomic, copy, readonly) NSString *distance;
@property (nonatomic, copy, readonly) NSString *field;
@property (nonatomic, copy, readonly) NSString *participantsNumber;
@property (nonatomic, copy, readonly) NSString *totalNumberLimit;
@property (nonatomic, strong, readonly) NSDate *time;

@end
