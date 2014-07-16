//
//  Tools.h
//  HDYSoccer
//
//  Created by bigyelow on 6/6/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^performBlock)();

@interface Tools : NSObject
// view effect
+ (void)blurView:(UIView *)view
           image:(UIImage *)image;

// perform
+ (void)performAfterDelay:(double)delayInSeconds
                    block:(performBlock)block;

// date
+ (NSDate*)strToDate:(NSString*)dateStr preferUTC:(BOOL)isUTC;
+ (NSString*)dateToStr:(NSDate*)date preferUTC:(BOOL)isUTC;
+ (NSString*)dateminuteToStr:(NSDate *)date preferUTC:(BOOL)isUTC;
+ (NSString*)dateOnlyToStr:(NSDate *)date preferUTC:(BOOL)isUTC;
+ (NSString*)getCouponDateOf:(NSString*)time;
@end
