//
//  CommentViewController+Network.m
//  HDYSoccer
//
//  Created by bigyelow on 8/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CommentViewController+Network.h"
#import "HDYSoccerAPIClient+HTTP.h"
#import "Comment.h"
#import "Reply.h"

#define LOAD_MAX_LIMIT 40

@implementation CommentViewController (Network)

- (void)loadGameCommentsWithGameType:(GameType)gameType
                              gameID:(NSString *)gameID
{
  __weak typeof(self) weakSelf = self;
  if (gameType == kGameTypePersonal) {
    
    [UIConfiguration showTipMessageToView:self.view];
    [self.httpsClient getPersonalGameCommentsWithGameID:gameID
                                                  start:0
                                                  count:LOAD_MAX_LIMIT
                                              succeeded:^(NSArray *array) {
                                                [UIConfiguration hideTipMessageOnView:weakSelf.view];
                                                
                                                [weakSelf loadTableViewWithComments:array];
                                              } failed:^(HDYSoccerAPIError *error) {
                                                [UIConfiguration hideTipMessageOnView:weakSelf.view];

                                              }];
  }
  else if (gameType == kGameTypeTeam) {
    [UIConfiguration showTipMessageToView:self.view];
    [self.httpsClient getTeamGameCommentsWithGameID:gameID
                                              start:0
                                              count:LOAD_MAX_LIMIT
                                          succeeded:^(NSArray *array) {
                                            [UIConfiguration hideTipMessageOnView:weakSelf.view];
                                            
                                            [weakSelf loadTableViewWithComments:array];
                                          } failed:^(HDYSoccerAPIError *error) {
                                            [UIConfiguration hideTipMessageOnView:weakSelf.view];

                                          }];
  }
}

- (void)loadTableViewWithComments:(NSArray *)comments
{
  self.commentsArray = [comments copy];
  [self configSomeParams];
  [self.tableView reloadData];
  [self.tableView setHidden:NO];
}

// self.cellHeightArray[i][0]:为第i条评论的高度
// self.cellHeightArray[i][j]:为第i调评论的第j-1条回复的高度
- (void)configSomeParams
{
  self.cellHeightArray = [NSMutableArray array];
  for (Comment *comment in self.commentsArray) {
    NSMutableArray *tempArray = [NSMutableArray array];
    [tempArray addObject:[NSNumber numberWithFloat:0]];
    
    for (int i = 0; i < [comment.replys count]; ++i) {
      [tempArray addObject:[NSNumber numberWithFloat:0]];
    }
    
    [self.cellHeightArray addObject:tempArray];
  }
}
@end
