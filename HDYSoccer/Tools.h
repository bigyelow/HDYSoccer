//
//  Tools.h
//  HDYSoccer
//
//  Created by bigyelow on 6/6/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Tools : NSObject

// date
+ (NSDate*) strToDate:(NSString*)dateStr preferUTC:(BOOL)isUTC;
+ (NSString*) dateToStr:(NSDate*)date preferUTC:(BOOL)isUTC;
+ (NSString*)dateOnlyToStr:(NSDate *)date preferUTC:(BOOL)isUTC;
+ (NSString*)getCouponDateOf:(NSString*)time;
@end
