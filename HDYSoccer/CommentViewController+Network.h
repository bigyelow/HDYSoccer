//
//  CommentViewController+Network.h
//  HDYSoccer
//
//  Created by bigyelow on 8/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CommentViewController.h"

#define LOAD_MAX_LIMIT 40

@interface CommentViewController (Network)

- (void)loadGameCommentsWithGameType:(GameType)gameType
                              gameID:(NSString *)gameID;
- (void)loadMoreCommentsWithGameType:(GameType)gameType
                              gameID:(NSString *)gameID
                               start:(NSInteger)start
                               count:(NSInteger)count;
- (void)sendCommentWithGameType:(GameType)gameType
                         gameID:(NSString *)gameID
                        content:(NSString *)content;
- (void)sendRelplyWithGameType:(GameType)gameType
                        gameID:(NSString *)gameID
                     commentID:(NSString *)commentID
                       content:(NSString *)content;
@end
