//
//  AppDelegate+LogicTest.m
//  HDYSoccer
//
//  Created by bigyelow on 6/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "AppDelegate+LogicTest.h"
#import "HDYSoccerAPIClient+HTTPS.h"
#import "AppContext.h"

@implementation AppDelegate (LogicTest)

- (void)testRegister
{
  HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];
  
  NSString *email = @"duyu1010@163.com";
  NSString *psw = @"mdafasdfa";
  NSString *phone = @"12319012391";

  [client registerWithEmail:email
                      phone:phone
                   password:psw
                  succeeded:^(NSString *jsonString) {
                    
                    Authorization *auth = [[Authorization alloc] initWithString:jsonString error:nil];
                    [[AppContext appContext] updateInfoWithAuth:auth];
                    
                  } failed:^(HDYSoccerAPIError *error) {
                    
                  }];
}

- (void)testLogin
{
  HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];
  
  NSString *userName = @"bigyelow";
  NSString *passwd = @"mmkdas;f";
  
  [client loginWithUserName:userName
                     passwd:passwd
                  succeeded:^(NSString *jsonString) {
                    
                    Authorization *auth = [[Authorization alloc] initWithString:jsonString error:nil];
                    [[AppContext appContext] updateInfoWithAuth:auth];
                    
                  } failed:^(HDYSoccerAPIError *error) {

                  }];
}

- (void)testLogout
{
  [[AppContext appContext] clearInfo];
}
@end
