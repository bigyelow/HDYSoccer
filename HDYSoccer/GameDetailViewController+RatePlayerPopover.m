//
//  GameDetailViewController+RatePlayerPopover.m
//  HDYSoccer
//
//  Created by bigyelow on 8/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GameDetailViewController+RatePlayerPopover.h"
#import "ParticipantsScore.h"

#define FRONT_VIEW_LEFT_MARGIN 0.0F
#define FRONT_VIEW_HEIGHT 300.0F

// title
#define TITLE_TOP_MARGIN 10.0F
#define TITLE_FORMAT_STR @"给%@评分"

// score
#define SCORE_TITLE_FORMAT_STR @"本场得分:%d分"
#define SCORE_TITLE_TOP_MARGIN 17.0F
#define SCORE_TITLE_LEFT_MARGIN 70.0F

#define SCORE_STEPPER_TOP_MARGIN 12.0F
#define SCORE_STEPPER_LEFT_MARGIN 10.0F
#define SCORE_STEPPER_MAX_VALUE 10
#define SCORE_STEPPER_INIT_VALUE 6

// tags
#define TAGS_TITLE @"本场表现:"
#define TAGS_TITLE_LEFT_MARGIN 10.0F
#define TAGS_TITLE_TOP_MARGIN 25.0F

#define FIRST_TAG_LEFT_MARGIN 15.0F
#define TAG_TOP_MARGIN 20.0F
#define TAG_INTERAL_MARGIN 5.0F
#define TAG_ROW_MARGIN 8.0F
#define TAG_BUTTON_RIGHT_MARGIN 7.0F

#define TAGS_UNSELECTED_BACK_COLOR @"#EFEFEF"

// confirm button
#define CONFIRM_BUTTON_TOP_MARGIN 20.0F
#define CONFIRM_NO_SCORE_TITLE @"确定,但不评分"
#define CONFIRM_BUTTON_NO_SCORE_WIDTH 110.0F
#define CONFIRM_BUTTON_NO_SCORE_HEIGHT 35
#define CONFIRM_BUTTON_WIDTH 160.0F
#define CONFIRM_BUTTON_LEFT_MARGIN 10
#define CONFIRM_BUTTON_FONT_SIZE 14.0F

@implementation GameDetailViewController (RatePlayerPopover)

- (void)showRatePopoverWithPlayerInfo:(ParticipantsScore *)info
{
  if (info.canRate == NO)
    return;
  
  self.selectedTags = nil;
  self.selectedParticipant = info;
  [self createRatePopover];
  [self showRateFrontViewWithAnimation];
}

- (void)createRatePopover
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
  [self.rateBackgroundView setHidden:YES];
  [self.rateFrontView setHidden:YES];
  [self.rateFrontViewScoreLabel setHidden:YES];
  
  for (UIView *subview in [self.rateFrontView subviews]) {
    [subview setHidden:YES];
    [subview removeFromSuperview];
  }
  
  [self.rateBackgroundView removeFromSuperview];
  [self.rateFrontView removeFromSuperview];
  [self.rateFrontViewScoreLabel removeFromSuperview];
  
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
                     [weakSelf configRateFrontViewWithPlayerInfo:weakSelf.selectedParticipant];

                     // bottom layer
                     [weakSelf.rateFrontView.layer setShadowColor:[UIColor blackColor].CGColor];
                     [weakSelf.rateFrontView.layer setShadowOpacity:0.5];
                     [weakSelf.rateFrontView.layer setShadowOffset:
                      CGSizeMake(0, 8.0f)];
                     [weakSelf.rateFrontView.layer setShadowRadius:14.0f];
                     [weakSelf.rateFrontView.layer setMasksToBounds:NO];
                   }];
  
}

- (void)configRateFrontViewWithPlayerInfo:(ParticipantsScore *)playerInfo
{
  // cancel button
  UIButton *cancelButton = [self topButtonWithImageName:TOP_CANCEL_IMAGE];
  [UIConfiguration setView:cancelButton size:CGSizeMake(TOP_CANCEL_BUTTON_WIDTH, TOP_CANCEL_BUTTON_WIDTH)];
  [UIConfiguration setView:cancelButton origin:CGPointMake(7, 7)];
  [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  [self.rateFrontView addSubview:cancelButton];
  
  // title
  NSString *titleStr = [NSString stringWithFormat:TITLE_FORMAT_STR, playerInfo.name];
  UILabel *titleLable = [UIConfiguration labelWithText:titleStr textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:17.0f]];
  
  [self.rateFrontView addSubview:titleLable];
  
  [UIConfiguration setView:titleLable y:TITLE_TOP_MARGIN];
  [UIConfiguration moveSubviewXToSuperviewCenter:self.rateFrontView subview:titleLable];
  
  // score label
  NSString *scoreStr = [NSString stringWithFormat:SCORE_TITLE_FORMAT_STR, SCORE_STEPPER_INIT_VALUE];
  UILabel *scoreLabel = [UIConfiguration labelWithText:scoreStr textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14.0f]];
  CGFloat scoreY = CGRectGetMaxY(titleLable.frame) + SCORE_TITLE_TOP_MARGIN;
  [UIConfiguration setView:scoreLabel origin:CGPointMake(SCORE_TITLE_LEFT_MARGIN, scoreY)];
  
  self.rateFrontViewScoreLabel = scoreLabel;
  [self.rateFrontView addSubview:scoreLabel];
  
  // stepper
  CGFloat stepperX = CGRectGetMaxX(scoreLabel.frame) + SCORE_STEPPER_LEFT_MARGIN;
  CGFloat stepperY = CGRectGetMaxY(titleLable.frame) + SCORE_STEPPER_TOP_MARGIN;
  UIStepper *scoreStepper = [[UIStepper alloc] initWithFrame:CGRectMake(stepperX, stepperY, 0, 0)];
  [scoreStepper setTransform:CGAffineTransformMakeScale(1.0, 0.8)];
  [scoreStepper setTintColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR]];
  [scoreStepper setValue:SCORE_STEPPER_INIT_VALUE];
  [scoreStepper setMaximumValue:SCORE_STEPPER_MAX_VALUE];
  [scoreStepper setMinimumValue:1];
  [scoreStepper addTarget:self action:@selector(stepperValueChanged:) forControlEvents:UIControlEventTouchUpInside];
  
  [self.rateFrontView addSubview:scoreStepper];
  
  // tags title
  UILabel *tagTitleLabel = [UIConfiguration labelWithText:TAGS_TITLE textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14]];
  CGFloat tagTitleY = CGRectGetMaxY(scoreStepper.frame) + TAGS_TITLE_TOP_MARGIN;
  [UIConfiguration setView:tagTitleLabel origin:CGPointMake(TAGS_TITLE_LEFT_MARGIN, tagTitleY)];
  
  [self.rateFrontView addSubview:tagTitleLabel];
  
  // tags
  NSArray *tagArray = @[@"高质量长传",@"高质量短传",@"优质盘带",@"意识NB",@"基本功",@"抢断",@"解围",@"扑救",@"头球",@"速度",@"力量",@"体力",@"侵略性"];
  CGFloat tagX = CGRectGetMaxX(tagTitleLabel.frame) + FIRST_TAG_LEFT_MARGIN;
  CGFloat tagY = CGRectGetMaxY(scoreStepper.frame) + TAG_TOP_MARGIN;
  CGFloat maxY;
  for (NSString *tagStr in tagArray) {
    UIButton *tagButton = [[UIButton alloc] initWithFrame:CGRectMake(tagX, tagY, 0, 0)];
    [tagButton setTitle:tagStr forState:UIControlStateNormal];
    [tagButton.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
    [tagButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [tagButton setBackgroundColor:[UIConfiguration colorForHex:TAGS_UNSELECTED_BACK_COLOR]];
    [tagButton.layer setCornerRadius:12.0f];
    [tagButton setTag:0];
    
    [tagButton addTarget:self action:@selector(tagButtonPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    [tagButton sizeToFit];
    [UIConfiguration setView:tagButton width:tagButton.frame.size.width + 15.0f];
    
    if (CGRectGetMaxX(tagButton.frame) > self.view.frame.size.width - TAG_BUTTON_RIGHT_MARGIN) {
      tagX = FIRST_TAG_LEFT_MARGIN;
      tagY += (tagButton.frame.size.height + TAG_ROW_MARGIN);
      [UIConfiguration setView:tagButton origin:CGPointMake(tagX, tagY)];
    }
    
    [self.rateFrontView addSubview:tagButton];
    
    maxY = CGRectGetMaxY(tagButton.frame);
    
    // next tag
    tagX = CGRectGetMaxX(tagButton.frame) + TAG_INTERAL_MARGIN;
  }
  
  // confirm button
  // no score
  CGFloat noScoreConfirmX = (self.view.frame.size.width
                             - CONFIRM_BUTTON_NO_SCORE_WIDTH - CONFIRM_BUTTON_LEFT_MARGIN - CONFIRM_BUTTON_WIDTH) / 2;
  CGFloat confirmY = maxY + CONFIRM_BUTTON_TOP_MARGIN;
  UIButton *noScoreButton = [[UIButton alloc]
                             initWithFrame:CGRectMake(noScoreConfirmX,
                                                      confirmY,
                                                      CONFIRM_BUTTON_NO_SCORE_WIDTH,
                                                      CONFIRM_BUTTON_NO_SCORE_HEIGHT)];
  [noScoreButton setTitle:CONFIRM_NO_SCORE_TITLE forState:UIControlStateNormal];
  [noScoreButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [noScoreButton setBackgroundColor:[UIColor grayColor]];
  [noScoreButton.titleLabel setFont:[UIFont systemFontOfSize:CONFIRM_BUTTON_FONT_SIZE]];
  
  [self.rateFrontView addSubview:noScoreButton];
  
  // confirm
  CGFloat confirmX = CGRectGetMaxX(noScoreButton.frame) + CONFIRM_BUTTON_LEFT_MARGIN;
  UIButton *confirmButton = [[UIButton alloc]
                             initWithFrame:CGRectMake(confirmX, confirmY, CONFIRM_BUTTON_WIDTH, CONFIRM_BUTTON_NO_SCORE_HEIGHT)];
  [confirmButton setTitle:TEXT_OK forState:UIControlStateNormal];
  [confirmButton setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR]];
  [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
  [confirmButton.titleLabel setFont:[UIFont systemFontOfSize:CONFIRM_BUTTON_FONT_SIZE]];
  
  [self.rateFrontView addSubview:confirmButton];
}

- (void)tagButtonPressed:(UIButton *)sender
{
  if (sender.tag == 1) {
    sender.tag = 0;
    [sender setBackgroundColor:[UIConfiguration colorForHex:TAGS_UNSELECTED_BACK_COLOR]];
    [sender setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    
    [self.selectedTags removeObjectIdenticalTo:sender.titleLabel.text];
  }
  else if ([self.selectedTags count] == 3) {
    return;
  }
  else {
    sender.tag = 1;
    [sender setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_GREEN_COLOR]];
    [sender setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    if (!self.selectedTags) {
      self.selectedTags = [NSMutableArray array];
    }
    [self.selectedTags addObject:sender.titleLabel.text];
  }
}

- (void)stepperValueChanged:(UIStepper *)sender
{
  NSInteger value = [sender value];
  NSString *str = [NSString stringWithFormat:SCORE_TITLE_FORMAT_STR, value];
  
  [self.rateFrontViewScoreLabel setText:str];
  [self.rateFrontViewScoreLabel setNumberOfLines:1];
  [self.rateFrontViewScoreLabel sizeToFit];
}

- (void)cancelButtonPressed
{
  [self.rateBackgroundView setHidden:YES];
  [self.rateFrontView setHidden:YES];
  
  // reset front view
  [UIConfiguration setView:self.rateFrontView size:CGSizeZero];
  [UIConfiguration setView:self.rateFrontView origin:self.view.center];
}
@end
