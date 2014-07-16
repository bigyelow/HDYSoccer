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
#import "GeekerListCell.h"

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
  [self.geekerTable setHidden:YES];
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
// just for sample
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
  return GEEKER_LIST_CELL_HEIGHT;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  NSInteger index = self.segControl.selectedSegmentIndex;
  if (index == 0) {
    return [self.geekersArray count];
  }
  else {
    return [self.teamsArray count];
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  NSInteger index = self.segControl.selectedSegmentIndex;
  if (index == 0) {
    SimpleGeekerInfo *geekerInfo = self.geekersArray[indexPath.row];

    static NSString *cellID = GEEKER_CELL_IDENTIFIER;
    GeekerListCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
      cell = [[GeekerListCell alloc] initWithStyle:UITableViewCellStyleDefault
                                   reuseIdentifier:cellID
                                        geekerInfo:geekerInfo];
    }
    return cell;
  }
  else {
    return nil;
  }
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
