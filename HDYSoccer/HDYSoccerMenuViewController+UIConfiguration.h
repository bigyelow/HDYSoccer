//
//  HDYSoccerMenuViewController+UIConfiguration.h
//  HDYSoccer
//
//  Created by bigyelow on 3/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerMenuViewController.h"
#import "RegisterAndLoginViewController.h"

@interface HDYSoccerMenuViewController (UIConfiguration) <RegisterAndLoginDelegate>

- (void)configTableView;
- (void)configTableHeaderView;
@end
