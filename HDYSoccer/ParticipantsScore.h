//
//  ParticipantsScore.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "JSONModel.h"
@class GeekerAbility;

@protocol ParticipantsScore


@end

@interface ParticipantsScore : JSONModel

@property (nonatomic, copy, readonly) NSString *geekerID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *todayStatus;
@property (nonatomic, strong, readonly) GeekerAbility *geekerAbility;

@end
