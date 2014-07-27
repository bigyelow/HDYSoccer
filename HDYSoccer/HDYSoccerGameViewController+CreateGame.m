//
//  HDYSoccerGameViewController+CreateGame.m
//  HDYSoccer
//
//  Created by bigyelow on 6/8/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameViewController+CreateGame.h"
#import "HDYSoccerNavigationController.h"
#import "GameDetailViewController.h"
#import "FXBlurView.h"

@implementation HDYSoccerGameViewController (CreateGame)

- (void)configTopCreateButton
{
  UIButton *button = [self topButtonWithImageName:TOP_ADD_IMAGE];
  [button addTarget:self action:@selector(createGameButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  
  UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithCustomView:button];
  NSMutableArray *rightItems = [self.navigationItem.rightBarButtonItems mutableCopy];
  [rightItems insertObject:item atIndex:0];
  [self.navigationItem setRightBarButtonItems:rightItems];
}

#define CREATE_VIEW_INIT_ALPHA 0

- (void)createGameButtonPressed
{
  // blur view
  UIWindow *mainWindow = [[UIApplication sharedApplication] keyWindow];
  FXBlurView *view = [[FXBlurView alloc] initWithFrame:mainWindow.bounds];
  [view setBlurRadius:7];
  [view setTintColor:[UIColor clearColor]];
  [mainWindow addSubview:view];
  
  UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self
                                                                        action:@selector(handleBlurViewTap:)];
  tap.cancelsTouchesInView = NO;
  [view addGestureRecognizer:tap];

  self.createBackBlurView = view;
  
  // front view
  if (!self.createView) {
    self.createView = [self getCreateGameView];
  }
  [self.createView setAlpha:CREATE_VIEW_INIT_ALPHA];
  [view addSubview:self.createView];
  
  __weak typeof(self) weakSelf = self;
  [UIView animateWithDuration:0.5
                   animations:^{
                     [weakSelf.createView setAlpha:1];
                   }];
}

- (void)handleBlurViewTap:(UITapGestureRecognizer *)gr
{
  if (!CGRectContainsPoint(self.createView.frame, [gr locationInView:gr.view])) {
    [self.createBackBlurView removeFromSuperview];
  }
}

#pragma makr - create game view

#define CREATE_VIEW_LEFT_MARGIN 10
#define CREATE_VIEW_HEIGHT 200.0F

#define CREATE_BUTTON_LEFT_MARGIN 20.0F
#define CREATE_BUTTON_INTERAL_MARGIN 20.0F
#define CREATE_BUTTON_HEIGHT 30.0F
#define CREATE_BUTTON_BOTTOM_MARGIN 10.0F

- (UIView *)getCreateGameView
{
  // front view
  CGFloat frontWidth = self.view.bounds.size.width - 2 * CREATE_VIEW_LEFT_MARGIN;
  UIView *frontView = [[UIView alloc] initWithFrame:CGRectMake(CREATE_VIEW_LEFT_MARGIN, 0, frontWidth, CREATE_VIEW_HEIGHT)];
  [frontView setCenter:self.view.center];
  [frontView setBackgroundColor:[UIColor whiteColor]];
  [frontView setAlpha:CREATE_VIEW_INIT_ALPHA];
  
  // cancel button
  UIButton *cancelButton = [self topButtonWithImageName:TOP_CANCEL_IMAGE];
  [UIConfiguration setView:cancelButton size:CGSizeMake(TOP_CANCEL_BUTTON_WIDTH, TOP_CANCEL_BUTTON_WIDTH)];
  [UIConfiguration setView:cancelButton origin:CGPointMake(7, 7)];
  [cancelButton addTarget:self action:@selector(cancelButtonPressed) forControlEvents:UIControlEventTouchUpInside];
  [frontView addSubview:cancelButton];
  
  // create button
  CGFloat buttonWidth = (frontWidth - 2 * CREATE_BUTTON_LEFT_MARGIN - CREATE_BUTTON_INTERAL_MARGIN) / 2;
  CGFloat buttonHeight = CREATE_BUTTON_HEIGHT;
  CGFloat buttonY = CREATE_VIEW_HEIGHT - CREATE_BUTTON_BOTTOM_MARGIN - CREATE_BUTTON_HEIGHT;

  // peronal game button
  CGFloat personalX = CREATE_BUTTON_LEFT_MARGIN;
  CGRect personalRect = CGRectMake(personalX, buttonY, buttonWidth, buttonHeight);
  UIButton *personalButton = [self getCreateButtonWithFrame:personalRect title:CREATE_PERSONAL_GAME];
  [personalButton addTarget:self action:@selector(createPersonalGamePressed) forControlEvents:UIControlEventTouchUpInside];
  
  self.personalGameButton = personalButton;
  [frontView addSubview:personalButton];
  
  // team game button
  CGFloat teamX = CGRectGetMaxX(personalButton.frame) + CREATE_BUTTON_INTERAL_MARGIN;
  CGRect teamRect = CGRectMake(teamX, buttonY, buttonWidth, buttonHeight);
  UIButton *teamButton = [self getCreateButtonWithFrame:teamRect title:CREATE_TEAM_GAME];
  [teamButton addTarget:self action:@selector(createTeamGamePressed) forControlEvents:UIControlEventTouchUpInside];
  
  self.teamGameButton = teamButton;
  [frontView addSubview:teamButton];
  
  // shadow
  [frontView.layer setShadowColor:[UIColor blackColor].CGColor];
  [frontView.layer setShadowOpacity:0.5];
  [frontView.layer setShadowOffset:
   CGSizeMake(0, 8.0f)];
  [frontView.layer setShadowRadius:14.0f];
  [frontView.layer setMasksToBounds:NO];
  UIBezierPath *path = [UIBezierPath bezierPathWithRect:frontView.bounds];
  frontView.layer.shadowPath = path.CGPath;
  
  return frontView;
}

- (void)cancelButtonPressed
{
  [self.createBackBlurView removeFromSuperview];
}

- (UIButton *)getCreateButtonWithFrame:(CGRect)frame
                                 title:(NSString *)title
{
  UIButton *button = [[UIButton alloc] initWithFrame:frame];
  [button setTitle:title forState:UIControlStateNormal];
  [button setTitleColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR] forState:UIControlStateNormal];
  [button setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
  [button.titleLabel setFont:[UIFont systemFontOfSize:15.0f]];
  
  return button;
}

- (void)createPersonalGamePressed
{
  CreateGameDetailViewController *createCtr = [[CreateGameDetailViewController alloc]
                                               initWithStyle:UITableViewStyleGrouped
                                               gameType:kGameTypePersonal];
  [createCtr setCreateGameDelegate:self];
  
  HDYSoccerNavigationController *createNav = [[HDYSoccerNavigationController alloc] initWithRootViewController:createCtr];
  [self presentViewController:createNav
                     animated:YES
                   completion:nil];
  [self.createBackBlurView removeFromSuperview];
}

- (void)createTeamGamePressed
{
  CreateGameDetailViewController *createCtr = [[CreateGameDetailViewController alloc]
                                               initWithStyle:UITableViewStyleGrouped
                                               gameType:kGameTypeTeam];
  [createCtr setCreateGameDelegate:self];
  
  HDYSoccerNavigationController *createNav = [[HDYSoccerNavigationController alloc] initWithRootViewController:createCtr];
  [self presentViewController:createNav
                     animated:YES
                   completion:nil];
  [self.createBackBlurView removeFromSuperview];
}

#pragma mark - create game delegate
- (void)createGameSucceeded:(NSDictionary *)dic
{ 
  GameDetailViewController *viewCtr = [[GameDetailViewController alloc] initWithGameInfo:dic
                                                                          tableViewStyle:UITableViewStyleGrouped];
  HDYSoccerNavigationController *navCtr = [[HDYSoccerNavigationController alloc] initWithRootViewController:viewCtr];
  
  [self presentViewController:navCtr animated:YES completion:nil];
}
@end
