//
//  AppDelegate+Configuration.h
//  HDYSoccer
//
//  Created by bigyelow on 5/7/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "AppDelegate.h"
#import "RegisterAndLoginViewController.h"

@protocol LocateCallBack <NSObject>
@optional - (void)refreshData;
@end

@interface AppDelegate (Configuration)
<CLLocationManagerDelegate>

- (void)configStandardsDefaults;
- (void)configLocation;
- (void)configNeedData;
- (void)showNetworkActivityIndicator;
- (void)hideNetworkActivityIndicator;
+ (void)showLoginWithDelegate:(id<RegisterAndLoginDelegate>)delegate;
@end
