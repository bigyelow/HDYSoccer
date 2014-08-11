//
//  SimpleTeamInfo.m
//  HDYSoccer
//
//  Created by bigyelow on 8/11/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "SimpleTeamInfo.h"

@implementation SimpleTeamInfo

- (NSString *)teamAvatarURL
{
  return [self.dictionary objectForKey:@"team_avatar_url"];
}

- (NSString *)teamName
{
  return [self.dictionary objectForKey:@"team_name"];
}

- (NSString *)averageScore
{
  return [self.dictionary objectForKey:@"average_score"];
}

- (NSString *)teamID
{
  return [self.dictionary objectForKey:@"team_id"];
}

- (NSString *)captain
{
  return [self.dictionary objectForKey:@"captain"];
}

- (NSInteger)memberCount
{
  NSNumber *number = [self.dictionary objectForKey:@"member_count"];
  if (number) {
    return number.integerValue;
  }
  return 0;
}

- (NSArray *)recentRecords
{
  return [self.dictionary objectForKey:@"recent_record"];
}
@end
