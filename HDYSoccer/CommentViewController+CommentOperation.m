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
  [self.tableView setContentInset:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, COMMENT_BACK_HEIGHT, 0)];
  [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, COMMENT_BACK_HEIGHT, 0)];
  
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
                                                  name:UIKeyboardWillShowNotification
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
  CGFloat commentY = self.view.bounds.size.height - keyboardRect.size.height - self.commentView.frame.size.height;
  
  NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
  UIViewAnimationCurve option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
  
  // animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationDuration:duration];
  [UIView setAnimationCurve:option];
  
  [UIConfiguration setView:self.commentView y:commentY];
  
  // commit
  [UIView commitAnimations];
  
  [self setIsKeyboardShowed:YES];
  
  // update tableview UI
  CGFloat commentViewHeight = keyboardRect.size.height + self.commentView.frame.size.height;
  [self.tableView setContentInset:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, commentViewHeight, 0)];
  [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, commentViewHeight, 0)];
  
  // Gesture
  BOOL shouldAddTapGest = YES;
  for (UIGestureRecognizer *gest in self.tableView.gestureRecognizers) {
    if ([gest isKindOfClass:[UITapGestureRecognizer class]])  {
      shouldAddTapGest = NO;
      break;
    }
  }
  if (shouldAddTapGest) {
    UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tableViewTapped:)];
    [self.tableView addGestureRecognizer:gest];
  }
}

- (void)keyboardWillHide:(NSNotification *)notification
{
  CGFloat commentY = self.view.bounds.size.height - self.commentView.frame.size.height;
  
  NSTimeInterval duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
  UIViewAnimationCurve option = [notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue];
  
  // animations settings
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
  [UIView setAnimationDuration:duration];
  [UIView setAnimationCurve:option];
  
  [UIConfiguration setView:self.commentView y:commentY];
  
  // update tableview UI
  CGFloat commentViewHeight = self.commentView.frame.size.height;
  [self.tableView setContentInset:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, commentViewHeight, 0)];
  [self.tableView setScrollIndicatorInsets:UIEdgeInsetsMake(TOP_BAR_HEIGHT, 0, commentViewHeight, 0)];
  
  [self.commentView.textView setPlaceholder:TEXT_ADD_COMMENT];
  
  // commit
  [UIView commitAnimations];
  
  [self setIsKeyboardShowed:NO];
  [self setIsReply:NO];
  
  NSInteger gestCount = [self.tableView.gestureRecognizers count];
  if (gestCount) {
    [self.tableView removeGestureRecognizer:[self.tableView.gestureRecognizers lastObject]];
  }
}
@end
