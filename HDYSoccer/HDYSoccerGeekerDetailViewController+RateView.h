//
//  HDYSoccerGeekerDetailViewController+RateView.h
//  HDYSoccer
//
//  Created by bigyelow on 9/2/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerDetailViewController.h"
#import "AppDelegate+Configuration.h"

@interface HDYSoccerGeekerDetailViewController (RateView)
<RegisterAndLoginDelegate>

- (void)showRateViewWithAbilityName:(NSString *)name
                              score:(NSInteger)score
                          indexPath:(NSIndexPath *)indexPath;
@end
