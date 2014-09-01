//
//  SimpleTeamGameInfo.m
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "SimpleTeamGameInfo.h"

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
@end
