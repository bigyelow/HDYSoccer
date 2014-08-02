//
//  RatePlayerHeaderView.h
//  HDYSoccer
//
//  Created by bigyelow on 8/1/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define RATE_PLAYER_HEADER_HEIGHT 25.0F

// 排名，ID，本场得分，获得标签，评
@interface RatePlayerHeaderView : UIView

+ (CGFloat)rankWidth;
+ (CGFloat)rateWidth;
+ (CGFloat)scoreWidth;
+ (CGFloat)IDWidth;
+ (CGFloat)tagWidth:(CGFloat)viewWidth;

@end
