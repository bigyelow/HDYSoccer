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
@optional - (void)registerSucceeded:(RegisterAndLoginViewController *)vc;
@optional - (void)registerCanceled:(RegisterAndLoginViewController *)vc;
@optional - (void)registerFailed:(RegisterAndLoginViewController*)vc;

- (void)loginSucceeded:(RegisterAndLoginViewController *)vc;
- (void)loginCanceled:(RegisterAndLoginViewController *)vc;
@optional - (void)loginFailed:(RegisterAndLoginViewController*)vc;

@end

@interface RegisterAndLoginViewController : HDYSoccerBaseViewController
<UITextFieldDelegate>

@property (nonatomic, strong) UITextField *userNameField;
@property (nonatomic, strong) UIView *userSeper;
@property (nonatomic, strong) UITextField *pswField;
@property (nonatomic, strong) UIView *pswSeper;
@property (nonatomic, strong) UIButton *loginButton;
@property (nonatomic, strong) UIButton *registerButton;
@property (nonatomic, strong) UIButton *cancelButton;

- (id)initWithDelegate:(id<RegisterAndLoginDelegate>)delegate;
@end
