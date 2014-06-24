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
@end
