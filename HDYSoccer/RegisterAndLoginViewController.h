//
//  RegisterAndLoginViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 6/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseViewController.h"
@class RegisterAndLoginViewController;

@protocol RegisterAndLoginDelegate <NSObject>
- (void)registerSucceeded:(RegisterAndLoginViewController *)vc;
- (void)registerCanceled:(RegisterAndLoginViewController *)vc;
@optional - (void)registerFailed:(RegisterAndLoginViewController*)vc;

- (void)loginSucceeded:(RegisterAndLoginViewController *)vc;
- (void)loginCanceled:(RegisterAndLoginViewController *)vc;
@optional - (void)loginFailed:(RegisterAndLoginViewController*)vc;
@end

@interface RegisterAndLoginViewController : HDYSoccerBaseViewController

@end
