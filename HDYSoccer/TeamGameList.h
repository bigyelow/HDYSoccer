//
//  TeamGameList.h
//  HDYSoccer
//
//  Created by bigyelow on 5/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "JSONModel.h"
#import "SimpleTeamGameInfo.h"

@interface TeamGameList : JSONModel

@property (nonatomic, strong, readonly) NSArray<SimpleTeamGameInfo> *gamelist;
@end
