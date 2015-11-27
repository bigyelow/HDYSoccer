//
//  CPTransitionAnimator.m
//  HDYSoccer
//
//  Created by bigyelow on 8/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CPTransitionAnimator.h"

@implementation CPTransitionAnimator

- (NSTimeInterval)transitionDuration:(id <UIViewControllerContextTransitioning>)transitionContext
{
  return 0.4;
}

- (void)animateTransition:(id <UIViewControllerContextTransitioning>)transitionContext
{
  UIViewController *fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
  UIViewController *toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
  
  CGRect endFrame = CPTRANSITION_ENDFRAME;
  
  if (self.presenting) {
    fromViewController.view.userInteractionEnabled = NO;

    [transitionContext.containerView addSubview:toViewController.view];
    
    CGRect startFrame = endFrame;
    startFrame.origin.x += (WINDOW_FRAME.size.width - CPTRANSITION_ENDFRAME_X);
    
    toViewController.view.frame = startFrame;
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
      fromViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeDimmed;
      toViewController.view.frame = endFrame;
    } completion:^(BOOL finished) {
      [transitionContext completeTransition:YES];
    }];
  }
  else {
    toViewController.view.userInteractionEnabled = YES;

    endFrame.origin.x += (WINDOW_FRAME.size.width - CPTRANSITION_ENDFRAME_X);
    
    [UIView animateWithDuration:[self transitionDuration:transitionContext] animations:^{
      toViewController.view.tintAdjustmentMode = UIViewTintAdjustmentModeAutomatic;
      fromViewController.view.frame = endFrame;
    } completion:^(BOOL finished) {
      [transitionContext completeTransition:YES];
    }];
  }
}

@end
