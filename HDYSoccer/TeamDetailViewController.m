//
//  TeamDetailViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 8/18/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "TeamDetailViewController.h"
#import "TeamDetailViewController+SegmentControl.h"
#import "TeamDetailViewController+NetworkOperation.h"
#import "Team.h"
#import "TeamBasicInfoCell.h"
#import "TeamListInfoCell.h"

@interface TeamDetailViewController ()

@end

@implementation TeamDetailViewController

- (id)initWithTeamID:(NSString *)teamID teamName:(NSString *)teamName
{
  self = [super initWithStyle:UITableViewStylePlain];
  if (self) {
    self.teamID = @"12312";
    self.teamName = teamName;
  }
  
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  self.title = self.teamName;
  [self configSegmentView];
  [self loadTeamInfoWithTeamID:self.teamID];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - tableview delegate & datasource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  if (self.teamInfo) {
    return 4;
  }
  else {
    return 1;
  }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  switch (section) {
    case 0:
      return 1;
      
    case 1:
        return 2;
//
//    case 2:
//      if (self.teamInfo) {
//        return 1;
//      }
//      
//    case 3:
//      if (self.teamInfo.members) {
//        return [self.teamInfo.members count];
//      }
      
    default:
      break;
  }
  
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch (indexPath.section) {
    case 0:
      return [TeamBasicInfoCell cellHeight];
      
    case 1:
      return TEAM_LIST_INFO_CELL_HEIGHT;
      
    default:
      break;
  }
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch (indexPath.section) {
    case 0: {
      static NSString *cellID = TEAM_BASIC_INFO_CELL_ID;
      TeamBasicInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
      if (!cell) {
        cell = [[TeamBasicInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
      }
      
      if (self.teamInfo) {
        [cell configCellWithTeam:self.teamInfo];
      }
      return cell;
    }
      
    case 1: {
      static NSString *cellID = TEAM_LIST_INFO_CELL_ID;
      TeamListInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
      if (!cell) {
        cell = [[TeamListInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
      }
      
      if (indexPath.row == 0) {
        [cell configCellWithTitle:TEXT_COACH info:self.teamInfo.coach hasBottomLine:NO];
      }
      else if (indexPath.row == 1) {
        [cell configCellWithTitle:TEXT_CAPTAIN info:self.teamInfo.captain hasBottomLine:YES];
      }
      
      return cell;
    }
      
    default:
      break;
  }
  return nil;
}
@end
