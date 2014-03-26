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

@interface HDYSoccerNavigationController ()

@end

@implementation HDYSoccerNavigationController

- (void)viewDidLoad
{
  [super viewDidLoad];
  [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(panGestureRecognized:)]];
}

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

#pragma mark -
#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
  // Dismiss keyboard (optional)
  //
  [self.view endEditing:YES];
  [self.frostedViewController.view endEditing:YES];
  
  // Present the view controller
  //
  [self.frostedViewController panGestureRecognized:sender];
}

@end
