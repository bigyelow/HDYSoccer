//
//  HDYSoccerGeekerDetailViewController+NetworkOperation.m
//  HDYSoccer
//
//  Created by bigyelow on 8/13/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerDetailViewController+NetworkOperation.h"
#import "HDYSoccerAPIClient+HTTP.h"
#import "Geeker.h"

@implementation HDYSoccerGeekerDetailViewController (NetworkOperation)

- (void)loadPlayerInfoWithPlayerID:(NSString *)playerID
{
  __weak typeof(self) weakSelf = self;
  
  [UIConfiguration showTipMessageToView:self.view title:TEXT_LOADING];
  [self.httpsClient getGeekerInfoWithGeekerID:playerID
                                   succeeded:^(NSDictionary *dictionary) {
                                     [UIConfiguration hideTipMessageOnView:weakSelf.view];
                                     
                                     weakSelf.playerInfo = [Geeker objectWithDictionary:dictionary];
                                     [weakSelf.playerInfoTable reloadData];
                                   } failed:^(HDYSoccerAPIError *error) {
                                     [UIConfiguration hideTipMessageOnView:weakSelf.view];

                                   }];
}
@end
