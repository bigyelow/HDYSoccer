//
//  RegisterAndLoginViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 6/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "RegisterAndLoginViewController.h"

// CANCEL
#define CANCEL_LEFT_MARGIN 15

// REGISTER
#define REGISTER_RIGHT_MARGIN CANCEL_LEFT_MARGIN
#define REGISTER_TOP_MARGIN 8

// NAME FIELD
#define NAME_FIELD_LEFT_MARGIN 27
#define NAME_FIELD_TOP_MARGIN 300
#define NAME_FIELD_HEIGTH 40

// SEPER
#define SEPER_MINUS_TOP_MARGIN 7

// PASSWORD FIELD
#define PASSWORD_FILED_TOP_MARGIN 10

// LOGIN
#define LOGIN_TOP_MARGIN 25
#define LOGIN_HEIGHT 33
#define LOGIN_WIDTH 170

@interface RegisterAndLoginViewController ()

@property (nonatomic, strong) id<RegisterAndLoginDelegate> regLogDelegate;
@end

@implementation RegisterAndLoginViewController

- (id)initWithDelegate:(id<RegisterAndLoginDelegate>)delegate
{
  self = [super init];
  if (self) {
    self.regLogDelegate = delegate;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self configCancelButton];
  [self configUserNameField];
  [self configPasswordField];
  [self configLoginButton];
  [self configRegisterButton];
}

- (void)configCancelButton
{
  UIButton *cancelButton = [self topButtonWithImageName:TOP_CANCEL_IMAGE];
  [UIConfiguration setView:cancelButton size:CGSizeMake(TOP_CANCEL_BUTTON_WIDTH, TOP_CANCEL_BUTTON_WIDTH)];
  [UIConfiguration setView:cancelButton origin:CGPointMake(CANCEL_LEFT_MARGIN, STATUS_BAR_HEIGHT + CANCEL_LEFT_MARGIN)];
  [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  [self.view addSubview:cancelButton];
}

- (void)configRegisterButton
{
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectZero];
  [button.titleLabel setFont:[UIFont systemFontOfSize:18]];
  [button setTitle:TEXT_REGISTER forState:UIControlStateNormal];
  [button setTitleColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR] forState:UIControlStateNormal];
  [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
  [button sizeToFit];
  
  CGFloat x = self.view.bounds.size.width - REGISTER_RIGHT_MARGIN - button.frame.size.width;
  [UIConfiguration setView:button origin:CGPointMake(x, STATUS_BAR_HEIGHT + REGISTER_TOP_MARGIN)];
  
  [self.view addSubview:button];
}

- (void)configUserNameField
{
  CGFloat y = NAME_FIELD_TOP_MARGIN;
  CGFloat width = self.view.frame.size.width - 2 * NAME_FIELD_LEFT_MARGIN;
  UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(NAME_FIELD_LEFT_MARGIN, y, width, NAME_FIELD_HEIGTH)];
  [field setPlaceholder:TEXT_LOGIN_NAME_PLACE_HOLDER];
  [field setKeyboardType:UIKeyboardTypeEmailAddress];
  [field setReturnKeyType:UIReturnKeyNext];
  [field setClearButtonMode:UITextFieldViewModeWhileEditing];
  
  self.userNameField = field;
  [self.view addSubview:field];
  
  CGFloat seperY = CGRectGetMaxY(field.frame) - SEPER_MINUS_TOP_MARGIN;
  UIView *seper = [[UIView alloc] initWithFrame:CGRectMake(NAME_FIELD_LEFT_MARGIN, seperY, width, 1)];
  [seper setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR]];
  
  self.userSeper = seper;
  [self.view addSubview:seper];
}

- (void)configPasswordField
{
  CGFloat y = CGRectGetMaxY(self.userSeper.frame) + PASSWORD_FILED_TOP_MARGIN;
  CGFloat width = self.view.frame.size.width - 2 * NAME_FIELD_LEFT_MARGIN;
  UITextField *field = [[UITextField alloc] initWithFrame:CGRectMake(NAME_FIELD_LEFT_MARGIN, y, width, NAME_FIELD_HEIGTH)];
  [field setPlaceholder:TEXT_PASSWORD];
  [field setKeyboardType:UIKeyboardTypeEmailAddress];
  [field setClearButtonMode:UITextFieldViewModeWhileEditing];
  
  self.pswField = field;
  [self.view addSubview:field];
  
  CGFloat seperY = CGRectGetMaxY(field.frame) - SEPER_MINUS_TOP_MARGIN;
  UIView *seper = [[UIView alloc] initWithFrame:CGRectMake(NAME_FIELD_LEFT_MARGIN, seperY, width, 1)];
  [seper setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR]];
  
  self.pswSeper = seper;
  [self.view addSubview:seper];
}

- (void)configLoginButton
{
  CGFloat y = CGRectGetMaxY(self.pswSeper.frame) + LOGIN_TOP_MARGIN;
  UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, y, LOGIN_WIDTH, LOGIN_HEIGHT)];
  [button setTitle:TEXT_LOGIN forState:UIControlStateNormal];
  [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [button setTitleColor:[UIConfiguration colorForHex:GLOBAL_BUTTON_TITLE_PRESSED] forState:UIControlStateHighlighted];
  [button.titleLabel setFont:[UIFont systemFontOfSize:15]];
  [button setBackgroundImage:[UIConfiguration imageForColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR]]
                    forState:UIControlStateNormal];
  [button setBackgroundImage:[UIConfiguration imageForColor:[UIColor lightGrayColor]]
                    forState:UIControlStateHighlighted];
  [UIConfiguration moveSubviewXToSuperviewCenter:self.view subview:button];
  
  self.loginButton = button;
  [self.view addSubview:button];
}

- (void)cancelButtonPressed
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
 {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
