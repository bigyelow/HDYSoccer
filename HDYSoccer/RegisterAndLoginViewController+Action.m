//
//  RegisterAndLoginViewController+Action.m
//  HDYSoccer
//
//  Created by bigyelow on 8/22/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "RegisterAndLoginViewController+Action.h"
#import "PSPDFAlertView.h"
#import "HDYSoccerAPIClient+HTTPS.h"

#define LOGIN_EMPTY_ALERT @"用户名不能为空"
#define PSW_EMPTY_ALERT @"密码不能为空"

@implementation RegisterAndLoginViewController (Action)

- (void)loginPressed
{
  if ([Tools isNilOrEmpty:self.userNameField.text]) {
    PSPDFAlertView *alert = [[PSPDFAlertView alloc] initWithTitle:nil message:LOGIN_EMPTY_ALERT];
    [alert setCancelButtonWithTitle:TEXT_I_SEE block:nil];
    
    [alert show];
    return;
  }
  else if ([Tools isNilOrEmpty:self.pswField.text]) {
    PSPDFAlertView *alert = [[PSPDFAlertView alloc] initWithTitle:nil message:PSW_EMPTY_ALERT];
    [alert setCancelButtonWithTitle:TEXT_I_SEE block:nil];
    
    [alert show];
    return;
  }
  
  [self loginWithUserName:self.userNameField.text psw:self.pswField.text];
}

- (void)loginWithUserName:(NSString *)userName
                      psw:(NSString *)psw
{
  __weak typeof(self) weakSelf = self;
  [UIConfiguration showTipMessageToView:self.view title:TEXT_LOGIN_ING];
  [self.httpsClient loginWithUserName:userName
                               passwd:psw
                            succeeded:^(NSDictionary *dictionary) {
                              [UIConfiguration hideTipMessageOnView:weakSelf.view];
                              
                              Authorization *auth = [Authorization objectWithDictionary:dictionary];
                              [[AppContext appContext] updateInfoWithAuth:auth];
                              
                              [weakSelf loginSucceeded];
                            } failed:^(HDYSoccerAPIError *error) {
                              [UIConfiguration hideTipMessageOnView:weakSelf.view];

                            }];
}

- (void)registerPressed
{

}

#pragma mark - login event
- (void)loginSucceeded
{
  if (self.regLogDelegate && [self.regLogDelegate respondsToSelector:@selector(loginSucceeded:)]) {
    [self.regLogDelegate loginSucceeded:self];
  }
}
@end
