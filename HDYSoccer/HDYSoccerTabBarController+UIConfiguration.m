//
//  HDYSoccerTabBarController+UIConfiguration.m
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerTabBarController+UIConfiguration.h"
#import "TabBarUIParams.h"

@implementation HDYSoccerTabBarController (UIConfiguration)

- (void)configTabBar
{
  [self.tabBar setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
  [self.tabBar setDelegate:self];
  
  UITabBarItem *first = [[UITabBarItem alloc] initWithTitle:TABBAR_ITEM_TITLE_0
                                                      image:nil
                                                        tag:0];
  UITabBarItem *second = [[UITabBarItem alloc] initWithTitle:TABBAR_ITEM_TITLE_1
                                                      image:nil
                                                        tag:1];
  UITabBarItem *third = [[UITabBarItem alloc] initWithTitle:TABBAR_ITEM_TITLE_2
                                                      image:nil
                                                        tag:2];
  UITabBarItem *forth = [[UITabBarItem alloc] initWithTitle:TABBAR_ITEM_TITLE_3
                                                      image:nil
                                                        tag:3];
  
  [self.tabBar setItems:@[first, second, third, forth]];
}

@end
