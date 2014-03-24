//
//  HDYSoccertTabBar.h
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDYSoccertTabBar;

@protocol HDYSoccerTabBarDelegate <NSObject>
- (void)tabBar:(HDYSoccertTabBar *)tabBar didSelectAtIndex:(NSUInteger)index;
@end

@interface HDYSoccertTabBar : UIView
@property (nonatomic, weak) id<HDYSoccerTabBarDelegate> delegate;
@property (nonatomic, strong) NSArray *barButtons;

- (void)createBarButtons;
@end
