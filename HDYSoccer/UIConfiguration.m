//
//  UIConfiguration.m
//  HDYSoccer
//
//  Created by bigyelow on 3/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "UIConfiguration.h"

@implementation UIConfiguration

+ (void)moveSubviewXToSuperviewCenter:(UIView *)superView
                              subview:(UIView *)subview
{
  CGFloat x = superView.center.x;
  CGFloat y = subview.center.y;
  
  [subview setCenter:CGPointMake(x, y)];
}

@end
