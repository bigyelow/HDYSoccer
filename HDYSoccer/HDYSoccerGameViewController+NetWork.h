//
//  HDYSoccerGameViewController+NetWork.h
//  HDYSoccer
//
//  Created by bigyelow on 6/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameViewController.h"

@interface HDYSoccerGameViewController (NetWork)

- (void)loadGameListWithSegIndex:(NSInteger)segIndex
                            time:(NSString *)time
                           field:(NSString *)field
                           start:(NSInteger)start;
- (void)loadMoreGameListWithSegIndex:(NSInteger)segIndex
                                time:(NSString *)time
                               field:(NSString *)field
                               start:(NSInteger)start;
@end
