//
//  HDYSoccerPlayerViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/25/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerPlayerViewController.h"
#import "PlayerViewParams.h"
#import "HDYSoccerPlayerViewController+UIConfiguration.h"

@interface HDYSoccerPlayerViewController ()

@property (nonatomic, strong) NSArray *sampleDatas;

@end

@implementation HDYSoccerPlayerViewController

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
  self.title = TEXT_TITLE;
  
//  [self configSegmentView];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - customization
- (void)initSampleDatas
{
  self.sampleDatas = [NSArray arrayWithObjects:@"1", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"11", @"12", @"13", @"14", nil];
}

#pragma mark - tableview datasource and delegate
//- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
//{
//  return [self.sampleDatas count];
//}
//
//- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
//{
//  static NSString *cellID = CELL_IDENTIFIER;
//  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
//  if (cell == nil) {
//    cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
//  }
//  
//  [cell.textLabel setText:[self.sampleDatas objectAtIndex:indexPath.row]];
//  
//  return cell;
//}
//
//- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//  NSLog(@"%d", indexPath.row);
//}
@end
