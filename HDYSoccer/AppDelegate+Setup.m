//
//  AppDelegate+Setup.m
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "AppDelegate+Setup.h"
#import "HDYSoccerPlayerViewController.h"
#import "HDYSoccerMenuViewController.h"
#import "HDYSoccerNavigationController.h"

@implementation AppDelegate (Setup)

/*
- (void)loadTabBar
{
  HDYSoccerPlayerViewController *playerController = [[HDYSoccerPlayerViewController alloc] init];
  HDYSoccerNavigationController *playerNav = [[HDYSoccerNavigationController alloc] initWithRootViewController:playerController];
  
  UIViewController *second = [[UIViewController alloc] init];
  UIViewController *third = [[UIViewController alloc] init];
  UIViewController *forth = [[UIViewController alloc] init];
  
  NSArray *viewControllers = @[playerNav, second, third, forth];
  self.appTabBarController = [[HDYSoccerTabBarController alloc] initWithViewControllers:viewControllers];
  
  self.window.rootViewController = self.appTabBarController;
}
*/

- (void)loadFrostedView
{
  // Create content and menu controllers
  HDYSoccerPlayerViewController *playerController = [[HDYSoccerPlayerViewController alloc] init];
  HDYSoccerMenuViewController *menuController = [[HDYSoccerMenuViewController alloc] initWithStyle:UITableViewStylePlain];
  HDYSoccerNavigationController *playerNav = [[HDYSoccerNavigationController alloc] initWithRootViewController:playerController];
  
  // Create frosted view controller
  REFrostedViewController *frostedViewController = [[REFrostedViewController alloc] initWithContentViewController:playerNav
                                                                                               menuViewController:menuController];
  frostedViewController.direction = REFrostedViewControllerDirectionLeft;
  frostedViewController.liveBlurBackgroundStyle = REFrostedViewControllerLiveBackgroundStyleLight;
  frostedViewController.liveBlur = YES;
  frostedViewController.delegate = self;
  
  // Make it a root controller
  self.window.rootViewController = frostedViewController;
}

#pragma mark - frosted viewcontroller delegate
- (void)frostedViewController:(REFrostedViewController *)frostedViewController didRecognizePanGesture:(UIPanGestureRecognizer *)recognizer
{
  
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController willShowMenuViewController:(UIViewController *)menuViewController
{
  NSLog(@"willShowMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didShowMenuViewController:(UIViewController *)menuViewController
{
  NSLog(@"didShowMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController willHideMenuViewController:(UIViewController *)menuViewController
{
  NSLog(@"willHideMenuViewController");
}

- (void)frostedViewController:(REFrostedViewController *)frostedViewController didHideMenuViewController:(UIViewController *)menuViewController
{
  NSLog(@"didHideMenuViewController");
}

@end
