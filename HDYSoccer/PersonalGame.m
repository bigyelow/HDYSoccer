//
//  PersonalGame.m
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "PersonalGame.h"
#import "ParticipantsScore.h"

@implementation PersonalGame
@synthesize time = _time;
@synthesize sponsor = _sponsor;
@synthesize participants = _participants;

- (NSString *)personalGameID
{
  return [self.dictionary objectForKey:@"personal_game_id"];
}

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

- (SimpleGeekerInfo *)sponsor
{
  if (!_sponsor) {
    NSDictionary *object = [self.dictionary objectForKey:@"sponsor"];
    _sponsor = [SimpleGeekerInfo objectWithDictionary:object];
  }
  return _sponsor;
}

- (NSString *)totalCost
{
  return [self.dictionary objectForKey:@"total_cost"];
}

- (NSString *)costPerPerson
{
  return [self.dictionary objectForKey:@"cost_per_person"];
}

- (NSString *)contact
{
  return [self.dictionary objectForKey:@"contact"];
}

- (NSString *)remark
{
  return [self.dictionary objectForKey:@"remark"];
}

- (NSString *)averageScore
{
  return [self.dictionary objectForKey:@"average_score"];
}

- (NSArray *)participants
{
  if (!_participants) {
    NSArray *object = [self.dictionary objectForKey:@"participants"];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dic in object) {
      SimpleGeekerInfo *geeker = [SimpleGeekerInfo objectWithDictionary:dic];
      [tempArray addObject:geeker];
    }
    _participants = [NSArray arrayWithArray:tempArray];
  }
  return _participants;
}

- (NSString *)gameName
{
  return [self.dictionary objectForKey:@"personal_game_name"];
}

- (NSArray *)rateList
{
  if (!_rateList) {
    NSArray *object = [self.dictionary objectForKey:@"rate_list"];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dic in object) {
      ParticipantsScore *score = [ParticipantsScore objectWithDictionary:dic];
      [tempArray addObject:score];
    }
    _rateList = [tempArray copy];
  }
  
  return _rateList;
}
@end
