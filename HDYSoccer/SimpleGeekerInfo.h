//
//  SimpleGeekerInfo.h
//  HDYSoccer
//
//  Created by bigyelow on 5/4/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

typedef NS_ENUM(NSInteger, GeekerStatus)
{
  GeekerStatusLowest,
  GeekerStatusLow,
  GeekerStatusNormal,
  GeekerStatusGood,
  GeekerStatusGreate
};

#import "BaseObject.h"

@protocol SimpleGeekerInfo

@end

@interface SimpleGeekerInfo : BaseObject

@property (nonatomic, copy, readonly) NSString *geekerID;
@property (nonatomic, copy, readonly) NSString *avatarURL;
@property (nonatomic, copy, readonly) NSString *name;
@property (nonatomic, copy, readonly) NSString *score;
@property (nonatomic, strong) NSArray *position;
@property (nonatomic, assign) GeekerStatus status;
@property (nonatomic, strong, readonly) NSArray *tagsArray;

@end
