//
//  HDYSoccerError.h
//  HDYSoccer
//
//  Created by bigyelow on 5/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HDYSoccerAPIError : NSObject

+ (HDYSoccerAPIError *)convertNSError:(NSError *)error;
@end
