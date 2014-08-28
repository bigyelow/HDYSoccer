//
//  CommentViewController+Network.m
//  HDYSoccer
//
//  Created by bigyelow on 8/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CommentViewController+Network.h"
#import "HDYSoccerAPIClient+HTTP.h"
#import "HDYSoccerAPIClient+HTTPS.h"
#import "Comment.h"
#import "Reply.h"
#import "CommentViewController+CommentOperation.h"
#import "SVPullToRefresh.h"

@implementation CommentViewController (Network)

#pragma mark - load comments

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
  self.commentsArray = [comments mutableCopy];
  [self configSomeParams];
  [self.tableView reloadData];
  [self.tableView setHidden:NO];
  
  // load comment view
  [self configCommentView];
}

// self.cellHeightArray[i][0]:为第i条评论的高度
// self.cellHeightArray[i][j]:为第i调评论的第j-1条回复的高度
- (void)configSomeParams
{
  self.commentStart = [self.commentsArray count];

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

- (void)loadMoreCommentsWithGameType:(GameType)gameType
                              gameID:(NSString *)gameID
                               start:(NSInteger)start
                               count:(NSInteger)count
{
  __weak typeof(self) weakSelf = self;
  if (gameType == kGameTypePersonal) {
    [self.httpsClient getPersonalGameCommentsWithGameID:gameID
                                                  start:self.commentStart
                                                  count:LOAD_MAX_LIMIT
                                              succeeded:^(NSArray *array) {
                                                [weakSelf.tableView.infiniteScrollingView stopAnimating];
                                                
                                                [weakSelf updateTableViewWithComments:array];
                                              } failed:^(HDYSoccerAPIError *error) {
                                                [weakSelf.tableView.infiniteScrollingView stopAnimating];

                                              }];
  }
  else if (gameType == kGameTypeTeam) {
    [self.httpsClient getTeamGameCommentsWithGameID:gameID
                                              start:self.commentStart
                                              count:LOAD_MAX_LIMIT
                                          succeeded:^(NSArray *array) {
                                            [weakSelf.tableView.infiniteScrollingView stopAnimating];

                                            [weakSelf updateTableViewWithComments:array];
                                          } failed:^(HDYSoccerAPIError *error) {
                                            [weakSelf.tableView.infiniteScrollingView stopAnimating];

                                          }];
  }
}

- (void)updateTableViewWithComments:(NSArray *)comments
{
  if ([Tools isNilOrEmptyArray:comments])
    return;
  
  [self.commentsArray addObjectsFromArray:comments];
  
  // config cell height array
  for (Comment *comment in comments) {
    NSMutableArray *tempArray = [NSMutableArray array];
    [tempArray addObject:[NSNumber numberWithFloat:0]];
    
    for (int i = 0; i < [comment.replys count]; ++i) {
      [tempArray addObject:[NSNumber numberWithFloat:0]];
    }
    
    [self.cellHeightArray addObject:tempArray];
  }
  
  [self.tableView beginUpdates];
  NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.commentStart, [comments count])];
  [self.tableView insertSections:set withRowAnimation:UITableViewRowAnimationFade];
  [self.tableView endUpdates];
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:self.commentStart];
  
  __weak typeof(self) weakSelf = self;
  [UIView animateWithDuration:0.5 animations:^{
    [weakSelf.tableView scrollToRowAtIndexPath:indexPath
                          atScrollPosition:UITableViewScrollPositionMiddle
                                  animated:NO];
  }];
  
  
  self.commentStart = [self.commentsArray count];
}

#pragma mark - send comment
- (void)sendCommentWithGameType:(GameType)gameType
                         gameID:(NSString *)gameID
                        content:(NSString *)content
{
  __weak typeof(self) weakSelf = self;
  if (gameType == kGameTypePersonal) {
    [UIConfiguration showTipMessageToView:self.view title:TEXT_SENDING];
    [self.httpsClient sendCommentToPersonalGame:gameID
                                        Content:content
                                      succeeded:^(NSDictionary *dictionary) {
                                        
                                        Comment *comment = [Comment objectWithDictionary:dictionary];
                                        [weakSelf updateTableViewWithNewComment:comment];
                                        
                                        [UIConfiguration hideTipMessageOnView:weakSelf.view];
                                      } failed:^(HDYSoccerAPIError *error) {
                                        [UIConfiguration hideTipMessageOnView:weakSelf.view];

                                      }];
  }
  else if (gameType == kGameTypeTeam) {
    [UIConfiguration showTipMessageToView:self.view title:TEXT_SENDING];
    [self.httpsClient sendCommentToTeamGame:gameID
                                    Content:content
                                  succeeded:^(NSDictionary *dictionary) {
                                    
                                    Comment *comment = [Comment objectWithDictionary:dictionary];
                                    [weakSelf updateTableViewWithNewComment:comment];
                                    
                                    [UIConfiguration hideTipMessageOnView:weakSelf.view];
                                  } failed:^(HDYSoccerAPIError *error) {
                                    [UIConfiguration hideTipMessageOnView:weakSelf.view];

                                  }];
  }
  
}

- (void)updateTableViewWithNewComment:(Comment *)comment
{
  if (!comment) {
    return;
  }
  
  [self.commentsArray insertObject:comment atIndex:0];
  
  // config cell height array
  NSMutableArray *tempArray = [NSMutableArray array];
  [tempArray addObject:[NSNumber numberWithFloat:0]];
  
  for (int i = 0; i < [comment.replys count]; ++i) {
    [tempArray addObject:[NSNumber numberWithFloat:0]];
  }
  [self.cellHeightArray insertObject:tempArray atIndex:0];
  
  self.commentStart = [self.commentsArray count];
  
  [self.tableView reloadData];
  
  NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
  [self.tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
}

#pragma mark - send reply

- (void)sendRelplyWithGameType:(GameType)gameType
                        gameID:(NSString *)gameID
                     commentID:(NSString *)commentID
                       content:(NSString *)content
{
  __weak typeof(self) weakSelf = self;
  if (gameType == kGameTypePersonal) {
    [UIConfiguration showTipMessageToView:self.view title:TEXT_SENDING];
    [self.httpsClient sendReplyToPersonalGame:gameID
                                    commentID:commentID
                                      content:content
                                    succeeded:^(NSDictionary *dictionary) {
                                      
                                      Comment *comment = [Comment objectWithDictionary:dictionary];
                                      [weakSelf updateTableViewAfterReply:comment];
                                      
                                      [UIConfiguration hideTipMessageOnView:weakSelf.view];
                                      
                                    } failed:^(HDYSoccerAPIError *error) {
                                      [UIConfiguration hideTipMessageOnView:weakSelf.view];
                                    }];
  }
  else if (gameType == kGameTypeTeam) {
    [UIConfiguration showTipMessageToView:self.view title:TEXT_SENDING];
    [self.httpsClient sendReplyToTeamGame:gameID
                                commentID:commentID
                                  content:content
                                succeeded:^(NSDictionary *dictionary) {
                                  
                                  Comment *comment = [Comment objectWithDictionary:dictionary];
                                  [weakSelf updateTableViewAfterReply:comment];
                                  
                                  [UIConfiguration hideTipMessageOnView:weakSelf.view];
                                  
                                } failed:^(HDYSoccerAPIError *error) {
                                  [UIConfiguration hideTipMessageOnView:weakSelf.view];
                                }];
  }
}

- (void)updateTableViewAfterReply:(Comment *)comment
{
  if (!comment)
    return;
  
  
  [self.commentsArray replaceObjectAtIndex:self.selectedCommentIndex withObject:comment];

  // config cell height array
  NSMutableArray *tempArray = [NSMutableArray array];
  [tempArray addObject:[NSNumber numberWithFloat:0]];
  
  for (int i = 0; i < [comment.replys count]; ++i) {
    [tempArray addObject:[NSNumber numberWithFloat:0]];
  }
  [self.cellHeightArray replaceObjectAtIndex:self.selectedCommentIndex withObject:tempArray];
  
  NSIndexSet *set = [NSIndexSet indexSetWithIndexesInRange:NSMakeRange(self.selectedCommentIndex, 1)];
  [self.tableView reloadSections:set withRowAnimation:UITableViewRowAnimationFade];
}

@end
