//
//  GeekerList.h
//  HDYSoccer
//
//  Created by bigyelow on 5/6/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "JSONModel.h"
#import "SimpleGeekerInfo.h"

@interface GeekerList : JSONModel

@property (nonatomic, strong, readonly) NSArray<SimpleGeekerInfo> *geekerlist;

@end
