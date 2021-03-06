//
//  Tools.m
//  HDYSoccer
//
//  Created by bigyelow on 6/6/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "Tools.h"
#import "GPUImage.h"

#pragma mark - consts
#pragma mark - notifications

NSString  * const kNotificationLogout = @"kNotificationLogout";

@implementation Tools

#pragma mark - string
+ (BOOL)isNilOrEmpty:(NSString *)string
{
  if (string == nil || [string isEqualToString:@""]) {
    return true;
  }
  return false;
}

+ (BOOL)isNilOrEmptyArray:(NSArray *)array
{
  if (array == nil || [array count] == 0) {
    return true;
  }
  return false;
}

#pragma mark - view effect
+ (void)blurView:(UIView *)view
           image:(UIImage *)image
{
  UIImage *blurredSnapshotImage = [self blurImage:image];
  view.backgroundColor = [UIColor colorWithPatternImage:blurredSnapshotImage];
}

+ (void)blurView:(UIView *)view
           image:(UIImage *)image
      blurRadius:(CGFloat)blurRadis
{
  UIImage *blurredSnapshotImage = [self blurImage:image blurRadius:blurRadis];
  view.backgroundColor = [UIColor colorWithPatternImage:blurredSnapshotImage];
}

+ (UIImage *)blurImage:(UIImage *)image
{
  CGFloat blurRadius = 4.0f;
  return [self blurImage:image blurRadius:blurRadius];
}

+ (UIImage *)blurImage:(UIImage *)image
            blurRadius:(CGFloat)blurRadius
{
  GPUImageiOSBlurFilter *filter = [GPUImageiOSBlurFilter new];
  [filter setBlurRadiusInPixels:blurRadius];
  UIImage *blurredSnapshotImage = [filter imageByFilteringImage:image];
  return blurredSnapshotImage;
}

#pragma mark - perform delay
+ (void)performAfterDelay:(double)delayInSeconds
                    block:(performBlock)block

{
  dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, delayInSeconds * NSEC_PER_SEC);
  dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
    block();
  });
}

#pragma mark - date
NSString* const kUTCDatetimeFormat = @"yyyy-MM-dd'T'HH:mm:ssz";
NSString* const kDefaultDatetimeFormat = @"yyyy-MM-dd HH:mm:ss";
NSString* const kDefaultDateminuteFormat = @"yyyy-MM-dd HH:mm";
NSString* const kDefaultDateFormat = @"yyyy-MM-dd";

+ (NSDate*)strToDate:(NSString *)dateStr preferUTC:(BOOL)isUTC{
  NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
  if (isUTC) {
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:kUTCDatetimeFormat];
  }else {
    [formatter setDateFormat:kDefaultDatetimeFormat];
  }
  NSDate* date = [formatter dateFromString:dateStr];
  return date;
}

+ (NSString*)dateToStr:(NSDate *)date preferUTC:(BOOL)isUTC{
  NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
  if (isUTC) {
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:kUTCDatetimeFormat];
  }else {
    [formatter setDateFormat:kDefaultDatetimeFormat];
  }
  NSString* dateStr = [formatter stringFromDate:date];
  return dateStr;
}

+ (NSString*)dateminuteToStr:(NSDate *)date preferUTC:(BOOL)isUTC{
  NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
  if (isUTC) {
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:kUTCDatetimeFormat];
  }else {
    [formatter setDateFormat:kDefaultDateminuteFormat];
  }
  NSString* dateStr = [formatter stringFromDate:date];
  return dateStr;
}

+ (NSString*)dateOnlyToStr:(NSDate *)date preferUTC:(BOOL)isUTC{
  NSDateFormatter* formatter = [[NSDateFormatter alloc] init];
  if (isUTC) {
    [formatter setTimeZone:[NSTimeZone timeZoneWithAbbreviation:@"UTC"]];
    [formatter setDateFormat:kUTCDatetimeFormat];
  }else {
    [formatter setDateFormat:kDefaultDateFormat];
  }
  NSString* dateStr = [formatter stringFromDate:date];
  return dateStr;
}

+ (NSString*)getCouponDateOf:(NSString*)time{
  NSDateFormatter *df = [[NSDateFormatter alloc] init];
  [df setDateFormat:@"yyyy-MM-dd"];
  NSLocale *locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
  [df setLocale:locale];
  NSDate *date = [df dateFromString:time];
  
  NSString* timestamp;
  [df setDateFormat:@"yyyy年M月d日"];
  timestamp = [df stringFromDate:date];
  
  return timestamp;
}

#pragma mark - validation
+ (BOOL)verifyPhoneNumberFormat:(NSString *)phoneNumberString
{
  NSRange rng = [phoneNumberString rangeOfString:@"1[358][0-9]{9}+" options:NSRegularExpressionSearch];
  return NSNotFound != rng.location;
}

+ (BOOL)verifyPhoneNumberLength:(NSString *)phoneNumberString
{
  return [phoneNumberString length] == 11;
}

#pragma mark - operations

+ (BOOL)isSelfUser:(NSString *)userID
{
  return [[AppContext appContext].auth.userID isEqualToString:userID];
}

#pragma mark - positions
+ (NSArray *)positionsArray
{
  return @[@"门将", @"右后卫", @"左后卫", @"中后卫", @"左前卫", @"右前卫", @"后腰", @"前腰", @"前锋", @"中锋"];
}
@end
