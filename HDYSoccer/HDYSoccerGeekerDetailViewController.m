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
#import "PlayerListInfoCell.h"
#import "Geeker.h"
#import "PlayerTagsCell.h"
#import "GeekerAbility.h"
#import "PlayerAbilityCell.h"
#import "PlayerAbilityHeaderView.h"
#import "HDYSoccerGeekerDetailViewController+RateView.h"

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
  return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  switch (section) {
    case 2:
      if ([self.comprehensiveAbilityArray count]) {
        return [PlayerAbilityHeaderView viewHeight];
      }
      
    case 3:
      if ([self.skillAbilityArray count]) {
        return [PlayerAbilityHeaderView viewHeight];
      }
      
    case 4:
      if ([self.qualityAbilityArray count]) {
        return [PlayerAbilityHeaderView viewHeight];
      }
      
    default:
      break;
  }
  return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  switch (section) {
    case 2:
      if ([self.comprehensiveAbilityArray count]) {
        PlayerAbilityHeaderView *view = [[PlayerAbilityHeaderView alloc]
                                         initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)
                                         title:TEXT_COMPREHENSIVE_ABILITY];
        return view;
      }
      
    case 3:
      if ([self.skillAbilityArray count]) {
        PlayerAbilityHeaderView *view = [[PlayerAbilityHeaderView alloc]
                                         initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)
                                         title:TEXT_SKILL_ABILITY];
        return view;
      }
      
    case 4:
      if ([self.qualityAbilityArray count]) {
        PlayerAbilityHeaderView *view = [[PlayerAbilityHeaderView alloc]
                                         initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 0)
                                         title:TEXT_QUALITY_ABILITY];
        return view;
      }
      
    default:
      break;
  }
  return nil;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  switch (section) {
    case 0: {
      if (!self.playerInfo) {
        return 1;
      }
      else {
        return 3;
      }
    }
      
    case 1:
      if (self.playerInfo) {
        return 1;
      }
      
    case 2:
      return [self.comprehensiveAbilityArray count];
      
    case 3:
      return [self.skillAbilityArray count];
      
    case 4:
      return [self.qualityAbilityArray count];
      
    default:
      break;
  }
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  switch (indexPath.section) {
    case 0:
      switch (indexPath.row) {
        case 0:
          return [PlayerBasicInfoCell cellHeight];
          
        case 1:
        case 2:
          return PLAYER_LIST_CELL_HEIGHT;
      }
      break;
      
    case 1: {
      self.tagsPositionArray = [PlayerTagsCell tagPositionsForCellWithTags:self.playerInfo.tagsArray];
      NSNumber *number = self.tagsPositionArray[0];
      return number.floatValue;
    }
      
    case 2:
    case 3:
    case 4:
      return PLAYER_ABILITY_CELL_HEIGHT;
      
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
          
        case 1:
        case 2: {
          static NSString *cellID = PLAYER_LIST_CELL_ID;
          PlayerListInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
          if (!cell) {
            cell = [[PlayerListInfoCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
          }
          
          if (indexPath.row == 1) {
            [cell configCellWithTitle:TEXT_BIRTHDAY info:self.playerInfo.birthDate hasBottomLine:NO];
          }
          else if (indexPath.row == 2) {
            [cell configCellWithTitle:TEXT_HEIGHT info:[NSString stringWithFormat:@"%.0fcm", self.playerInfo.height] hasBottomLine:YES];
          }
          
          return cell;
        }
          
        default:
          break;
      }
      break;
      
    case 1: {
      static NSString *cellID = PLAYER_TAGS_CELL_ID;
      PlayerTagsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
      if (!cell) {
        cell = [[PlayerTagsCell alloc] initWithStyle:UITableViewCellStyleDefault
                                     reuseIdentifier:cellID
                                                tags:self.playerInfo.tagsArray
                                        tagsPosition:self.tagsPositionArray];
      }
      
      return cell;
    }
      
    case 2: {
      static NSString *cellID = PLAYER_ABILITY_CELL_ID;
      PlayerAbilityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
      if (!cell) {
        cell = [[PlayerAbilityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
      }
      
      NSDictionary *dic = self.comprehensiveAbilityArray[indexPath.row];
      NSString *key = [dic allKeys][0];
      NSNumber *value = [dic objectForKey:key];
      NSNumber *shouldAnimation = self.compreAbilityScoreAnimationArray[indexPath.row];
      
      [cell configCellWithAbilityName:key abilityScore:value.integerValue animation:shouldAnimation.boolValue];
      [self.compreAbilityScoreAnimationArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
      
      return cell;
    }
      
    case 3: {
      static NSString *cellID = PLAYER_ABILITY_CELL_ID;
      PlayerAbilityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
      if (!cell) {
        cell = [[PlayerAbilityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
      }
      
      NSDictionary *dic = self.skillAbilityArray[indexPath.row];
      NSString *key = [dic allKeys][0];
      NSNumber *value = [dic objectForKey:key];
      NSNumber *shouldAnimation = self.skillAbilityScoreAnimationArray[indexPath.row];
      
      [cell configCellWithAbilityName:key abilityScore:value.integerValue animation:shouldAnimation.boolValue];
      [self.skillAbilityScoreAnimationArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
      
      return cell;
    }
      
    case 4: {
      static NSString *cellID = PLAYER_ABILITY_CELL_ID;
      PlayerAbilityCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
      if (!cell) {
        cell = [[PlayerAbilityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
      }
      
      NSDictionary *dic = self.qualityAbilityArray[indexPath.row];
      NSString *key = [dic allKeys][0];
      NSNumber *value = [dic objectForKey:key];
      NSNumber *shouldAnimation = self.qualityAbilityScoreAnimationArray[indexPath.row];
      
      [cell configCellWithAbilityName:key abilityScore:value.integerValue animation:shouldAnimation.boolValue];
      [self.qualityAbilityScoreAnimationArray replaceObjectAtIndex:indexPath.row withObject:[NSNumber numberWithBool:NO]];
      
      return cell;
    }
      
    default:
      break;
  }
  return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
  [tableView deselectRowAtIndexPath:indexPath animated:NO];
  
  NSDictionary *dic;
  switch (indexPath.section) {
    case 2:
      dic = self.comprehensiveAbilityArray[indexPath.row];
      
      break;
    case 3:
      dic = self.skillAbilityArray[indexPath.row];
      
      break;
    case 4:
      dic = self.qualityAbilityArray[indexPath.row];
      
      break;
      
    default:
      break;
  }
  
  NSString *key = [dic allKeys][0];
  NSNumber *value = [dic objectForKey:key];
  
  [self showRateViewWithAbilityName:key score:value.integerValue];
}
@end
