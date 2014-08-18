//
//  SimpleGeekerInfo.m
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "SimpleGeekerInfo.h"
#import "GeekerTag.h"

@implementation SimpleGeekerInfo
@synthesize tagsArray = _tagsArray;

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

- (NSString *)score
{
  return [self.dictionary objectForKey:@"score"];
}

- (NSArray *)tagsArray
{
  if (!_tagsArray) {
    NSArray *object = [self.dictionary objectForKey:@"tags"];
    NSMutableArray *tempArray = [NSMutableArray array];
    for (NSDictionary *dic in object) {
      GeekerTag *geekerTag = [GeekerTag objectWithDictionary:dic];
      [tempArray addObject:geekerTag];
    }
    
    _tagsArray = [NSArray arrayWithArray:tempArray];
  }
  return _tagsArray;
}

- (CGFloat)averageGameScore
{
  NSNumber *number = [self.dictionary objectForKey:@"averageGameScore"];
  if (number) {
    return number.floatValue;
  }
  return 0;
}

- (NSArray *)position
{
  return [self.dictionary objectForKey:@"position"];
}

- (GeekerStatus)status
{
  NSNumber *number = [self.dictionary objectForKey:@"status"];
  
  GeekerStatus tempStatus = GeekerStatusLowest;
  switch (number.integerValue) {
    case 1:
      break;
      
    case 2:
      tempStatus = GeekerStatusLow;
      break;
      
    case 3:
      tempStatus = GeekerStatusNormal;
      break;
      
    case 4:
      tempStatus = GeekerStatusGood;
      break;
      
    case 5:
      tempStatus = GeekerStatusGreate;
      break;
      
    default:
      break;
  }
  
  return tempStatus;
}
@end
