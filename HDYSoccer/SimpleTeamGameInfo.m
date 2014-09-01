//
//  SimpleTeamGameInfo.m
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "SimpleTeamGameInfo.h"
#import "SimpleTeamInfo.h"

@implementation SimpleTeamGameInfo

@synthesize time = _time;

- (NSDate *)time
{
  if (!_time) {
    NSString *timeStr = [self.dictionary objectForKey:@"time"];
    _time = [Tools strToDate:timeStr preferUTC:NO];
  }
  return _time;
}

- (NSString *)teamGameID
{
  return [self.dictionary objectForKey:@"team_game_id"];
}

- (NSString *)teamName
{
  return [self.dictionary objectForKey:@"team_name"];
}

- (NSString *)averageScore
{
  return [self.dictionary objectForKey:@"average_score"];
}

- (NSString *)teamAvatarURL
{
  return [self.dictionary objectForKey:@"team_avatar_url"];
}

- (NSString *)distance
{
  return [self.dictionary objectForKey:@"distance"];
}

- (NSString *)field
{
  return [self.dictionary objectForKey:@"field"];
}

- (NSArray *)recentRecords
{
  return [self.dictionary objectForKey:@"recent_record"];
}

+ (NSInteger)winCountOfRecord:(NSArray *)record
{
  NSInteger count = 0;
  for (NSNumber *result in record) {
    switch (result.integerValue) {
      case GameResultWin:
        count++;
        break;
        
      default:
        break;
    }
  }
  return count;
}

+ (NSInteger)drawCountOfRecord:(NSArray *)record
{
  NSInteger count = 0;
  for (NSNumber *result in record) {
    switch (result.integerValue) {
      case GameResultDraw:
        count++;
        break;
        
      default:
        break;
    }
  }
  return count;
}

+ (NSInteger)loseCountOfRecord:(NSArray *)record
{
  NSInteger count = 0;
  for (NSNumber *result in record) {
    switch (result.integerValue) {
      case GameResultLose:
        count++;
        break;
        
      default:
        break;
    }
  }
  return count;
}

@end
