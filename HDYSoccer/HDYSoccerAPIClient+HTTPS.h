//
//  HDYSoccerAPIClient+HTTPS.h
//  HDYSoccer
//
//  Created by bigyelow on 6/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerAPIClient.h"

@interface HDYSoccerAPIClient (HTTPS)

#pragma mark - user management operations
- (void)registerWithEmail:(NSString *)email
                    phone:(NSString *)phone
                 password:(NSString *)psw
                succeeded:(SucceededGettingJsonStringBlock)succeeded
                   failed:(FailedBlock)failed;
- (void)loginWithUserName:(NSString *)name
                   passwd:(NSString *)psw
                succeeded:(SucceededGettingJsonStringBlock)succeeded
                   failed:(FailedBlock)failed;
@end
