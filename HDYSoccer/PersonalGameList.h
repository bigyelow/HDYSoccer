//
//  PersonalGameList.h
//  HDYSoccer
//
//  Created by bigyelow on 5/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "JSONModel.h"
#import "SimplePersonalGameInfo.h"

@interface PersonalGameList : JSONModel

@property (nonatomic, strong, readonly) NSArray<SimplePersonalGameInfo> *gamelist;
@end
