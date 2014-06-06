//
//  DOUObject.h
//  DoubanApiClient
//
//  Created by Lin GUO on 4/25/12.
//  Copyright (c) 2012 Douban Inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BaseObject : NSObject <NSCoding>
{
  NSMutableDictionary *_dictionary;
}

@property (nonatomic, readonly, retain) NSData *data;
@property (nonatomic, readonly, retain) NSString *string;
@property (nonatomic, retain) NSMutableDictionary *dictionary;

- (id)initWithData:(NSData *)theJsonData;
- (id)initWithString:(NSString *)theJsonStr;
- (id)initWithDictionary:(NSDictionary *)theDictionary;

+ (id)objectWithData:(NSData *)theJsonData;
+ (id)objectWithString:(NSString *)theJsonStr;
+ (id)objectWithDictionary:(NSDictionary *)theDictionary;

@end
