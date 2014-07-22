//
//  HDYSoccerBaseViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class HDYSoccerAPIClient;

@interface HDYSoccerBaseViewController : UIViewController

@property (nonatomic, strong) HDYSoccerAPIClient *httpClient;
@property (nonatomic, strong) HDYSoccerAPIClient *httpsClient;

- (void)configTopMenuButton;
@end
