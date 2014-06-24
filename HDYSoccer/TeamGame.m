//
//  TeamGame.m
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "TeamGame.h"
#import "TeamScore.h"
#import "TeamGameRecords.h"

@implementation TeamGame
@synthesize time = _time;
@synthesize teamScore = _teamScore;
@synthesize gameRecords = _gameRecords;

- (NSString *)teamGameID
{
  return [self.dictionary objectForKey:@"team_game_id"];
}

- (NSString *)teamID
{
  return [self.dictionary objectForKey:@"team_id"];
}

- (NSString *)teamAvatarURL
{
  return [self.dictionary objectForKey:@"team_avatar_url"];
}

- (TeamScore *)teamScore
{
  if (!_teamScore) {
    NSDictionary *object = [self.dictionary objectForKey:@"team_score"];
    _teamScore = [TeamScore objectWithDictionary:object];
  }
  return _teamScore;
}

- (NSArray *)gameRecords
{
  if (!_gameRecords) {
    NSArray *object = [self.dictionary objectForKey:@"game_records"];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dic in object) {
      TeamGameRecords *gameRecords = [TeamGameRecords objectWithDictionary:dic];
      [tempArray addObject:gameRecords];
    }
    _gameRecords = [NSArray arrayWithArray:tempArray];
  }
  return _gameRecords;}

- (NSDate *)time
{
  if (!_time) {
    NSString *timeStr = [self.dictionary objectForKey:@"time"];
    _time = [Tools strToDate:timeStr preferUTC:NO];
  }
  return _time;
}

- (NSString *)field
{
  return [self.dictionary objectForKey:@"field"];
}

- (NSInteger)playerCount
{
  NSNumber *tempCount = [self.dictionary objectForKey:@"player_count"];
  return tempCount.integerValue;
}

- (NSString *)totalCost
{
  return [self.dictionary objectForKey:@"total_cost"];
}

- (NSString *)contact
{
  return [self.dictionary objectForKey:@"contact"];
}

- (NSString *)remark
{
  return [self.dictionary objectForKey:@"remark"];
}
@end
