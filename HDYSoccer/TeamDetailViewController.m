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
#import "TeamScoreCell.h"
#import "TeamScoreHeaderView.h"
#import "TeamMemberCell.h"
#import "TeamMemberHeaderView.h"
#import "TeamScoreFooterView.h"
#import "HDYSoccerGeekerDetailViewController.h"
#import "SimpleGeekerInfo.h"
#import "AdminiTableHeader.h"
#import "GameRecordCell.h"
#import "UILabel+Customize.h"

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
  if (self.segControl.selectedSegmentIndex == 0) {
    if (self.teamInfo) {
      return 4;
    }
    else {
      return 1;
    }
  }
  else if (self.segControl.selectedSegmentIndex == 1) {
    return 1;
  }
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  if (self.segControl.selectedSegmentIndex == 0) {
    switch (section) {
  //    case 2:
  //      if (self.teamInfo) {
  //        return [TeamScoreHeaderView viewHeight];
  //      }
  //      
      case 3:
        if (self.teamInfo) {
          return [TeamMemberHeaderView viewHeight];
        }
        
      default:
        break;
    }
  }
//  else if (self.segControl.selectedSegmentIndex == 1) {
//    switch (section) {
//      case 0:
//        return ADMINI_TABLE_HEADER_HEIGHT;
//        
//      default:
//        break;
//    }
//  }
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
  if (self.segControl.selectedSegmentIndex == 0) {
    switch (section) {
  //    case 2:
  //      if (self.teamInfo) {
  //        return TEAM_SCORE_FOOTER_HEIGHT;
  //      }
  //      
  //      break;
  //      
      default:
        break;
    }
  }
  return 0;
}

//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//  if (self.segControl.selectedSegmentIndex == 1) {
//    switch (section) {
//      case 0:
//        return TEXT_HISTORY_RECORD;
//        
//      default:
//        break;
//    }
//  }
//  return nil;
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  if (self.segControl.selectedSegmentIndex == 0) {
    switch (section) {
  //    case 2:
  //      if (self.teamInfo) {
  //        TeamScoreHeaderView *view = [[TeamScoreHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)
  //                                                                         title:TEXT_TEAM_AVERAGE_SCORE];
  //        return view;
  //      }
  //      
      case 3:
        if (self.teamInfo) {
          TeamMemberHeaderView *view = [[TeamMemberHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 0)
                                                                             title:TEXT_TEAM_MEMBERS];
          return view;
        }

      default:
        break;
    }
  }
  return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
  if (self.segControl.selectedSegmentIndex == 0) {
    switch (section) {
  //    case 2:
  //      if (self.teamInfo) {
  //        TeamScoreFooterView *view = [[TeamScoreFooterView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, TEAM_SCORE_FOOTER_HEIGHT)];
  //        return view;
  //      }
  //      break;
  //      
      default:
        break;
    }
  }
  return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  if (self.segControl.selectedSegmentIndex == 0) {
    switch (section) {
      case 0:
        return 1;
        
      case 1:
          return 2;

  //    case 2:
  //      if (self.teamInfo) {
  //        return SCORE_TYPE_NUMBER;
  //      }

      case 3:
        if (self.teamInfo.members) {
          return [self.teamInfo.members count];
        }
        
      default:
        break;
    }
  }
  else if (self.segControl.selectedSegmentIndex == 1) {
    switch (section) {
      case 0:
        return [self.teamInfo.gameRecords count];
        break;
        
      default:
        break;
    }
  }
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (self.segControl.selectedSegmentIndex == 0) {
    switch (indexPath.section) {
      case 0:
        return [TeamBasicInfoCell cellHeight];
        
      case 1:
        return TEAM_LIST_INFO_CELL_HEIGHT;
        
      case 2:
        return TEAM_SCORE_CELL_HEIGHT;
        
      case 3:
        return TEAM_MEMBER_CELL_HEIGHT;
        
      default:
        break;
    }
  }
  else if (self.segControl.selectedSegmentIndex == 1) {
    switch (indexPath.section) {
      case 0:
        return GAME_RECORD_CELL_HEIGHT;
        
      default:
        break;
    }
  }
  return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  if (self.segControl.selectedSegmentIndex == 0) {
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
          [cell configCellWithTitle:TEXT_CAPTAIN info:self.teamInfo.captain hasBottomLine:NO];
        }
        
        return cell;
      }
        
      case 2: {
        static NSString *cellID = TEAM_SCORE_CELL_ID;
        TeamScoreCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
          cell = [[TeamScoreCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        NSDictionary *dic = self.scoreArray[indexPath.row];
        NSString *key = [dic allKeys][0];
        NSString *score = [dic objectForKey:key];
        NSNumber *shouldAnimation = self.scoreAnimationArray[indexPath.row];
        [cell configCellWithAbilityName:key abilityScore:score.integerValue animation:shouldAnimation.boolValue];
        [self.scoreAnimationArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
        
        return cell;
      }
        
      case 3: {
        static NSString *cellID = TEAM_MEMBER_CELL_ID;
        TeamMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
          cell = [[TeamMemberCell alloc] initWithStyle:UITableViewCellStyleDefault
                                        reuseIdentifier:cellID];
        }
        
        SimpleGeekerInfo *playerInfo = self.teamInfo.members[indexPath.row];
        [cell configWithPlayerInfo:playerInfo];
        
        return cell;
      }
        
      default:
        break;
    }
  }
  else if (self.segControl.selectedSegmentIndex == 1) {
    switch (indexPath.section) {
      case 0: {
        static NSString *cellID = GAME_RECORD_CELL_ID;
        GameRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
          cell = [[GameRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
          [cell.homeTeamLabel addTapGestureWithTarget:self selector:@selector(homeTeamLabelTapped:)];
          [cell.guestTeamLabel addTapGestureWithTarget:self selector:@selector(guestTeamLabelTapped:)];
        }
        [cell configWithRecord:self.teamInfo.gameRecords[indexPath.row]];
        
        cell.homeTeamLabel.tag = indexPath.row;
        cell.guestTeamLabel.tag = indexPath.row;
        
        return cell;
      }
        
      default:
        break;
    }
  }
  return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  
  if (self.segControl.selectedSegmentIndex == 0) {
    switch (indexPath.section) {
      case 3: {
        SimpleGeekerInfo *playerInfo = self.teamInfo.members[indexPath.row];
        HDYSoccerGeekerDetailViewController *vc = [[HDYSoccerGeekerDetailViewController alloc] initWithPlayerID:playerInfo.geekerID
                                                                                                     playerName:playerInfo.name];
        [self.navigationController pushViewController:vc animated:YES];
      }
        break;
        
      default:
        break;
    }
  }
}

- (void)homeTeamLabelTapped:(UIGestureRecognizer*)recognizer
{
  if (recognizer.state == UIGestureRecognizerStateEnded) {
    UILabel *label = (UILabel *)[recognizer view];
    TeamGameRecords *record = self.teamInfo.gameRecords[label.tag];
    TeamDetailViewController *vc = [[TeamDetailViewController alloc] initWithTeamID:record.homeTeamID
                                                                           teamName:record.homeTeamName];
    [self.navigationController pushViewController:vc animated:YES];
  }
}

- (void)guestTeamLabelTapped:(UIGestureRecognizer*)recognizer
{
  if (recognizer.state == UIGestureRecognizerStateEnded) {
    UILabel *label = (UILabel *)[recognizer view];
    TeamGameRecords *record = self.teamInfo.gameRecords[label.tag];
    TeamDetailViewController *vc = [[TeamDetailViewController alloc] initWithTeamID:record.guestTeamID
                                                                           teamName:record.guestTeamName];
    [self.navigationController pushViewController:vc animated:YES];
  }
}
@end
