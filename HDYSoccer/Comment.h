//
//  Comment.h
//  HDYSoccer
//
//  Created by bigyelow on 8/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "BaseObject.h"

@interface Comment : BaseObject

@property (nonatomic, copy) NSString *commentID;
@property (nonatomic, copy) NSString *userName;
@property (nonatomic, copy) NSString *userID;
@property (nonatomic, copy) NSString *content;
@property (nonatomic, strong) NSDate *time;
@property (nonatomic, strong) NSArray *replys;
@end
