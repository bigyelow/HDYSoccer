//
//  Tools.h
//  HDYSoccer
//
//  Created by bigyelow on 6/6/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <Foundation/Foundation.h>

#define NO_VALUE_FOR_FLOAT -1

#define LOCAL_TAGS @[@"高质量长传",@"高质量短传",@"优质盘带",@"意识NB",@"基本功",@"抢断",@"解围",@"扑救",@"头球",@"速度",@"力量",@"体力",@"侵略性"]

// NSUserDefaults
#define DEFAULTS_TAGS_KEY @"defaults_tags_key"

typedef NS_ENUM(NSUInteger, kScoreGrade) {
  kScoreGradeTop = 90,
  kScoreGradeMiddle = 80,
  kScoreGradeBottom,
};

typedef void (^performBlock)();

@interface Tools : NSObject
// string
+ (BOOL)isNilOrEmpty:(NSString *)string;
// array
+ (BOOL)isNilOrEmptyArray:(NSArray *)array;


// view effect
+ (void)blurView:(UIView *)view
           image:(UIImage *)image
      blurRadius:(CGFloat)blurRadis;
+ (UIImage *)blurImage:(UIImage *)image;
+ (void)blurView:(UIView *)view
           image:(UIImage *)image;
+ (UIImage *)blurImage:(UIImage *)image
            blurRadius:(CGFloat)blurRadius;

// perform
+ (void)performAfterDelay:(double)delayInSeconds
                    block:(performBlock)block;

// date
+ (NSDate*)strToDate:(NSString*)dateStr preferUTC:(BOOL)isUTC;
+ (NSString*)dateToStr:(NSDate*)date preferUTC:(BOOL)isUTC;
+ (NSString*)dateminuteToStr:(NSDate *)date preferUTC:(BOOL)isUTC;
+ (NSString*)dateOnlyToStr:(NSDate *)date preferUTC:(BOOL)isUTC;
+ (NSString*)getCouponDateOf:(NSString*)time;

// validation
+ (BOOL)verifyPhoneNumberFormat:(NSString *)phoneNumberString;
+ (BOOL)verifyPhoneNumberLength:(NSString *)phoneNumberString;
@end
