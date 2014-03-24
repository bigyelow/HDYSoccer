//
//  HDYSoccerBaseTableViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseTableViewController.h"

@interface HDYSoccerBaseTableViewController ()

@property (nonatomic, assign) UITableViewStyle tableViewStyle;
@end

@implementation HDYSoccerBaseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super init];
  if (self) {
    self.needTabbar = YES;
    self.tableViewStyle = style;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:self.tableViewStyle];
  [self.tableView setBackgroundView:nil];
  [self.tableView setDelegate:self];
  [self.tableView setDataSource:self];
  [self.tableView setAutoresizingMask:~UIViewAutoresizingNone];
  [self.view addSubview:self.tableView];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return nil;
}

@end
