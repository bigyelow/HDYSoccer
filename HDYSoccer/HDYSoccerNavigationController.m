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

@interface HDYSoccerNavigationController ()

@end

@implementation HDYSoccerNavigationController

- (void)viewDidLoad
{
  [super viewDidLoad];

//  UIImage *image = [Tools blurImage:[UIImage imageNamed:NAVIGATION_BACKGROUND_IMAGE]];
//  [self.navigationBar setTintColor:[UIColor whiteColor]];
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
