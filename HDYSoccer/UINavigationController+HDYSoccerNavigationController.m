//
//  UINavigationController+HDYSoccerNavigationController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "UINavigationController+HDYSoccerNavigationController.h"
#import "NavigationBarParams.h"

// override back button method for ios7
@implementation UINavigationItem (MyBackButton)

//- (UIBarButtonItem *)backBarButtonItem
//{
//  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
//    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@""
//                                                                   style:UIBarButtonItemStyleBordered
//                                                                  target:nil
//                                                                  action:nil];
//    
//    return backButton;
//  }
//  return nil;
//}

@end

@implementation UINavigationController (HDYSoccerNavigationController)

- (id)initNavigatorWithRootViewController:(UIViewController *)viewController
{
  self = [self initWithRootViewController:viewController];
  if (self) {
    [self configNavigationBar];
  }
  return self;
}

- (void)configNavigationBar
{
  [self.navigationBar setTranslucent:YES];

  NSDictionary *textTitleOptions;
  if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"7.0")) {
    [self.navigationBar setBarStyle:UIBarStyleDefault];
//    [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
    
//    UIImage *image = [UIImage imageNamed:@"ic_back.png"];
//    [[UINavigationBar appearance] setBackIndicatorTransitionMaskImage:image];
//    [[UINavigationBar appearance] setBackIndicatorImage:image];
    
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
    
    textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                                      [UIColor blackColor], NSForegroundColorAttributeName, nil];
  } else {
    [self.navigationBar setTintColor:[UIColor blackColor]];
    
//    UIImage *image = [UIImage imageNamed:@"ic_back.png"];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:image
//                                                      forState:UIControlStateNormal
//                                                    barMetrics:UIBarMetricsDefault];
//    [[UIBarButtonItem appearance] setBackButtonBackgroundImage:image
//                                                      forState:UIControlStateNormal
//                                                    barMetrics:UIBarMetricsLandscapePhone];
    
    textTitleOptions = [NSDictionary dictionaryWithObjectsAndKeys:
                        [UIColor blackColor], NSForegroundColorAttributeName, nil];
  }
  [[UINavigationBar appearance] setTitleTextAttributes:textTitleOptions];
}

// 这个方法可以自定义navigation bar的left button和right button
- (void)createNavButtonWithImage:(UIImage *)buttonImage
                          target:(id)target
                          action:(SEL)action
                            side:(NavigatorSideType)side
{
  CGFloat buttonWidth, buttonHeight, edgeLeft, edgeRight;
  if (side == kLeftNavigator) {
    buttonWidth = NAVIGATOR_LEFTBUTTON_WIDTH;
    buttonHeight = NAVIGATOR_LEFTBUTTON_HEIGHT;
    edgeLeft = -10.0f;
    edgeRight = 10.0f;
  }
  else {
    buttonWidth = NAVIGATOR_RIGHTBUTTON_WIDTH;
    buttonHeight = NAVIGATOR_RIGHTBUTTON_HEIGHT;
    edgeLeft = 10.0f;
    edgeRight = -10.0f;
  }
  
  CGRect buttonFrame = CGRectMake(0, 0, buttonWidth, buttonHeight);
  UIButton *button = [[UIButton alloc] initWithFrame:buttonFrame];
  [button setContentEdgeInsets:UIEdgeInsetsMake(0, edgeLeft, 0, edgeRight)];
  [button setImage:buttonImage forState:UIControlStateNormal];
  
  [button addTarget:target
             action:action
   forControlEvents:UIControlEventTouchUpInside];
  
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
  
  if (side == kLeftNavigator) {
    self.navigationItem.leftBarButtonItem = item;
  }
  else {
    self.navigationItem.rightBarButtonItem = item;
  }
}

@end
