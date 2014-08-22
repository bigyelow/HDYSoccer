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
  
  if (self.shouldShowDismissButton) {
    [self configDismissButton];
  }
  else {
    [self configBackButton];
  }
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
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@""
                                                           style:UIBarButtonItemStyleBordered
                                                          target:self
                                                          action:@selector(backButtonPressed)];
  UIImage *image = [UIImage imageNamed:TOP_BACK_IMAGE];
  [item setImage:image];
  [item setImageInsets:UIEdgeInsetsMake(0, -10, 0, 0)];
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

- (void)configDismissButton
{
  UIButton *button = [self topButtonWithImageName:TOP_CANCEL_IMAGE];
  [UIConfiguration setView:button size:CGSizeMake(25, 25)];
  [button addTarget:self action:@selector(dismissButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
  [self.navigationItem setLeftBarButtonItem:item];
}

- (void)dismissButtonPressed
{
  [self dismissViewControllerAnimated:YES completion:nil];
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
