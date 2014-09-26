//
//  HDYSoccerGeekerDetailViewController+RateView.m
//  HDYSoccer
//
//  Created by bigyelow on 9/2/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerDetailViewController+RateView.h"
#import "HDYSoccerGeekerDetailViewController+NetworkOperation.h"
#import "Geeker.h"
#import "GeekerAbility.h"

#import "AppDelegate+Configuration.h"
#import "UICountingLabel.h"
#import "UILabel+Customize.h"
#import "PSPDFAlertView.h"
#import "HDYSoccerAPIClient+HTTPS.h"

#define FRONT_VIEW_LEFT_MARGIN 20.0F
#define FRONT_VIEW_HEIGHT 200

// Title
#define TITLE_TOP_MARGIN 30
#define TITLE_LEFT_MARGIN 10

// Score bar
#define SCORE_BAR_TOP_MARGIN 10
#define SCORE_BAR_LEFT_MARGIN 10
#define SCORE_BAR_BACKGOURND_COLOR @"#DADADA"

// Score
#define SCORE_LEFT_MARGIN 10
#define SCORE_TOP_MARGIN 10
#define SCORE_RIGHT_MARGIN 10

// Stepper
#define STEPPER_TOP_MARGIN 20
#define STEPPER_LIMIT_VALUE 10

// Confirm button
#define CONFIRM_BUTTON_TOP_MARGIN 20
#define CONFIRM_BUTTON_HEIGHT 35
#define CONFIRM_BUTTON_WIDTH 80
#define CONFIRM_BUTTON_FONT_SIZE 18

NSString *_selectedAbilityName;
NSInteger _selectedAbilityScore;
CGFloat _scoreBarWidth;
UILabel *_scoreLabel;
UIView *_scoreBar;
NSInteger _rateScore;
NSIndexPath *_indexPath;

@implementation HDYSoccerGeekerDetailViewController (RateView)

- (void)showRateViewWithAbilityName:(NSString *)name
                              score:(NSInteger)score
                          indexPath:(NSIndexPath *)indexPath
{
  _selectedAbilityName = name;
  _selectedAbilityScore = score;
  _rateScore = _selectedAbilityScore;
  _indexPath = indexPath;
  
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
  
  // Title
  CGFloat titleY = CGRectGetMaxY(cancelButton.frame) + TITLE_TOP_MARGIN;
  UILabel *titleLable = [UIConfiguration labelWithText:name
                                             textColor:[UIColor blackColor]
                                                  font:[UIFont systemFontOfSize:17]
                                         numberOfLines:1];
  [UIConfiguration setView:titleLable origin:CGPointMake(TITLE_LEFT_MARGIN, titleY)];
  
  [self.rateFrontView addSubview:titleLable];
  
  // Score
  UILabel *scoreLabel = [[UILabel alloc] init];
  [scoreLabel configWithText:@"100" 
                   textColor:[self colorForScore:score]
                        font:[UIFont systemFontOfSize:15] 
               numberOfLines:1];
  [scoreLabel setText:[NSString stringWithFormat:@"%zd", score]];
  
  CGFloat scoreX = self.rateFrontView.bounds.size.width - SCORE_RIGHT_MARGIN - scoreLabel.bounds.size.width;
  [UIConfiguration setView:scoreLabel origin:CGPointMake(scoreX, titleY)];
  
  _scoreLabel = scoreLabel;
  [self.rateFrontView addSubview:scoreLabel];

  
  // Score bar
  CGFloat scorebarX = CGRectGetMaxX(titleLable.frame) + SCORE_BAR_LEFT_MARGIN;
  CGFloat scorebarWidth = self.rateFrontView.bounds.size.width - scorebarX - SCORE_LEFT_MARGIN - scoreLabel.bounds.size.width - SCORE_RIGHT_MARGIN;
  CGFloat scorebarHeight = titleLable.bounds.size.height;
  
  UIView *scoreBackView = [[UIView alloc] initWithFrame:CGRectMake(scorebarX, titleY, scorebarWidth, scorebarHeight)];
  [scoreBackView setBackgroundColor:[UIConfiguration colorForHex:SCORE_BAR_BACKGOURND_COLOR]];
  
  _scoreBarWidth = scorebarWidth;
  [self.rateFrontView addSubview:scoreBackView];
  
  CGFloat scoreFrontWidth =  (CGFloat)score / 100 * scorebarWidth;
  CGRect scoreFrontRect = CGRectMake(scorebarX, titleY, scoreFrontWidth, scorebarHeight);
  UIView *scoreFrontView = [[UIView alloc] initWithFrame:scoreFrontRect];
  [scoreFrontView setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR]];
  
  _scoreBar = scoreFrontView;
  [self.rateFrontView addSubview:scoreFrontView];
  
  // Stepper
  CGFloat stepperY = CGRectGetMaxY(titleLable.frame) + STEPPER_TOP_MARGIN;
  UIStepper *scoreStepper = [[UIStepper alloc] initWithFrame:CGRectMake(0, stepperY, 0, 0)];
  [scoreStepper setTransform:CGAffineTransformMakeScale(1.0, 0.8)];
  [scoreStepper setTintColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR]];
  [scoreStepper setValue:score];
  CGFloat maxValue = score + STEPPER_LIMIT_VALUE;
  if (maxValue > 100) {
    maxValue = 100;
  }
  CGFloat minValue = score - STEPPER_LIMIT_VALUE;
  if (minValue < 0) {
    minValue = 0;
  }
  [scoreStepper setMaximumValue:maxValue];
  [scoreStepper setMinimumValue:minValue];
  [scoreStepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventTouchUpInside];
  [UIConfiguration moveSubviewXToSuperviewCenter:self.rateFrontView subview:scoreStepper];
  
  [self.rateFrontView addSubview:scoreStepper];
  
  // Confirm button
  CGFloat confirmY = CGRectGetMaxY(scoreStepper.frame) + CONFIRM_BUTTON_TOP_MARGIN;
  UIButton *confirmButton = [[UIButton alloc]
                             initWithFrame:CGRectMake(0, confirmY, CONFIRM_BUTTON_WIDTH, CONFIRM_BUTTON_HEIGHT)];
  [confirmButton setTitle:TEXT_OK forState:UIControlStateNormal];
  [confirmButton setTitleColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR] forState:UIControlStateNormal];
  [confirmButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
  [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:CONFIRM_BUTTON_FONT_SIZE]];
  [confirmButton addTarget:self action:@selector(confirmButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  [UIConfiguration moveSubviewXToSuperviewCenter:self.rateFrontView subview:confirmButton];
  
  [self.rateFrontView addSubview:confirmButton];
}

- (void)confirmButtonPressed
{
  // Detect if login
  if (![AppContext appContext].isLogin) {
    [AppDelegate showLoginWithDelegate:self];
    
    return;
  }
  
  // Detect if isFriend
  if (!self.playerInfo.isFriend) {
    PSPDFAlertView *alertView = [[PSPDFAlertView alloc] initWithTitle:nil message:TEXT_CANNOT_RATE_PLAYER];
    [alertView setCancelButtonWithTitle:TEXT_OK_OH block:nil];
    
    [alertView show];
    
    return;
  }
  
  // Detect if score changed
  if (_rateScore == _selectedAbilityScore) {
    [self cancelButtonPressed];
    
    return;
  }
  
  [self ratePlayer];
}

- (UIColor *)colorForScore:(NSInteger)score
{
  if (score >= kScoreGradeTop) {
    return [UIConfiguration colorForHex:SCORE_TOP_COLOR];
  }
  else if (score >= kScoreGradeMiddle) {
    return [UIConfiguration colorForHex:SCORE_MIDDLE_COLOR];
  }
  else {
    return [UIConfiguration colorForHex:SCORE_BOTTOM_COLOR];
  }
}

- (void)stepperValueChanged:(UIStepper *)sender
{
  NSInteger value = [sender value];
  _rateScore = value;
  
  CGFloat width = (CGFloat)value / 100 * _scoreBarWidth;
  [UIConfiguration setView:_scoreBar width:width];
  
  [_scoreLabel setText:[NSString stringWithFormat:@"%zd", value]];
  [_scoreLabel setTextColor:[self colorForScore:value]];
}

#pragma mark - login delegate
- (void)loginSucceeded:(RegisterAndLoginViewController *)vc
{
  __weak typeof(self) weakSelf = self;
  [vc dismissViewControllerAnimated:YES completion:^{
    [weakSelf confirmButtonPressed];
  }];
}

#pragma mark - network
- (void)ratePlayer
{
  PlayerAbility ability = [GeekerAbility abilityTypeFromAbilityName:_selectedAbilityName];
  
  [UIConfiguration showTipMessageToView:self.rateFrontView];
  
  __weak typeof(self) weakSelf = self;
  [self.httpsClient ratePlayerAbilityWithPlayerID:self.playerID
                                      abilityType:ability
                                            score:_rateScore
                                        succeeded:^(NSDictionary *dictionary) {
                                          [UIConfiguration hideTipMessageOnView:weakSelf.rateFrontView];
                                          
                                          GeekerAbility *ability = [GeekerAbility objectWithDictionary:dictionary];
                                          [weakSelf.playerInfo setAbility:ability];
                                          [weakSelf configAbilityArrayWithPlayerInfo:weakSelf.playerInfo];
                                          [weakSelf cancelButtonPressed];

                                          [weakSelf.playerInfoTable beginUpdates];
                                          [weakSelf.playerInfoTable reloadRowsAtIndexPaths:@[[weakSelf selectedIndexPath]]
                                                                    withRowAnimation:UITableViewRowAnimationBottom];
                                          [weakSelf.playerInfoTable endUpdates];
                                        } failed:^(HDYSoccerAPIError *error) {
                                          [UIConfiguration hideTipMessageOnView:weakSelf.rateFrontView];

                                        }];
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

- (NSIndexPath *)selectedIndexPath
{
  return _indexPath;
}

@end
