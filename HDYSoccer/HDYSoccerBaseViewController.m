//
//  HDYSoccerBaseViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseViewController.h"
#import "AppDelegate.h"

@interface HDYSoccerBaseViewController ()

@end

@implementation HDYSoccerBaseViewController

#pragma mark - init
- (id)init
{
  self = [super init];
  if (self) {

  }
  return self;
}

#pragma mark - view lifecycle
- (void)viewDidLoad
{
  [super viewDidLoad];
  
  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    [self setEdgesForExtendedLayout:UIRectEdgeNone];
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
  }
  [self.view setBackgroundColor:[UIColor whiteColor]];
  [self.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight
   | UIViewAutoresizingFlexibleWidth
   | UIViewAutoresizingFlexibleTopMargin];
}

- (void)viewWillAppear:(BOOL)animated
{
  [super viewWillAppear:animated];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

@end
