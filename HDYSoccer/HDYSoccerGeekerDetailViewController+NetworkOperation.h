//
//  HDYSoccerGeekerDetailViewController+NetworkOperation.h
//  HDYSoccer
//
//  Created by bigyelow on 8/13/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerDetailViewController.h"

@interface HDYSoccerGeekerDetailViewController (NetworkOperation)
- (void)loadPlayerInfoWithPlayerID:(NSString *)playerID;
- (void)configAbilityArrayWithPlayerInfo:(Geeker *)playerInfo;
@end
