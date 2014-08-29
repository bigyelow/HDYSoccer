//
//  CommonButton.m
//  HDYSoccer
//
//  Created by bigyelow on 8/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CommonButton.h"

@implementation CommonButton

+ (UIButton *)confirmButtonWithFrame:(CGRect)frame
                                font:(UIFont *)font
{
  UIButton *confirmButton = [[UIButton alloc] initWithFrame:frame];
  [confirmButton setTitle:TEXT_OK forState:UIControlStateNormal];
  [confirmButton setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR]];
  [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
  [confirmButton.titleLabel setFont:font];
  
  return confirmButton;
}

+ (UIButton *)cancelButtonWithFrame:(CGRect)frame
                               font:(UIFont *)font
{
  UIButton *cancelButton = [[UIButton alloc] initWithFrame:frame];
  [cancelButton setTitle:TEXT_CANCEL forState:UIControlStateNormal];
  [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [cancelButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
  [cancelButton setBackgroundColor:[UIColor grayColor]];
  [cancelButton.titleLabel setFont:font];
  
  return cancelButton;
}
@end
