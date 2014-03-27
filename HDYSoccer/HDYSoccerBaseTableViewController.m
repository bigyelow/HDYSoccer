//
//  HDYSoccerBaseTableViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseTableViewController.h"

@interface HDYSoccerBaseTableViewController ()

@end

@implementation HDYSoccerBaseTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super init];
  if (self) {
    self.style = style;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
  self.tableView.backgroundView = nil;
  self.tableView.delegate = self;
  self.tableView.dataSource = self;
  self.tableView.autoresizingMask = ~UIViewAutoresizingNone;
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
