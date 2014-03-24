//
//  UINavigationController+HDYSoccerNavigationController.h
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, NavigatorSideType) {
  kLeftNavigator,
  kRightNavigator
};

@interface UINavigationController (HDYSoccerNavigationController)

- (id)initNavigatorWithRootViewController:(UIViewController *)viewController;

- (void)createNavButtonWithImage:(UIImage *)buttonImage
                          target:(id)target
                          action:(SEL)action
                            side:(NavigatorSideType)side;
@end
