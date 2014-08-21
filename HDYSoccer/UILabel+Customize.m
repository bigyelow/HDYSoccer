//
//  UILabel+Customize.m
//  HDYSoccer
//
//  Created by bigyelow on 7/31/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "UILabel+Customize.h"

@implementation UILabel (Customize)

- (void)configWithText:(NSString *)text
             textColor:(UIColor *)textColor
                  font:(UIFont *)font
         numberOfLines:(NSInteger)numberOfLines
{
  [self setText: text];
  [self setTextColor:textColor];
  [self setFont:font];
  [self setNumberOfLines:numberOfLines];
  [self sizeToFit];
}

- (void)configWithText:(NSString *)text
             textColor:(UIColor *)textColor
                  font:(UIFont *)font
{
  [self configWithText:text textColor:textColor font:font numberOfLines:0];
}

- (void)addTapGestureWithTarget:(id)target
                       selector:(SEL)selector
{
  UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:target action:selector];
  [self setUserInteractionEnabled:YES];
  [self addGestureRecognizer:gest];
}
@end
