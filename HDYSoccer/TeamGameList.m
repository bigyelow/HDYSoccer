//
//  TeamGameList.m
//  HDYSoccer
//
//  Created by bigyelow on 5/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "TeamGameList.h"

@implementation TeamGameList

- (NSArray *)gameList
{
  return [self.dictionary objectForKey:@"game_list"];
}
@end
