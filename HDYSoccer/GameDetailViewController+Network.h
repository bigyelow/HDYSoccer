//
//  GameDetailViewController+Network.h
//  HDYSoccer
//
//  Created by bigyelow on 6/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GameDetailViewController.h"

@interface GameDetailViewController (Network)

- (void)loadTags;
- (void)loadGameInfoWithGameID:(NSString *)gameID
                      gameType:(GameType)gameType;
- (void)ratePlayerWithPlayerID:(NSString *)playerID
                         score:(NSString *)score
                          tags:(NSString *)tags
                      hasScore:(BOOL)hasScore;
@end
