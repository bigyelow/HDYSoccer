//
//  UIConfiguration.m
//  HDYSoccer
//
//  Created by bigyelow on 3/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "UIConfiguration.h"

@implementation UIConfiguration

#pragma mark - position adjust
+ (void)moveSubviewXToSuperviewCenter:(UIView *)superView
                              subview:(UIView *)subview
{
  CGFloat x = superView.center.x;
  CGFloat y = subview.center.y;
  
  [subview setCenter:CGPointMake(x, y)];
}

+ (void)moveSubviewYToSuperviewCenter:(UIView *)superView
                              subview:(UIView *)subview
{
  CGFloat x = subview.center.x;
  CGFloat y = superView.center.y;
  
  [subview setCenter:CGPointMake(x, y)];
}

+ (void)setView:(UIView *)view x:(CGFloat)x
{
  CGRect rect = view.frame;
  rect.origin.x = x;
  [view setFrame:rect];
}

+ (void)setView:(UIView *)view y:(CGFloat)y
{
  CGRect rect = view.frame;
  rect.origin.y = y;
  [view setFrame:rect];
}

+ (void)setView:(UIView *)view height:(CGFloat)height
{
  CGRect rect = view.frame;
  rect.size.height = height;
  [view setFrame:rect];
}

+ (void)setView:(UIView *)view width:(CGFloat)width
{
  CGRect rect = view.frame;
  rect.size.width = width;
  [view setFrame:rect];
}

#pragma mark - keyboard
+ (CGRect)keyBoardRect:(NSNotification *)notification
{
  return [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
}

@end
