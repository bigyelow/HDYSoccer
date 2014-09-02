//
//  HDYSoccerGeekerDetailViewController+RateView.m
//  HDYSoccer
//
//  Created by bigyelow on 9/2/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerDetailViewController+RateView.h"

#define FRONT_VIEW_LEFT_MARGIN 0.0F
#define FRONT_VIEW_HEIGHT 260

NSString *_selectedAbilityName;
NSInteger _selectedAbilityScore;

@implementation HDYSoccerGeekerDetailViewController (RateView)

- (void)showRateViewWithAbilityName:(NSString *)name
                              score:(NSInteger)score
{
  self.selectedAbilityName = name;
  self.selectedAbilityScore = score;
  
  [self createRateView];
  [self showRateFrontViewWithAnimation];
}

- (void)createRateView
{
  if (!self.rateBackgroundView) {
    UIView *view = [[UIView alloc] initWithFrame:self.view.bounds];
    [view setBackgroundColor:[UIColor blackColor]];
    [view setAlpha:0.5];
    [view setHidden:YES];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(handleRateBackgroundTap:)];
    tap.cancelsTouchesInView = NO;
    [view addGestureRecognizer:tap];
    
    self.rateBackgroundView = view;
    [self.view addSubview:self.rateBackgroundView];
  }
  if (!self.rateFrontView) {
    UIView *view = [[UIView alloc] initWithFrame:CGRectZero];
    [view setBackgroundColor:[UIColor whiteColor]];
    [view.layer setCornerRadius:8.0];
    [view setHidden:YES];
    
    self.rateFrontView = view;
    [self.view addSubview:view];
  }
}

- (void)handleRateBackgroundTap:(UITapGestureRecognizer *)tapGR
{
  [self cancelButtonPressed];
}

- (void)cancelButtonPressed
{
  [self.rateBackgroundView removeFromSuperview];
  [self.rateFrontView removeFromSuperview];
  
  self.rateFrontView = nil;
  self.rateBackgroundView = nil;
}

- (void)showRateFrontViewWithAnimation
{
  [self.rateBackgroundView setHidden:NO];
  [self.rateFrontView setHidden:NO];
  
  // init
  CGPoint initOrigin = self.view.center;
  [UIConfiguration setView:self.rateFrontView origin:initOrigin];
  
  // end
  CGFloat endWidth = self.view.frame.size.width - 2 * FRONT_VIEW_LEFT_MARGIN;
  CGFloat endHeight = FRONT_VIEW_HEIGHT;
  CGFloat endX = FRONT_VIEW_LEFT_MARGIN;
  CGFloat endY = (self.view.frame.size.height - endHeight) / 2;
  
  __weak typeof(self) weakSelf = self;
  [UIView animateWithDuration:0.25
                        delay:0
                      options:UIViewAnimationOptionCurveEaseIn
                   animations:^{
                     CGRect endRect = CGRectMake(endX, endY, endWidth, endHeight);
                     [weakSelf.rateFrontView setFrame:endRect];
                   }
                   completion:^(BOOL finished) {
                     [weakSelf configRateFrontViewWithAbilityName:weakSelf.selectedAbilityName score:weakSelf.selectedAbilityScore];
                     
                     // bottom layer
                     [weakSelf.rateFrontView.layer setShadowColor:[UIColor blackColor].CGColor];
                     [weakSelf.rateFrontView.layer setShadowOpacity:0.5];
                     [weakSelf.rateFrontView.layer setShadowOffset:
                      CGSizeMake(0, 8.0f)];
                     [weakSelf.rateFrontView.layer setShadowRadius:14.0f];
                     [weakSelf.rateFrontView.layer setMasksToBounds:NO];
                   }];
  
}

- (void)configRateFrontViewWithAbilityName:(NSString *)name
                                     score:(NSInteger)score
{
  // cancel button
  UIButton *cancelButton = [self topButtonWithImageName:TOP_CANCEL_IMAGE];
  [UIConfiguration setView:cancelButton size:CGSizeMake(TOP_CANCEL_BUTTON_WIDTH, TOP_CANCEL_BUTTON_WIDTH)];
  [UIConfiguration setView:cancelButton origin:CGPointMake(7, 7)];
  [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  [self.rateFrontView addSubview:cancelButton];
}

#pragma mark - get and set
- (NSInteger)selectedAbilityScore
{
  return _selectedAbilityScore;
}

- (void)setSelectedAbilityScore:(NSInteger)score
{
  _selectedAbilityScore = score;
}

- (NSString *)selectedAbilityName
{
  return _selectedAbilityName;
}

- (void)setSelectedAbilityName:(NSString *)name
{
  _selectedAbilityName = name;
}

@end
