//
//  BouncePresentAnimation.m
//  HDYSoccer
//
//  Created by XueMing on 11/27/15.
//  Copyright © 2015 bigyelow. All rights reserved.
//

#import "BouncePresentAnimation.h"

@implementation BouncePresentAnimation

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
  return 0.8;
}

- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
  // 1. Get controllers from transition context
  UIViewController *toVC = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];

  // 2. Set init frame for toVC
  CGRect screenBounds = [[UIScreen mainScreen] bounds];
  CGRect finalFrame = [transitionContext finalFrameForViewController:toVC];
  toVC.view.frame = CGRectOffset(finalFrame, 0, screenBounds.size.height);

  // 3. Add toVC's view to containerView
  UIView *containerView = [transitionContext containerView];
  [containerView addSubview:toVC.view];

  // 4. Do animate now
  NSTimeInterval duration = [self transitionDuration:transitionContext];
  [UIView animateWithDuration:duration
                        delay:0.0
       usingSpringWithDamping:0.6
        initialSpringVelocity:0.0
                      options:UIViewAnimationOptionCurveLinear
                   animations:^{
                     toVC.view.frame = finalFrame;
                   } completion:^(BOOL finished) {
                     // 5. Tell context that we completed.
                     [transitionContext completeTransition:YES];
                   }];
}

@end
