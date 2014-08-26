//
//  Comment.m
//  HDYSoccer
//
//  Created by bigyelow on 8/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "Comment.h"
#import "Reply.h"

@implementation Comment

- (NSString *)commentID
{
  return [self.dictionary objectForKey:@"comment_id"];
}

- (NSString *)userName
{
  return [self.dictionary objectForKey:@"user_name"];
}

- (NSString *)userID
{
  return [self.dictionary objectForKey:@"user_id"];
}

- (NSString *)content
{
  return [self.dictionary objectForKey:@"content"];
}

- (NSDate *)time
{
  if (!_time) {
    NSString *timeStr = [self.dictionary objectForKey:@"time"];
    _time = [Tools strToDate:timeStr preferUTC:NO];
  }
  return _time;
}

- (NSArray *)replys
{
  if (!_replys) {
    NSArray *array = [self.dictionary objectForKey:@"replys"];
    NSMutableArray *temp = [NSMutableArray array];
    for (NSDictionary *dic in array) {
      Reply *replay = [Reply objectWithDictionary:dic];
      [temp addObject:replay];
    }
    _replys = [temp copy];
  }
  return _replys;
}

@end
