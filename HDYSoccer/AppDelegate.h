//
//  AppDelegate.h
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import "REFrostedViewController.h"
#import "HDYSoccerNavigationController.h"

#define APP_DELEGATE  ((AppDelegate *)[UIApplication sharedApplication].delegate)

// location
#define MAX_LOCATED_LIMIT 3

@interface AppDelegate : UIResponder <UIApplicationDelegate, REFrostedViewControllerDelegate>
{
  CLLocationManager       *_m_locManager;//获取位置信息
  CLGeocoder              *_geoCoder;
  BOOL                    _hasFindPlace;
  NSMutableArray          *_callbacks;
  int                      _locationCounts;
}

@property (nonatomic, strong) UIWindow *window;

@property (nonatomic, strong) HDYSoccerNavigationController *geekerNav;
@property (nonatomic, strong) HDYSoccerNavigationController *gameNav;

#pragma mark - location
@property (nonatomic, assign)BOOL hasFindPlace;
@property (nonatomic, strong)CLLocationManager *m_locManager;//获取位置信息
@property (nonatomic, strong)CLGeocoder *geoCoder;
@property (nonatomic, strong)NSMutableArray *callbacks;
@property (nonatomic, assign)int locationCounts;

@end
