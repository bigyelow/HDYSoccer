//
//  SimplePersonalGameInfo.m
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "SimplePersonalGameInfo.h"

@implementation SimplePersonalGameInfo

@synthesize time = _time;

- (NSString *)personalGameID
{
  return [self.dictionary objectForKey:@"person_game_id"];
}

- (NSDate *)time
{
  if (!_time) {
    NSString *timeStr = [self.dictionary objectForKey:@"time"];
    _time = [Tools strToDate:timeStr preferUTC:NO];
  }
  return _time;
}

- (NSString *)avatarURL
{
  return [self.dictionary objectForKey:@"avatar_url"];
}

- (NSString *)averageScore
{
  return [self.dictionary objectForKey:@"average_score"];
}

- (NSString *)distance
{
  return [self.dictionary objectForKey:@"distance"];
}

- (NSString *)field
{
  return [self.dictionary objectForKey:@"field"];
}

- (NSString *)participantsNumber
{
  return [self.dictionary objectForKey:@"participants_number"];
}

- (NSString *)totalNumberLimit
{
  return [self.dictionary objectForKey:@"total_number_limit"];
}
@end
