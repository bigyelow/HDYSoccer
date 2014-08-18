//
//  Team.m
//  HDYSoccer
//
//  Created by bigyelow on 8/18/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "Team.h"
#import "SimpleGeekerInfo.h"

@implementation Team

- (NSString *)teamID
{
  return [self.dictionary objectForKey:@"team_id"];
}

- (NSString *)teamName
{
  return [self.dictionary objectForKey:@"team_name"];
}

- (NSString *)teamAvatarURL
{
  return [self.dictionary objectForKey:@"team_avatar_url"];
}

- (NSString *)coach
{
  return [self.dictionary objectForKey:@"coach"];
}

- (NSString *)captain
{
  return [self.dictionary objectForKey:@"captain"];
}

- (TeamScore *)teamScore
{
  if (!_teamScore) {
    _teamScore = [TeamScore objectWithDictionary:[self.dictionary objectForKey:@"team_scores"]];
  }
  return _teamScore;
}

- (NSArray *)gameRecords
{
  if (!_gameRecords) {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in [self.dictionary objectForKey:@"game_records"]) {
      TeamGameRecords *record = [TeamGameRecords objectWithDictionary:dic];
      [array addObject:record];
    }
    
    _gameRecords = [array copy];
  }
  return _gameRecords;
}

- (NSArray *)members
{
  if (!_members) {
    NSMutableArray *array = [NSMutableArray array];
    for (NSDictionary *dic in [self.dictionary objectForKey:@"members"]) {
      SimpleGeekerInfo *player = [SimpleGeekerInfo objectWithDictionary:dic];
      [array addObject:player];
    }
    
    _members = [array copy];
  }
  return _members;
}
@end
