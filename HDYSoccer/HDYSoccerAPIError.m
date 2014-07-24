//
//  HDYSoccerError.m
//  HDYSoccer
//
//  Created by bigyelow on 5/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerAPIError.h"

@implementation HDYSoccerAPIError

#warning todo - convert NSError
+ (HDYSoccerAPIError *)convertNSError:(NSError *)error
{
  HDYSoccerAPIError *apiError = [[HDYSoccerAPIError alloc] initWithNSErr:error];
  return apiError;
}

- (HDYSoccerAPIError *)initWithNSErr:(NSError *)error
{
  self = [super init];
  if (self) {
    self.errorCode = [self errorCodeForError:error];
    self.errorMsg = [self errorMsgForCode:error];
  }
  
  return self;
}

- (NSString *)errorMsgForCode:(NSError *)error
{
  return @"";
}

- (NSInteger)errorCodeForError:(NSError *)error
{
  return error.code;
}

@end
