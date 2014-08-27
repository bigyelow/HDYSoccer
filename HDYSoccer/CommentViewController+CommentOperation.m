//
//  CommentViewController+CommentOperation.m
//  HDYSoccer
//
//  Created by bigyelow on 8/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CommentViewController+CommentOperation.h"
#import "CommentField.h"

@implementation CommentViewController (CommentOperation)

- (void)configCommentView
{
  // update tableview UI
  [self.tableView setContentInset:UIEdgeInsetsMake(COMMENT_BACK_HEIGHT, 0, COMMENT_BACK_HEIGHT, 0)];
  [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, COMMENT_BACK_HEIGHT, 0)];
  
  // Comment view
  CGFloat commentY = self.view.bounds.size.height - COMMENT_BACK_HEIGHT;
  CommentField *commentView = [[CommentField alloc] initWithFrame:CGRectMake(0, commentY, self.view.bounds.size.width, COMMENT_BACK_HEIGHT)];
  [self.view addSubview:commentView];
}
@end
