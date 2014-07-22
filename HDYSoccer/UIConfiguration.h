//
//  UIConfiguration.h
//  HDYSoccer
//
//  Created by bigyelow on 3/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - resouce name

#define GAME_LIST_PERSONAL_BACKGROUND_IMAGE @"background2.jpg"
#define GAME_LIST_TEAM_BACKGROUND_IMAGE @"background2.jpg"
#define GEEKER_LIST_BACKGROUND_IMAGE @"background2.jpg"

#pragma mark - ui params

#define GLOBAL_TINT_COLOR @"#2980b9"
#define STATUS_BAR_HEIGHT ([[UIApplication sharedApplication] statusBarFrame].size.height)
#define NAVIGATION_BAR_HEIGHT (self.navigationController.navigationBar.frame.size.height)
#define TOP_BAR_HEIGHT (STATUS_BAR_HEIGHT + NAVIGATION_BAR_HEIGHT)

typedef NS_ENUM(NSUInteger, ScrollDirection) {
  ScrollDirectionNone,
  ScrollDirectionRight,
  ScrollDirectionLeft,
  ScrollDirectionUp,
  ScrollDirectionDown
};

@interface UIConfiguration : NSObject

#pragma mark - label
+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font
             numberOfLines:(NSInteger)numberOfLines;

+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font;

#pragma mark - loading view
+ (void)showTipMessageToView:(UIView *)view;
+ (void)hideTipMessageOnView:(UIView *)view;
+ (void)showTipMessageToView:(UIView *)view
                       title:(NSString *)title;

#pragma mark - frame
+ (void)moveSubviewXToSuperviewCenter:(UIView *)superView
                              subview:(UIView *)subview;
+ (void)moveSubviewYToSuperviewCenter:(UIView *)superView 
                              subview:(UIView *)subview;

+ (void)setView:(UIView *)view size:(CGSize)size;
+ (void)setView:(UIView *)view origin:(CGPoint)origin;
+ (void)setView:(UIView *)view height:(CGFloat)height;
+ (void)setView:(UIView *)view width:(CGFloat)width;
+ (void)setView:(UIView *)view y:(CGFloat)y;
+ (void)setView:(UIView *)view x:(CGFloat)x;

#pragma mark - keyboard
+ (CGRect)keyBoardRect:(NSNotification *)notification;

#pragma mark - uilabel
@end
