//
//  GeekerChatsViewController.m
//  HDYSoccer
//
//  Created by XueMing on 11/27/15.
//  Copyright © 2015 bigyelow. All rights reserved.
//

#import "GeekerChatsViewController.h"
#import "GeekerChatsCell.h"

@interface GeekerChatsViewController ()

@property (nonatomic, strong) UITableView *tableView;

@end

@implementation GeekerChatsViewController

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.title = @"个人数据";

  _tableView = [[UITableView alloc] init];
  _tableView.delegate = self;
  _tableView.dataSource = self;
  [_tableView registerClass:[GeekerChatsCell class] forCellReuseIdentifier:NSStringFromClass([GeekerChatsCell class])];
  [self.view addSubview:_tableView];
}

- (void)viewDidLayoutSubviews
{
  [super viewDidLayoutSubviews];

  _tableView.frame = self.view.bounds;
}

#pragma mark - UITableViewDataSource

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
  switch (section) {
    case 0:
      return @"最近6个月的综合分数";
      break;

    default:
      break;
  }
  return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  GeekerChatsCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([GeekerChatsCell class]) forIndexPath:indexPath];
  [cell configUI:indexPath];
  return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  return 170;
}

@end
