//
//  GeekerTag.m
//  HDYSoccer
//
//  Created by bigyelow on 6/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GeekerTag.h"

@implementation GeekerTag

- (NSString *)tagName
{
  return [self.dictionary objectForKey:@"tag_name"];
}

- (NSInteger)up
{
  NSNumber *number = [self.dictionary objectForKey:@"up"];
  return number.integerValue;
}
@end
