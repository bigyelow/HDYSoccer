//
//  HDYSoccertTabBar.m
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerTabBar.h"
#import "TabBarUIParams.h"

@implementation HDYSoccertTabBar

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIColor blackColor]];
  }
  return self;
}

- (void)setBarButtons:(NSArray *)barButtons
{
  CGSize size = self.bounds.size;
  CGFloat origX = 0.f;
  NSUInteger indexTag = 0;
  for (UIButton *btn in barButtons) {
    CGFloat w = floorf(size.width / barButtons.count);
    btn.frame = CGRectMake(origX, 0.f, floorf(size.width / barButtons.count), size.height);
    origX += w;
    [self addSubview:btn];
    btn.tag = indexTag++;
    [btn addTarget:self action:@selector(_barTapAction:) forControlEvents:UIControlEventTouchUpInside];
  }
}

- (void)createBarButtons
{
  NSArray *barTitleArray = @[@"1", @"2", @"3"];
  
  NSMutableArray *barBtns = [NSMutableArray array];
  for (NSString *title in barTitleArray) {
    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [self configButton:btn title:title];
    [barBtns addObject:btn];
  }
  
  self.barButtons = barBtns;
}

- (void)configButton:(UIButton *)button
               title:(NSString *)title
{
  [button.titleLabel setFont:[UIFont systemFontOfSize:TABBAR_TITLE_FONT_SIZE]];
  [button.titleLabel setTextColor:[UIColor blackColor]];
  [button setTitle:title forState:UIControlStateNormal];
}

- (void)_barTapAction:(UIButton *)btn
{
  [self.delegate tabBar:self didSelectAtIndex:btn.tag];
}

@end
