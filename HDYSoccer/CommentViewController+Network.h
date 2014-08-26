//
//  CommentViewController+Network.h
//  HDYSoccer
//
//  Created by bigyelow on 8/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CommentViewController.h"

@interface CommentViewController (Network)

- (void)loadGameCommentsWithGameType:(GameType)gameType
                              gameID:(NSString *)gameID;
@end
