//
//  HDYSoccerNavigationController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerNavigationController.h"
#import "UIViewController+REFrostedViewController.h"
#import "HDYSoccerMenuViewController.h"

#define NAVIGATION_BACKGROUND_IMAGE @"background2.jpg"
#define NAVIGATION_BAR_TINT_COLOR GLOBAL_TINT_COLOR
#define NAVIGATION_BACKGROUND_COLOR @"#00994d"

@interface HDYSoccerNavigationController ()

@end

@implementation HDYSoccerNavigationController

- (void)viewDidLoad
{
  [super viewDidLoad];
  
//  [self.navigationBar setBarStyle:UIBarStyleBlackTranslucent];
//  [self.navigationBar setBackgroundColor:[UIConfiguration colorForHex:NAVIGATION_BACKGROUND_COLOR]];
//  UIImage *image = [Tools blurImage:[UIImage imageNamed:NAVIGATION_BACKGROUND_IMAGE]];
//  [self.navigationBar setBackgroundColor:[UIConfiguration colorForHex:NAVIGATION_BACKGROUND_COLOR]];
//  [self.navigationBar setTranslucent:YES];
  [self.navigationBar setTintColor:[UIConfiguration colorForHex:NAVIGATION_BAR_TINT_COLOR]];
//  [self.navigationBar setBackgroundImage:image
//                           forBarMetrics:UIBarMetricsDefault];
}

/*
- (void)showMenu
{
  // Dismiss keyboard (optional)
  //
  [self.view endEditing:YES];
  [self.frostedViewController.view endEditing:YES];
  
  // Present the view controller
  //
  [self.frostedViewController presentMenuViewController];
}
*/

@end
