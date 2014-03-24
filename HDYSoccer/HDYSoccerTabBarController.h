//
//  HDYSoccerTabBarController.h
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HDYSoccerTabBarController : UIViewController <UITabBarDelegate>

@property (nonatomic, assign) NSUInteger selectedIndex;
@property (nonatomic, strong) UIViewController *selectedViewController;
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UITabBar *tabBar;

@property (nonatomic, assign) BOOL isBarHidden;

- (id)initWithViewControllers:(NSArray *)viewCtrs;

#pragma mark - control tabbar
- (void)setTabBarHidden:(BOOL)hidden;

#pragma mark - seach view
- (void)showSearchView;
- (void)hideSearchView;
- (void)fastHideSearchView;
- (void)hideSearchContentView;
@end
