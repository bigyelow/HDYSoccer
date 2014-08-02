//
//  ParticipantsScore.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "BaseObject.h"

@class GeekerAbility;

@interface ParticipantsScore : BaseObject

@property (nonatomic, copy, readonly) NSString *geekerID;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy) NSString *avatarURL;
@property (nonatomic, assign) NSInteger thisRank;
@property (nonatomic, assign) CGFloat thisScore;
@property (nonatomic, assign) NSInteger thisTagsCount;
@property (nonatomic, strong) NSArray *thisTags;
@property (nonatomic, assign) BOOL canRate;
@end
