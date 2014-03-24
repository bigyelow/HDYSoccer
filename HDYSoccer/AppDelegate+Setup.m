//
//  AppDelegate+Setup.m
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "AppDelegate+Setup.h"
#import "UINavigationController+HDYSoccerNavigationController.h"

@implementation AppDelegate (Setup)

- (void)createTabBar
{
  UIViewController *first = [[UIViewController alloc] init];
  UIViewController *second = [[UIViewController alloc] init];
  UIViewController *third = [[UIViewController alloc] init];
  UIViewController *forth = [[UIViewController alloc] init];
  
  UINavigationController *firstNav = [[UINavigationController alloc] initNavigatorWithRootViewController:first];
  
  self.tabBarController = [[HDYSoccerTabBarController alloc] initWithViewControllers:@[firstNav, second, third, forth]];
  [self.window setRootViewController:self.tabBarController];
}

@end
