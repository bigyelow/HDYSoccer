//
//  UILabel+Customize.h
//  HDYSoccer
//
//  Created by bigyelow on 7/31/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UILabel (Customize)

- (void)configWithText:(NSString *)text
             textColor:(UIColor *)textColor
                  font:(UIFont *)font
         numberOfLines:(NSInteger)numberOfLines;

- (void)configWithText:(NSString *)text
             textColor:(UIColor *)textColor
                  font:(UIFont *)font;
- (void)addTapGestureWithTarget:(id)target
                       selector:(SEL)selector;
@end
