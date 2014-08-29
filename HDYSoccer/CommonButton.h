//
//  CommonButton.h
//  HDYSoccer
//
//  Created by bigyelow on 8/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CommonButton : NSObject

+ (UIButton *)confirmButtonWithFrame:(CGRect)frame
                                font:(UIFont *)font;
+ (UIButton *)cancelButtonWithFrame:(CGRect)frame
                               font:(UIFont *)font;
@end
