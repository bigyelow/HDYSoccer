//
//  HDYSoccerGeekerViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerViewController.h"
#import "GeekerViewParams.h"
#import "HDYSoccerGeekerViewController+UIConfiguration.h"
#import "HDYSoccerGeekerDetailViewController.h"
#import "AppDelegate.h"

@interface HDYSoccerGeekerViewController ()

@property (nonatomic, strong) NSArray *sampleDatas;
@end

@implementation HDYSoccerGeekerViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    [self initSampleDatas];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  
  [self setTitle:TEXT_TITLE];
  [self configSegmentView];
  
  [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(panGestureRecognized:)]];
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
                      arrayWithObjects:@"黄杜煜", @"王雨寒", @"David Beckham", @"梅西",
                      @"C罗", @"罗纳尔多", @"小罗纳尔多", @"范佩西", @"卡卡",
                      @"皮尔洛", @"哈维", @"齐达内", @"巴乔", nil];
}


#pragma mark - tableview datasource and delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  return CELL_HEIGHT;
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
    cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
  }

  [cell.textLabel setText:[self.sampleDatas objectAtIndex:indexPath.row]];
  [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
  
  return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSString *geekerName = self.sampleDatas[indexPath.row];
  HDYSoccerGeekerDetailViewController *geekerDetailVC = [[HDYSoccerGeekerDetailViewController alloc] initWithGeeker:geekerName];
  
  [self.navigationController pushViewController:geekerDetailVC animated:YES];
}

#pragma mark Gesture recognizer

- (void)panGestureRecognized:(UIPanGestureRecognizer *)sender
{
  // Dismiss keyboard (optional)
  [self.view endEditing:YES];
  [self.frostedViewController.view endEditing:YES];
  
  // Present the view controller
  [self.frostedViewController panGestureRecognized:sender];
}
@end
