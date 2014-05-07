//
//  Location.h
//  HDYSoccer
//
//  Created by bigyelow on 5/7/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "JSONModel.h"

@interface Location : JSONModel

@property (nonatomic, assign) BOOL locateAllowed;
@property (nonatomic, copy) NSString *latitude;
@property (nonatomic, copy) NSString *lontitude;
@property (nonatomic, copy) NSString *city;

@end
