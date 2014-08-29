//
//  CommonButton.m
//  HDYSoccer
//
//  Created by bigyelow on 8/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CommonButton.h"

#define CONFIRM_DISABLE_TITLE_COLOR @"#DFDFDF"

@implementation CommonButton

+ (UIButton *)confirmButtonWithFrame:(CGRect)frame
                                font:(UIFont *)font
{
  return [self confirmButtonWithFrame:frame title:TEXT_OK font:font];
}

+ (UIButton *)cancelButtonWithFrame:(CGRect)frame
                               font:(UIFont *)font
{
  return [self cancelButtonWithFrame:frame title:TEXT_CANCEL font:font];
}

+ (UIButton *)confirmButtonWithFrame:(CGRect)frame
                               title:(NSString *)title
                                font:(UIFont *)font
{
  UIButton *confirmButton = [[UIButton alloc] initWithFrame:frame];
  [confirmButton setTitle:title forState:UIControlStateNormal];
  [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [confirmButton setTitleColor:[UIConfiguration colorForHex:CONFIRM_DISABLE_TITLE_COLOR] forState:UIControlStateDisabled];
  [confirmButton setBackgroundImage:[UIConfiguration imageForColorHex:GLOBAL_TINT_COLOR] forState:UIControlStateNormal];
  [confirmButton setBackgroundImage:[UIConfiguration imageForColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
  [confirmButton setBackgroundImage:[UIConfiguration imageForColor:[UIColor lightGrayColor]] forState:UIControlStateDisabled];
  [confirmButton.titleLabel setFont:font];
  
  return confirmButton;
}

+ (UIButton *)cancelButtonWithFrame:(CGRect)frame
                              title:(NSString *)title
                               font:(UIFont *)font
{
  UIButton *cancelButton = [[UIButton alloc] initWithFrame:frame];
  [cancelButton setTitle:title forState:UIControlStateNormal];
  [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [cancelButton setBackgroundImage:[UIConfiguration imageForColor:[UIColor grayColor]] forState:UIControlStateNormal];
  [cancelButton setBackgroundImage:[UIConfiguration imageForColor:[UIColor lightGrayColor]] forState:UIControlStateHighlighted];
  [cancelButton setBackgroundColor:[UIColor grayColor]];
  [cancelButton.titleLabel setFont:font];
  
  return cancelButton;
}
@end
