//
//  HDYSoccerGeekerDetailViewController+RateView.h
//  HDYSoccer
//
//  Created by bigyelow on 9/2/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerDetailViewController.h"

@interface HDYSoccerGeekerDetailViewController (RateView)

@property (nonatomic, copy) NSString *selectedAbilityName;
@property (nonatomic, assign) NSInteger selectedAbilityScore;

- (void)showRateViewWithAbilityName:(NSString *)name
                              score:(NSInteger)score;
@end
