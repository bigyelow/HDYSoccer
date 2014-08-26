//
//  UIConfiguration.h
//  HDYSoccer
//
//  Created by bigyelow on 3/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <Foundation/Foundation.h>

#pragma mark - resouce name

// FRAME
#define WINDOW_FRAME ([[UIApplication sharedApplication] keyWindow].frame)

// TOP BUTTON
#define TOP_BACK_IMAGE @"back-25.png"
#define TOP_CONFIRM_IMAGE @"checkmark-50.png"
#define TOP_CANCEL_IMAGE @"cancel-50.png"
#define TOP_MENU_IMAGE @"menu-50.png"
#define TOP_ADD_IMAGE @"plus-50.png"

#define GAME_LIST_PERSONAL_BACKGROUND_IMAGE @"background_field1.jpg"
#define GEEKER_LIST_BACKGROUND_IMAGE @"background_chelsy.jpg"
#define BACKGROUND_BLUR_RADIUS 35

#pragma mark - ui params

#define GLOBAL_TINT_COLOR @"#2980b9"
#define GLOBAL_RED_COLOR @"#ff5500"
#define GLOBAL_GREEN_COLOR @"#37ae84"
#define GLOBAL_SEPERATOR_COLOR @"#e6e6e6"
#define GLOBAL_SEPERATOR_COLOR_CLEAR @"#d0d0d0"
#define GLOBAL_FONT_NAME @"Verdana"
#define GLOBAL_BUTTON_TITLE_PRESSED @"#D6D6D6"

// SCORE COLOR
#define SCORE_TOP_COLOR @"#b30000"
#define SCORE_MIDDLE_COLOR @"#cc7700"
#define SCORE_BOTTOM_COLOR @"#b3b3b3"

// PULL TO REFRESH
#define PTREFRESH_ARROW_COLOR @"FFFFFF"
#define PTREFRESH_TITLE_COLOR @"FFFFFF"
#define PTREFRESH_INDICATIOR_COLOR @"FFFFFF"

#define PTREFRESH_TEXT_PULL_TO_REFRESH @"下拉刷新"
#define PTREFRESH_TEXT_RELEASE_TO_REFRESH @"松开刷新"
#define PTREFRESH_REFRESH_TITLE_FONT_SIZE 13.0f
#define PTREFRESH_REFRESH_X_PLUS 35.0f

// top bar
#define TOP_CONFIRM_BUTTON_WIDTH 27.0F
#define TOP_CANCEL_BUTTON_WIDTH 23.0F
#define TOP_BACK_BUTTON_WIDTH 35.0F
#define TOP_BACK_BUTTON_HEIGHT 32.0F
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

#pragma mark - subviews

+ (void)setSubiews:(UIView *)view hidden:(BOOL)hidden;

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

+ (void)showProcessIndicatorWithView:(UIView *)view;
+ (void)showProcessIndicatorWithView:(UIView *)view atPoint:(CGPoint)point;
+ (void)hideProcessIndicatorWithView:(UIView *)view;

#pragma mark - frame
+ (void)moveSubviewToSuperviewCenter:(UIView *)superview
                             subview:(UIView *)subview;
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

#pragma mark - image
+ (UIImage *)imageForColor:(UIColor *)color;
+ (UIImage *)resizeImage:(UIImage *)srcImage width:(NSUInteger)width height:(NSUInteger)height;
@end
