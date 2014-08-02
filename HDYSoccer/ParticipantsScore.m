//
//  ParticipantsScore.m
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ParticipantsScore.h"
#import "GeekerTag.h"

@implementation ParticipantsScore

- (NSString *)geekerID
{
  return [self.dictionary objectForKey:@"geeker_id"];
}

- (NSString *)avatarURL
{
  return [self.dictionary objectForKey:@"avatar_url"];
}

- (NSString *)name
{
  return [self.dictionary objectForKey:@"name"];
}

// -1 means not rated yet
- (CGFloat)thisScore
{
  NSNumber *number = [self.dictionary objectForKey:@"this_score"];
  if (!number) {
    return NO_VALUE_FOR_FLOAT;
  }
  return number.floatValue;
}

- (NSInteger)thisTagsCount
{
  NSNumber *number = [self.dictionary objectForKey:@"this_tags_count"];
  return number.integerValue;
}

- (NSInteger)thisRank
{
  NSNumber *number = [self.dictionary objectForKey:@"this_rank"];
  return number.integerValue;
}

- (NSArray *)thisTags
{
  if (!_thisTags) {
    NSArray *object = [self.dictionary objectForKey:@"this_tags"];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dic in object) {
      GeekerTag *geekerTag = [GeekerTag objectWithDictionary:dic];
      [tempArray addObject:geekerTag];
    }
    
    _thisTags = [tempArray copy];
  }
  return _thisTags;
}

- (BOOL)canRate
{
  NSNumber *number = [self.dictionary objectForKey:@"can_rate"];
  return number.boolValue;
}
@end
