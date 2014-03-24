//
//  AppDelegate.h
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDYSoccerTabBarController.h"

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

// Tabbar
@property (nonatomic, strong) HDYSoccerTabBarController *tabBarController;

@end
