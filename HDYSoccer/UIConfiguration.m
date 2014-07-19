//
//  UIConfiguration.m
//  HDYSoccer
//
//  Created by bigyelow on 3/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "UIConfiguration.h"
#import "MBProgresshud.h"

@implementation UIConfiguration

#pragma mark - label
+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font
             numberOfLines:(NSInteger)numberOfLines
{
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
  [label setText:text];
  if (textColor) {
    [label setTextColor:textColor];
  }
  if (font) {
    [label setFont:font];
  }
  [label setNumberOfLines:numberOfLines];
  [label sizeToFit];
  
  return label;
}

+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font
{
  NSInteger numberOfLines = 0;
  return [self labelWithText:text textColor:textColor font:font numberOfLines:numberOfLines];
}

#pragma mark - loading view
+ (void)showTipMessageToView:(UIView *)view
                       title:(NSString *)title
{
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:NO];
  [hud setMode:MBProgressHUDModeIndeterminate];
  [hud setLabelText:title];
}

+ (void)showTipMessageToView:(UIView *)view
{
  [UIConfiguration showTipMessageToView:view title:TEXT_LOADING];
}

+ (void)hideTipMessageOnView:(UIView *)view
{
  [MBProgressHUD hideAllHUDsForView:view animated:YES];
}

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

+ (void)setView:(UIView *)view origin:(CGPoint)origin
{
  [self setView:view x:origin.x];
  [self setView:view y:origin.y];
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
