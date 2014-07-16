//
//  HDYSoccerGeekerDetailViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerDetailViewController.h"
#import "HDYSoccerGeekerDetailViewController+UIConfiguration.h"
#import "GeekerDetailParams.h"

@interface HDYSoccerGeekerDetailViewController ()
@property (nonatomic, strong) NSArray *sampleDatas;
@end

@implementation HDYSoccerGeekerDetailViewController

- (id)initWithGeeker:(NSString *)geekerName
{
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    self.geekerName = geekerName;
    [self initSampleDatas];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  
  [self configTableHeaderView];
  [self configTableView];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - customization
- (void)initSampleDatas
{
  self.sampleDatas = [NSArray
                      arrayWithObjects:@"左脚: 75", @"右脚: 89", @"速度: 80", @"体力: 80",
                      @"灵敏: 95", @"意识: 95", @"力量: 86", nil];
}

#pragma mark - tableView delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return [self.sampleDatas count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  static NSString *cellID = CELL_IDENTIFIER;
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
  if (cell == nil) {
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
  }
  
  [cell.textLabel setText:[self.sampleDatas objectAtIndex:indexPath.row]];
  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  
  return cell;
}

@end
