//
//  TeamGameRecords.m
//  HDYSoccer
//
//  Created by bigyelow on 6/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "TeamGameRecords.h"

@implementation TeamGameRecords
@synthesize time = _time;

- (NSString *)homeTeamID
{
  return [self.dictionary objectForKey:@"home_team_id"];
}

- (NSString *)homeTeamName
{
  return [self.dictionary objectForKey:@"home_team_name"];
}

- (NSString *)guestTeamID
{
  return [self.dictionary objectForKey:@"guest_team_id"];
}

- (NSString *)guestTeamName
{
  return [self.dictionary objectForKey:@"guest_team_name"];
}

- (NSDate *)time
{
  if (!_time) {
    NSString *timeStr = [self.dictionary objectForKey:@"time"];
    _time = [Tools strToDate:timeStr preferUTC:NO];
  }
  return _time;
}

- (NSString *)score
{
  return [self.dictionary objectForKey:@"score"];
}
@end
