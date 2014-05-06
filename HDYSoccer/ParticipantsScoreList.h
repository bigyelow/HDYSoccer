//
//  ParticipantsScoreList.h
//  HDYSoccer
//
//  Created by bigyelow on 5/6/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "JSONModel.h"
#import "ParticipantsScore.h"

@interface ParticipantsScoreList : JSONModel

@property (nonatomic, strong, readonly) NSArray<ParticipantsScore> *participantsList;

@end
