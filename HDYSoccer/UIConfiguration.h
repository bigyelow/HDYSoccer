//
//  UIConfiguration.h
//  HDYSoccer
//
//  Created by bigyelow on 3/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <Foundation/Foundation.h>

#define GAME_LIST_BACKGROUND_IMAGE @"background1.jpg"

typedef NS_ENUM(NSUInteger, ScrollDirection) {
  ScrollDirectionNone,
  ScrollDirectionRight,
  ScrollDirectionLeft,
  ScrollDirectionUp,
  ScrollDirectionDown
};

@interface UIConfiguration : NSObject

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

+ (void)setView:(UIView *)view height:(CGFloat)height;
+ (void)setView:(UIView *)view width:(CGFloat)width;
+ (void)setView:(UIView *)view y:(CGFloat)y;
+ (void)setView:(UIView *)view x:(CGFloat)x;

#pragma mark - keyboard
+ (CGRect)keyBoardRect:(NSNotification *)notification;
@end
