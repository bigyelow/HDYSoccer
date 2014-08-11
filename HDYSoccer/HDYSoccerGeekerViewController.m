//
//  HDYSoccerGeekerViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerViewController.h"
#import "GeekerViewParams.h"
#import "HDYSoccerGeekerViewController+SegmentControl.h"
#import "HDYSoccerGeekerDetailViewController.h"
#import "AppDelegate.h"
#import "HDYSoccerGeekerViewController+Network.h"
#import "SimpleGeekerInfo.h"
#import "GeekerTableCell.h"
#import "TeamTableCell.h"

@interface HDYSoccerGeekerViewController ()

@property (nonatomic, strong) NSArray *sampleDatas;
@end

@implementation HDYSoccerGeekerViewController

- (id)initWithStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    self.style = style;
    self.geekersArray = [NSMutableArray array];
    self.teamsArray = [NSMutableArray array];
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
	// Do any additional setup after loading the view.
  
  [self setTitle:TEXT_TITLE];
  [self configTopMenuButton];
  [self configSegmentView];
  
  [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(panGestureRecognized:)]];

}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - tableview datasource and delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSInteger index = self.segControl.selectedSegmentIndex;
  if (index == 0) {
    return GEEKER_TABLE_CELL_HEIGHT;
  }
  else if (index == 1) {
    return TEAM_TABLE_CELL_HEIGHT;
  }
  
  return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSInteger index = self.segControl.selectedSegmentIndex;
  if (index == 0) {
    return [self.geekersArray count];
  }
  else if (index == 1) {
    return [self.teamsArray count];
  }
  
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSInteger index = self.segControl.selectedSegmentIndex;
  if (index == 0) {
    static NSString *cellID = GEEKER_TABLE_CELL_ID;
    GeekerTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
      cell = [[GeekerTableCell alloc] initWithStyle:UITableViewCellStyleDefault
                                    reuseIdentifier:cellID];
    }
    
    SimpleGeekerInfo *playerInfo = self.geekersArray[indexPath.row];
    [cell configWithPlayerInfo:playerInfo];
    
    return cell;
  }
  else if (index == 1) {
    static NSString *cellID = TEAM_TABLE_CELL_ID;
    TeamTableCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
      cell = [[TeamTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    [cell configWithTeamInfo:self.teamsArray[indexPath.row]];
    
    return cell;
  }
  
  return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  
  NSInteger index = self.segControl.selectedSegmentIndex;
  if (index == 0) {
    SimpleGeekerInfo *geekerInfo = self.geekersArray[indexPath.row];
    HDYSoccerGeekerDetailViewController *geekerDetailVC = [[HDYSoccerGeekerDetailViewController alloc]
                                                           initWithGeeker:geekerInfo.name];
    
    [self.navigationController pushViewController:geekerDetailVC animated:YES];
  }
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
