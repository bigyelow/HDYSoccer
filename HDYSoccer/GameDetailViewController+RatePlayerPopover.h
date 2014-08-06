//
//  GameDetailViewController+RatePlayerPopover.h
//  HDYSoccer
//
//  Created by bigyelow on 8/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GameDetailViewController.h"
@class ParticipantsScore;

@interface GameDetailViewController (RatePlayerPopover)
- (void)showRatePopoverWithPlayerInfo:(ParticipantsScore *)info;
@end
