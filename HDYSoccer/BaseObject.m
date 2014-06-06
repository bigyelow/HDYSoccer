//
//  DOUObject.m
//  DoubanApiClient
//
//  Created by Lin GUO on 4/25/12.
//  Copyright (c) 2012 Douban Inc. All rights reserved.
//

#import "BaseObject.h"


@implementation BaseObject

@dynamic string;
@synthesize dictionary = _dictionary;


- (id)init
{
  self = [super init];
  if (self) {
    self.dictionary = [NSMutableDictionary dictionary];
  }
  return  self;
}


- (id)initWithDictionary:(NSDictionary *)theDictionary
{
  self = [self init];
  if (self) {
    self.dictionary = [[NSMutableDictionary alloc] initWithDictionary:theDictionary];
  }
  return self;
}


- (id)initWithString:(NSString *)theJsonStr
{
  if (!theJsonStr || [theJsonStr length] <= 0) {
    return nil;
  }
  
  NSError *error = nil;
  id jsonObject = [NSJSONSerialization JSONObjectWithData:[theJsonStr dataUsingEncoding:NSUTF8StringEncoding]
                                                  options:kNilOptions
                                                    error:&error];
  if (error) {
    return nil;
  }
  
  NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:jsonObject];
  if (!dic) {
    return nil;
  }
  
  self = [self initWithDictionary:dic];

  return self;
}

- (id)initWithData:(NSData *)theJsonData
{
  if (!theJsonData || [theJsonData length] <= 0) {
    return nil;
  }
  
  NSError *error = nil;
  id jsonObject = [NSJSONSerialization JSONObjectWithData:theJsonData
                                                  options:kNilOptions
                                                    error:&error];
  if (error) {
    return nil;
  }
  
  NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:jsonObject];
  if (!dic) {
    return nil;
  }
  
  self = [self initWithDictionary:dic];
  
  return self;
}


+ (id)objectWithString:(NSString *)theJsonStr
{
  id newInstance = [[[self class] alloc] initWithString:theJsonStr];
  return newInstance;
}

+ (id)objectWithData:(NSData *)theJsonData
{
  id newInstance = [[[self class] alloc] initWithData:theJsonData];
  return newInstance;
}


+ (id)objectWithDictionary:(NSDictionary *)theDictionary
{
  id newInstance = [[[self class] alloc] initWithDictionary:theDictionary];
  return newInstance;
}


- (NSString *)string
{
  if (self.dictionary) {
    NSData *data = [NSJSONSerialization dataWithJSONObject:self.dictionary options:kNilOptions error:nil];
    NSString *result = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    return result;
  }
  return nil;
}

- (void)setString:(NSString *)theJsonStr
{
  NSError *error = nil;
  id jsonObject = [NSJSONSerialization JSONObjectWithData:[theJsonStr dataUsingEncoding:NSUTF8StringEncoding]
                                                  options:kNilOptions
                                                    error:&error];
  if (error) {
    return;
  }
  
  NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:jsonObject];
  if (!dic) {
    return;
  }
  self.dictionary = dic;
}

#pragma mark - NSCoding

- (id)initWithCoder:(NSCoder *)coder
{
  self = [super init];
  if(self != nil) {
    NSDictionary * dic = [coder decodeObjectForKey:@"dictionary"];
    self.dictionary = [NSMutableDictionary dictionaryWithDictionary:dic];
  }
  return self;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
  if (self.dictionary) {
    [coder encodeObject:self.dictionary forKey:@"dictionary"];
  } else {
    [coder encodeObject:@[] forKey:@"dictionary"];
  }
}

@end
