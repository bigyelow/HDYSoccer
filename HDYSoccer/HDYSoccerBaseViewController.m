//
//  HDYSoccerBaseViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseViewController.h"
#import "AppDelegate.h"
#import "HDYSoccerAPIClient.h"

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
    [self setEdgesForExtendedLayout:UIRectEdgeAll];
    [self setAutomaticallyAdjustsScrollViewInsets:YES];
  }
  [self.view setBackgroundColor:[UIColor whiteColor]];
  [self.view setAutoresizingMask:UIViewAutoresizingFlexibleHeight
   | UIViewAutoresizingFlexibleWidth
   | UIViewAutoresizingFlexibleTopMargin];
  
  [self configBackButton];
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

#pragma mark - top buttons

- (void)configBackButton
{
  UIButton *button = [self topButtonWithImageName:TOP_BACK_IMAGE];
  [UIConfiguration setView:button size:CGSizeMake(TOP_BACK_BUTTON_WIDTH, TOP_BACK_BUTTON_WIDTH)];
  [button addTarget:self action:@selector(backButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
  [self.navigationItem setLeftBarButtonItem:item];
  self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
}

- (void)backButtonPressed
{
  [self.navigationController popViewControllerAnimated:YES];
}

- (void)configTopMenuButton
{
  UIButton *button = [self topButtonWithImageName:TOP_MENU_IMAGE];
  [UIConfiguration setView:button size:CGSizeMake(20, 20)];
  [button addTarget:self action:@selector(menuButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
  [self.navigationItem setLeftBarButtonItem:item];
}

- (void)menuButtonPressed
{
  [self.frostedViewController presentMenuViewController];
}

- (UIButton *)topButtonWithImageName:(NSString *)name
{
  UIImage *image = [UIImage imageNamed:name];
  UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
  [button setBackgroundImage:image forState:UIControlStateNormal];
  [UIConfiguration setView:button size:CGSizeMake(25, 25)];
  
  return button;
}

#pragma mark - API Client
- (HDYSoccerAPIClient *)httpClient
{
  if (!_httpClient) {
    _httpClient = [HDYSoccerAPIClient newHttpClient];
  }
  return _httpClient;
}

- (HDYSoccerAPIClient *)httpsClient
{
  if (!_httpsClient) {
    _httpsClient = [HDYSoccerAPIClient newHttpsClient];
  }
  return _httpsClient;
}

@end
