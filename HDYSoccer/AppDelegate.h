//
//  AppDelegate.h
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "REFrostedViewController.h"
#import "HDYSoccerNavigationController.h"

#define APP_DELEGATE  ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface AppDelegate : UIResponder <UIApplicationDelegate, REFrostedViewControllerDelegate>

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) HDYSoccerNavigationController *geekerNav;

//@property (nonatomic, strong) HDYSoccerTabBarController *appTabBarController;
@end
