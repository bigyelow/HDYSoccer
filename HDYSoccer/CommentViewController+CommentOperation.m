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
  
  UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTapped:)];
  [self.tableView addGestureRecognizer:gest];
  
  // Comment view
  CGFloat commentY = self.view.bounds.size.height - COMMENT_BACK_HEIGHT;
  CommentField *commentView = [[CommentField alloc] initWithFrame:CGRectMake(0, commentY, self.view.bounds.size.width, COMMENT_BACK_HEIGHT)];
  
  self.commentView = commentView;
  [self.view addSubview:commentView];
}

#pragma mark - Keyboard related
- (void)registerKeyboardNotification
{
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillHide:)
                                               name:UIKeyboardWillHideNotification
                                             object:nil];
  [[NSNotificationCenter defaultCenter] addObserver:self
                                           selector:@selector(keyboardWillShow:)
                                               name:UIKeyboardWillShowNotification
                                             object:nil];
}

- (void)unregisterKeyboardNotification
{
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardWillHideNotification
                                                object:nil];
  [[NSNotificationCenter defaultCenter] removeObserver:self
                                                  name:UIKeyboardDidShowNotification
                                                object:nil];
}

- (void)tableViewTapped:(UITapGestureRecognizer *)gest
{
  if (self.isKeyboardShowed && [self.commentView.textView isFirstResponder]) {
    [self.commentView.textView resignFirstResponder];
  }
}

- (void)keyboardWillShow:(NSNotification *)notification
{
  CGRect keyboardRect = [[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue];
  CGFloat commentY = self.view.bounds.size.height - keyboardRect.size.height - COMMENT_BACK_HEIGHT;
  
  NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
  UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
  
  __weak typeof(self) weakSelf = self;
  [UIView animateWithDuration:duration
                        delay:0
                      options:option
                   animations:^{
                     [UIConfiguration setView:weakSelf.commentView y:commentY];
                   } completion:^(BOOL finished) {
                     weakSelf.isKeyboardShowed = YES;
                   }];

  
  // COMMENT
  if (!self.isReply) {

  }
  // REPLY
  else {
  
  }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
  CGFloat commentY = self.view.bounds.size.height - COMMENT_BACK_HEIGHT;
  
  NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
  UIViewAnimationOptions option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
  
  __weak typeof(self) weadSelf = self;
  [UIView animateWithDuration:duration
                        delay:0
                      options:option
                   animations:^{
                     [UIConfiguration setView:weadSelf.commentView y:commentY];
                   } completion:^(BOOL finished) {
                     weadSelf.isKeyboardShowed = NO;
                   }];
}
@end
