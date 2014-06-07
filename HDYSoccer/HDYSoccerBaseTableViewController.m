//
//  HDYSoccerBaseTableViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseViewParams.h"
#import "HDYSoccerBaseTableViewController.h"
#import "SVPullToRefresh.h"

@interface HDYSoccerBaseTableViewController ()

@end

@implementation HDYSoccerBaseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super init];
  if (self) {
    self.style = style;
    self.enableTopPullToRefresh = NO;
    self.enableBottomPullToLoadMore = NO;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.style];
  self.tableView.backgroundView = nil;
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.tableView.autoresizingMask = ~UIViewAutoresizingNone;
  [self.view addSubview:self.tableView];

  [self configPullToRefreshAndLoadMore];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
}

#pragma mark - top pull to refresh & load more
- (void)configPullToRefreshAndLoadMore
{
  [self setEnableBottomPullToLoadMore:self.enableBottomPullToLoadMore
                        actionHandler:nil];
  [self setEnableTopPullToRefresh:self.enableTopPullToRefresh
                    actionHandler:nil];
}

- (void)setEnableTopPullToRefresh:(BOOL)enableTopPullToRefresh
                    actionHandler:(void (^)(void))actionHandler
{
  if (!enableTopPullToRefresh) {
    return;
  }
  
  [self.tableView addPullToRefreshWithActionHandler:actionHandler];
}

- (void)setEnableBottomPullToLoadMore:(BOOL)enableBottomPullToLoadMore
                        actionHandler:(void (^)(void))actionHandler

{
  if (!enableBottomPullToLoadMore) {
    return;
  }
  
  [self.tableView addInfiniteScrollingWithActionHandler:actionHandler];
}

@end
