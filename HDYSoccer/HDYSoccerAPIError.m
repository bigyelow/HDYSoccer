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
  HDYSoccerAPIError *apiError = [super init];
  return apiError;
}

@end
