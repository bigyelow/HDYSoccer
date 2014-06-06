//
//  PersonalGameList.m
//  HDYSoccer
//
//  Created by bigyelow on 5/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "PersonalGameList.h"

@implementation PersonalGameList

- (SimplePersonalGameInfo *)gameList
{
  return [self.dictionary objectForKey:@"game_list"];
}
@end
