//
//  HDYSoccerTabBarController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerTabBarController.h"
#import "TabBarUIParams.h"

@interface HDYSoccerTabBarController ()

@end

@implementation HDYSoccerTabBarController

- (id)initWithViewControllers:(NSArray *)viewCtrs
{
  self = [super init];
  if (self) {
    for (UIViewController *c in viewCtrs) {
      [self addChildViewController:c];
      [c didMoveToParentViewController:self];
    }
    _selectedIndex = NSNotFound;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  // config tabbar
  CGRect viewBounds = self.view.bounds;
  CGRect barRect = (CGRect){0.f, viewBounds.size.height - TABBAR_HEIGHT, viewBounds.size.width, TABBAR_HEIGHT};
  self.tabBar = [[HDYSoccertTabBar alloc] initWithFrame:barRect];
  [self.tabBar setDelegate:self];
  [self.tabBar setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
  [self.tabBar createBarButtons];
  
  [self.view addSubview:self.tabBar];
  
  // config containerView
  // containerView用来控制tabBarController中的显示部分
  CGRect containerRect = viewBounds;
  containerRect.size.height -= self.tabBar.bounds.size.height;
  self.containerView = [[UIView alloc] initWithFrame:containerRect];
  self.containerView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
  [self.view addSubview:self.containerView];
  if (_selectedIndex == NSNotFound) {
    [self setSelectedIndex:0];
  }
}

- (void)loadView
{
  CGRect rect = [UIScreen mainScreen].applicationFrame;
  rect.origin = CGPointZero;
  self.view = [[UIView alloc] initWithFrame:rect];
}

- (void)setSelectedIndex:(NSUInteger)selectedIndex
{
  NSUInteger preIndex = _selectedIndex;
  if (preIndex != NSNotFound) {
    UIViewController *selected = [self selectedViewController];
    [selected.view removeFromSuperview];
  }
  _selectedIndex = selectedIndex;
  UIViewController *controlelr = [[self childViewControllers] objectAtIndex:selectedIndex];
  [self.containerView addSubview:controlelr.view];
  controlelr.view.frame = self.containerView.bounds;
}

- (UIViewController *)selectedViewController
{
  return [[self childViewControllers] objectAtIndex:self.selectedIndex];
}

#pragma mark - Movie TabBar Delegate
- (void)tabBar:(HDYSoccertTabBar *)tabBar didSelectAtIndex:(NSUInteger)index
{
  [self setSelectedIndex:index];
}


#pragma mark - control tabbar
- (void)setTabBarHidden:(BOOL)hidden
{
  if (hidden == self.isBarHidden) {
    return;
  }
  
  // config tabbar
  [UIView animateWithDuration:TABBAR_HIDDEN_ANIMATION_DURING
                   animations:^{
                     self.isBarHidden = hidden;
                     
                     CGRect rect = self.tabBar.frame;
                     if (self.isBarHidden) {
                       rect.origin.y += TABBAR_HEIGHT;
                     }
                     else {
                       rect.origin.y -= TABBAR_HEIGHT;
                     }
                     
                     self.tabBar.frame = rect;
                   }];
  
  // config containerView acccording to the hidden status of tabbar
  CGRect containerFrame = self.containerView.frame;
  if (self.isBarHidden) {
    containerFrame = self.view.bounds;
  }
  else {
    containerFrame.size.height = self.view.bounds.size.height - self.tabBar.bounds.size.height;
  }
  [self.containerView setFrame:containerFrame];
}

#pragma mark - search view
- (void)hideSearchView
{
  
}

- (void)showSearchView
{
  
}

- (void)fastHideSearchView
{
  
}

- (void)hideSearchContentView
{
  
}
@end
