//
//  HDYSoccerGeekerDetailViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerDetailViewController.h"
#import "HDYSoccerGeekerDetailViewController+SegmentControl.h"
#import "HDYSoccerGeekerDetailViewController+NetworkOperation.h"
#import "PlayerBasicInfoCell.h"

@interface HDYSoccerGeekerDetailViewController ()
@property (nonatomic, strong) NSArray *sampleDatas;
@end

@implementation HDYSoccerGeekerDetailViewController

- (id)initWithPlayerID:(NSString *)playerID
            playerName:(NSString *)playerName
{
  self = [super initWithStyle:UITableViewStyleGrouped];
  if (self) {
    self.playerID = @"1000";
    self.playerName = playerName;
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  self.title = self.playerName;
  [self configSegmentView];
  [self loadPlayerInfoWithPlayerID:self.playerID];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch (indexPath.section) {
    case 0:
      switch (indexPath.row) {
        case 0:
          return [PlayerBasicInfoCell cellHeight];
          
        default:
          break;
      }
      break;
      
    default:
      break;
  }
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch (indexPath.section) {
    case 0:
      switch (indexPath.row) {
        case 0: {
          static NSString *cellID = PLAYER_BASIC_INFO_CELL_ID;
          PlayerBasicInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
          if (!cell) {
            cell = [[PlayerBasicInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
          }
          
          if (self.playerInfo) {
            [cell configCellWithPlayer:self.playerInfo];
          }
          
          return cell;
        }
          
        default:
          break;
      }
      break;
      
    default:
      break;
  }
  return nil;
}
@end
