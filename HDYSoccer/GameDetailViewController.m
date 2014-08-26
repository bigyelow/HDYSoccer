//
//  GameDetailViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 6/25/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GameDetailViewController.h"
#import "CreateGameViewController.h"
#import "PersonalGame.h"
#import "TeamGame.h"
#import "GameDetailViewController+TopButtons.h"
#import "GameDetailViewController+Network.h"
#import "GameListFilterFieldTableViewCell.h"
#import "GameListFilterTableViewCell.h"
#import "CostCellForGameInfo.h"
#import "ContactCellForGameInfo.h"
#import "RemarkCellForGameInfo.h"
#import "PlayerCellForGameDetail.h"
#import "JoinGameCell.h"
#import "RatePlayerCell.h"
#import "RatePlayerHeaderView.h"
#import "GameDetailViewController+RatePlayerPopover.h"
#import "TeamInfoCell.h"
#import "TeamGameRecordsCell.h"
#import "TeamGameRecordsHeaderView.h"
#import "HDYSoccerGeekerDetailViewController.h"
#import "TeamDetailViewController.h"
#import "UILabel+Customize.h"
#import "CommentBar.h"
#import "CommentViewController.h"
#import "HDYSoccerNavigationController.h"

#define BACKGROUND_IMAGE_NAME @"background_field1.jpg"

@interface GameDetailViewController ()

@end

@implementation GameDetailViewController

// gameInfo = {"gameType":object, "gameObject":object}
- (id)initWithGameInfo:(NSDictionary *)gameInfo tableViewStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    [self initGameInfo:gameInfo];
  }
  return self;
}

- (void)initGameInfo:(NSDictionary *)gameInfo
{
  NSNumber *number = [gameInfo objectForKey:KEY_GAME_TYPE];
  self.gameType = number.integerValue;
  self.newCreated = YES;
  
  switch (self.gameType) {
    case kGameTypePersonal:
      self.personalGame = [gameInfo objectForKey:KEY_GAME_OBJECT];
      self.title = self.personalGame.gameName;
      break;
      
    case kGameTypeTeam:
      self.teamGame = [gameInfo objectForKey:KEY_GAME_OBJECT];
      self.title = self.teamGame.gameName;
      break;
      
    default:
      
      break;
  }
}

- (id)initWithgameID:(NSString *)gameID
            gameType:(GameType)gameType
      tableviewStyle:(UITableViewStyle)style
{
  self = [super initWithStyle:style];
  if (self) {
    self.gameID = gameID;
    self.gameType = gameType;
  }
  return self;
}


- (void)viewDidLoad
{
  [super viewDidLoad];

  if (self.newCreated) {
    [self configTopItems];  // add confirm button to new created game
  }
  
  if (self.newCreated == NO) {  // load from game list
    [self loadGameInfoWithGameID:self.gameID gameType:self.gameType];
  }
  
  [self loadTags];
  [self configTableContentInset];
  
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  [self.tableView setShowsVerticalScrollIndicator:NO];
  
  // background
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
  [imageView setImage:[UIImage imageNamed:BACKGROUND_IMAGE_NAME]];
  [self.tableView setBackgroundView:imageView];
  
  [self.tableView setHidden:YES];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

- (void)configTableContentInset
{
  CGFloat bottomMargin = COMMENT_BAR_HEIGHT;
  if (self.gameType == kGameTypePersonal) {
    bottomMargin += 20;
  }
  [self.tableView setContentInset:UIEdgeInsetsMake(0, 0, bottomMargin, 0)];
}

- (void)configCommentBar
{
  CGFloat barY = self.view.frame.size.height;
  CommentBar *bar = [[CommentBar alloc] initWithFrame:CGRectMake(0, barY, self.view.frame.size.width, COMMENT_BAR_HEIGHT)
                                        commentsCount:self.commentsCount];
  
  [self.view addSubview:bar];
  
  [UIView animateWithDuration:0.2
                        delay:0.8
                      options:UIViewAnimationOptionCurveEaseIn
                   animations:^{
                     [UIConfiguration setView:bar y:self.view.frame.size.height - COMMENT_BAR_HEIGHT];
                   }
                   completion:nil];
  
  UITapGestureRecognizer *gest = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(commentBarTapped:)];
  [bar addGestureRecognizer:gest];
}

- (void)commentBarTapped:(UITapGestureRecognizer *)gest
{
  CommentViewController *vc = [[CommentViewController alloc] initWithGameType:self.gameType gameID:self.gameID];
  HDYSoccerNavigationController *nav = [[HDYSoccerNavigationController alloc] initWithRootViewController:vc];
  [self presentViewController:nav animated:YES completion:nil];
}

#pragma mark - get methods
- (NSInteger)commentsCount
{
  NSInteger count;
  switch (self.gameType) {
    case kGameTypePersonal:
      count = self.personalGame.commentsCount;
      break;
      
    case kGameTypeTeam:
      count = self.teamGame.commentsCount;
      break;
      
    default:
      break;
  }
  
  return count;
}

- (NSString *)contact
{
  NSString *str;
  switch (self.gameType) {
    case kGameTypePersonal:
      str = self.personalGame.contact;
      break;
      
    case kGameTypeTeam:
      str = self.teamGame.contact;
      break;
      
    default:
      break;
  }
  
  if (!str) {
    str = @"";
  }
  return str;
}

- (NSString *)remarks
{
  NSString *str;
  switch (self.gameType) {
    case kGameTypePersonal:
      str = self.personalGame.remark;
      break;
      
    case kGameTypeTeam:
      str = self.teamGame.remark;
      break;
      
    default:
      break;
  }
  
  if (!str) {
    str = @"";
  }
  return str;
}

- (NSString *)totalCost
{
  NSString *str;
  switch (self.gameType) {
    case kGameTypePersonal:
      str = self.personalGame.totalCost;
      break;
      
    case kGameTypeTeam:
      str = self.teamGame.totalCost;
      break;
      
    default:
      break;
  }
  
  if (!str) {
    str = @"0";
  }
  return str;
}

- (NSString *)time
{
  NSString *str;
  switch (self.gameType) {
    case kGameTypePersonal:
      str = [Tools dateToStr:self.personalGame.time preferUTC:NO];
      break;
      
    case kGameTypeTeam:
      str = [Tools dateToStr:self.teamGame.time preferUTC:NO];
      break;
      
    default:
      break;
  }
  
  if (!str) {
    str = @"";
  }
  return str;
}

- (NSString *)field
{
  NSString *str;
  switch (self.gameType) {
    case kGameTypePersonal:
      str = self.personalGame.field;
      break;
      
    case kGameTypeTeam:
      str = self.teamGame.field;
      break;
      
    default:
      break;
  }
  
  if (!str) {
    str = @"";
  }
  return str;
}

#pragma mark - tableview delegate and datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  if (self.gameType == kGameTypePersonal) {
    return 8;
  }
  else if (self.gameType == kGameTypeTeam ) {
    return 8;
  }
  
  return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  // personal game
  if (self.gameType == kGameTypePersonal && indexPath.section == 5 && self.remarkCell) {
    return [self.remarkCell heightForCell:self.remarks];
  }
  else if (self.gameType == kGameTypePersonal && indexPath.section == 2 && indexPath.row != 0) {
    return GAME_INFO_PLAYER_CELL_HEIGHT;
  }
  else if (self.gameType == kGameTypePersonal && indexPath.section == 6) {
    return JOIN_GAME_CELL_HEIGHT;
  }
  else if (self.gameType == kGameTypePersonal && indexPath.section == 7) {
    return RATE_PLAYER_CELL_HEIGHT;
  }
  
  // team game
  else if (self.gameType == kGameTypeTeam && indexPath.section == 2 && indexPath.row == 0) {
    return 30;
  }
  else if (self.gameType == kGameTypeTeam && indexPath.section == 2 && indexPath.row == 1) {
    return [TeamInfoCell heightForCell];
  }
  else if (self.gameType == kGameTypeTeam && indexPath.section == 3) {
    return TEAM_GAME_RECORD_CELL_HEIGHT;
  }
  else if (self.gameType == kGameTypeTeam && indexPath.section == 7) {
    return JOIN_GAME_CELL_HEIGHT;
  }
  else if (self.gameType == kGameTypeTeam && indexPath.section == 6 && self.remarkCell) {
    return [self.remarkCell heightForCell:self.remarks];
  }
  
  return 44.0f;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  // personal game
  if (self.gameType == kGameTypePersonal && section == 2) {
    if (self.personalGame) {
      return self.personalGame.playerCount + 1;
    }
    else {
      return 0;
    }
  }
  else if (self.gameType == kGameTypePersonal && section == 7) {
    if (self.personalGame) {
      return self.personalGame.playerCount;
    }
    else {
      return 0;
    }
  }
  
  // team game
  else if (self.gameType == kGameTypeTeam && section == 2) {
    if (self.teamGame) {
      return 2;
    }
    else {
      return 0;
    }
  }
  else if (self.gameType == kGameTypeTeam && section == 3) {
    if (self.teamGame) {
       return [self.teamGame.gameRecords count];
    }
    else {
      return 0;
    }
  }
  
  return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
  // personal
  if (self.gameType == kGameTypePersonal && self.personalGame && section == 7) { // rate section
    return RATE_PLAYER_HEADER_HEIGHT;
  }
  // team
  else if (self.gameType == kGameTypeTeam && self.teamGame && section == 3) {
    return TEAM_GAME_RECORD_HEADER_HEIGHT;
  }
  
  return 0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
  // personal
  if (self.gameType == kGameTypePersonal && section == 7) {
    RatePlayerHeaderView *view = [[RatePlayerHeaderView alloc]
                                  initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, RATE_PLAYER_HEADER_HEIGHT)];
    return view;
  }
  // team
  if (self.gameType == kGameTypeTeam && section == 3) {
    TeamGameRecordsHeaderView *view = [[TeamGameRecordsHeaderView alloc]
                                       initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, TEAM_GAME_RECORD_HEADER_HEIGHT)];
    
    return view;
  }
  return nil;
}

#define PLAYER_SECTION_FOOTER_HEIGHT 13

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
  if (self.gameType == kGameTypePersonal) {
    if (section == 2) {
      UIView *view = [[UIView alloc] init];
      [view setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
      [view setAlpha:0.5];
      
      // seperator line
      CGFloat seperatorY = PLAYER_SECTION_FOOTER_HEIGHT - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
      UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.view.frame.size.width, GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT)];
      [seperator setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_SEPERATOR_COLOR]];
      
      [view addSubview:seperator];
      return view;
    }
  }
  return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
  if (self.gameType == kGameTypePersonal) {
    if (section == 2) {
      return PLAYER_SECTION_FOOTER_HEIGHT;
    }
  }
  return 0;
}

#define GAEM_DETAIL_CELL_ID @"gameDetailCell"

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  // personal game
  if (self.gameType == kGameTypePersonal) {
    switch (indexPath.section) {
      case 0: {
        NSString *cellID = GAME_LIST_FILTER_CELL_ID;
        GameListFilterTableViewCell *timeCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (timeCell == nil) {
          timeCell = [[GameListFilterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
          [timeCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        NSString *timeCellText = [NSString stringWithFormat:TEXT_SELECT_TIME_FORMAT_TITLE, self.time];
        [timeCell.timeLabel setText:timeCellText];
        [timeCell.timeLabel setNumberOfLines:1];
        [timeCell.timeLabel sizeToFit];
        
        return timeCell;
      }
        
      case 1: {
        NSString *cellID = GAME_LIST_FILTER_CELL_ID;
        GameListFilterFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
          cell = [[GameListFilterFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        [cell configCellWithField:self.field];
        
        return cell;
      }
        
      case 2: {
        NSString *cellID = GAME_INFO_PLAYER_CELL_ID;
        PlayerCellForGameDetail *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
          cell = [[PlayerCellForGameDetail alloc] initWithStyle:UITableViewCellStyleDefault
                                                reuseIdentifier:cellID];
        }
        
        switch (indexPath.row) {
          case 0: {
            NSString *identifier = GAEM_DETAIL_CELL_ID;
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
              cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:identifier];
              [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            
            [cell setBackgroundColor:[UIColor clearColor]];
            [cell.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
            [cell.contentView setAlpha:0.5];
            
            NSMutableString *tempStr = [NSMutableString stringWithFormat:TEXT_PARTICIPANTS_NUMBER, self.personalGame.playerCount];
            if (self.personalGame.averageScore && ![self.personalGame.averageScore isEqualToString:@"0"]) {
              [tempStr appendString:@","];
              [tempStr appendString:[NSString stringWithFormat:TEXT_AVERAGE_SCORE, self.personalGame.averageScore]];
            }
            
            UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
            [label setText:tempStr];
            [label setFont:[UIFont fontWithName:GLOBAL_FONT_NAME size:14]];
            [label setTextColor:[UIColor whiteColor]];
            [label sizeToFit];
            [UIConfiguration moveSubviewToSuperviewCenter:cell subview:label];
            
            [cell addSubview:label];
            return cell;
          }
            
          case 1:
            [cell configWithPlayerInfo:self.personalGame.sponsor isSponsor:YES];
            [cell.seperator setHidden:YES];
            break;
            
          default:
            [cell configWithPlayerInfo:self.personalGame.participants[indexPath.row - 2] isSponsor:NO];
            if (indexPath.row == self.personalGame.playerCount) {
              [cell.seperator setHidden:NO];
            }
            else {
              [cell.seperator setHidden:YES];
            }
            break;
        }
        
        return cell;
      }
        
      case 3: {
        NSString *cellID = GAME_INFO_COST_CELL_ID;
        NSString *cellText = [NSString stringWithFormat:@"%@: %@%@", TEXT_COST_TITLE, self.totalCost, TEXT_CHINESE_MEASURE];
        
        CostCellForGameInfo *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
          cell = [[CostCellForGameInfo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID title:cellText];
        }
        else {
          [cell updateWithTitle:cellText];
        }
        
        return cell;
      }
        
      case 4: {
        NSString *cellID = GAME_INFO_CONTACT_CELL_ID;
        NSString *contact = self.contact;
        if ([contact isEqualToString:@""]) {
          contact = TEXT_UNFILLED;
        }
        NSString *cellText = [NSString stringWithFormat:@"%@: %@", TEXT_CONTACT, contact];
        
        ContactCellForGameInfo *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
          cell = [[ContactCellForGameInfo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID title:cellText];
        }
        else {
          [cell updateWithTitle:cellText];
        }
        
        return cell;
      }
        
        
      case 5: {
        NSString *cellID = GAME_INFO_REMAR_CELL_ID;
        
        RemarkCellForGameInfo *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
          cell = [[RemarkCellForGameInfo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
          self.remarkCell = cell;
        }
        return cell;
      }
        
      case 6: {
        NSString *cellID = GAME_INFO_JOIN_CELL_ID;
        
        JoinGameCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
          cell =  [[JoinGameCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellID
                                             gameType:self.gameType
                                   showStatisticTitle:YES];
        }
        return cell;
      }
        
      case 7: {
        if (self.gameType == kGameTypePersonal) {
          NSString *cellID = GAME_INFO_RATE_PLAYER_CELL_ID;
          RatePlayerCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
          if (cell == nil) {
            cell = [[RatePlayerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
          }
          
          [cell configWithPlayerInfo:self.rateList[indexPath.row]];
          
          return cell;
        }
      }
        
      default:
        break;
    }

  }
  
  // team game
  else if (self.gameType == kGameTypeTeam) {
    switch (indexPath.section) {
      case 0: {
        NSString *cellID = GAME_LIST_FILTER_CELL_ID;
        GameListFilterTableViewCell *timeCell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (timeCell == nil) {
          timeCell = [[GameListFilterTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
          [timeCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        NSString *timeCellText = [NSString stringWithFormat:TEXT_SELECT_TIME_FORMAT_TITLE, self.time];
        [timeCell.timeLabel setText:timeCellText];
        [timeCell.timeLabel setNumberOfLines:1];
        [timeCell.timeLabel sizeToFit];
        
        return timeCell;
      }
        
      case 1: {
        NSString *cellID = GAME_LIST_FILTER_CELL_ID;
        GameListFilterFieldTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
          cell = [[GameListFilterFieldTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
        }
        
        [cell configCellWithField:self.field];
        
        return cell;
      }
        
      case 2: {
        switch (indexPath.row) {
          case 0: {
            NSString *identifier = GAEM_DETAIL_CELL_ID;
            UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
            if (!cell) {
              cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                            reuseIdentifier:identifier];
              [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
              [cell setBackgroundColor:[UIColor clearColor]];
              [cell.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
              [cell.contentView setAlpha:0.5];
              
              NSMutableString *tempStr = [NSMutableString stringWithFormat:TEXT_TEAM_GAME_PLAYERS_NUMBER, self.teamGame.playerCount];
              UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
              [label setText:tempStr];
              [label setFont:[UIFont fontWithName:GLOBAL_FONT_NAME size:14]];
              [label setTextColor:[UIColor whiteColor]];
              [label sizeToFit];
              [UIConfiguration moveSubviewXToSuperviewCenter:cell subview:label];
              [UIConfiguration setView:label y:10];
              
              [cell addSubview:label];
            }

            return cell;
          }
            
          case 1: {
            NSString *cellID = GAME_INFO_TEAM_INFO_CELL_ID;
            TeamInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
            if (!cell) {
              cell = [[TeamInfoCell alloc] initWithStyle:UITableViewCellStyleDefault
                                         reuseIdentifier:cellID
                                                teamInfo:self.teamGame];
            }
            
            return cell;
          }
            
          default:
            break;
        }
        
        break;
      }
        
      case 3: {
        NSString *cellID = GAME_INFO_TEAM_GAME_RECORD_CELL_ID;
        
        TeamGameRecordsCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (!cell) {
          cell = [[TeamGameRecordsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
          [cell.homeTeamLabel addTapGestureWithTarget:self selector:@selector(homeTeamLabelTapped:)];
          [cell.guestTeamLabel addTapGestureWithTarget:self selector:@selector(guestTeamLabelTapped:)];
        }
        [cell configCellWithGameRecord:self.teamGame.gameRecords[indexPath.row]];
        cell.homeTeamLabel.tag = indexPath.row;
        cell.guestTeamLabel.tag = indexPath.row;
        
        return cell;
      }
        
      case 4: {
        NSString *cellID = GAME_INFO_COST_CELL_ID;
        NSString *cellText = [NSString stringWithFormat:@"%@: %@%@", TEXT_COST_TITLE, self.totalCost, TEXT_CHINESE_MEASURE];
        
        CostCellForGameInfo *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
          cell = [[CostCellForGameInfo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID title:cellText];
        }
        else {
          [cell updateWithTitle:cellText];
        }
        
        return cell;
      }
        
      case 5: {
        NSString *cellID = GAME_INFO_CONTACT_CELL_ID;
        NSString *contact = self.contact;
        if ([contact isEqualToString:@""]) {
          contact = TEXT_UNFILLED;
        }
        NSString *cellText = [NSString stringWithFormat:@"%@: %@", TEXT_CONTACT, contact];
        
        ContactCellForGameInfo *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
          cell = [[ContactCellForGameInfo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID title:cellText];
        }
        else {
          [cell updateWithTitle:cellText];
        }
        
        return cell;
      }
        
        
      case 6: {
        NSString *cellID = GAME_INFO_REMAR_CELL_ID;
        
        RemarkCellForGameInfo *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
          cell = [[RemarkCellForGameInfo alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
          self.remarkCell = cell;
        }
        return cell;
      }
        
      case 7: {
        NSString *cellID = GAME_INFO_JOIN_CELL_ID;
        
        JoinGameCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
        if (cell == nil) {
          cell =  [[JoinGameCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellID
                                             gameType:self.gameType
                                   showStatisticTitle:NO];
        }
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

  // PERSONAL
  if (self.gameType == kGameTypePersonal) {
    switch (indexPath.section) {
      case 2: {
        NSString *playerID, *playerName;
        if (indexPath.row == 1) { // sponsor
          playerID = self.personalGame.sponsor.geekerID;
          playerName = self.personalGame.sponsor.name;
        }
        else if (indexPath.row > 1) { // players
          SimpleGeekerInfo *playerInfo = self.personalGame.participants[indexPath.row - 2];
          playerID = playerInfo.geekerID;
          playerName = playerInfo.name;
        }
        
        HDYSoccerGeekerDetailViewController *vc = [[HDYSoccerGeekerDetailViewController alloc] initWithPlayerID:playerID
                                                                                                     playerName:playerName];
        [self.navigationController pushViewController:vc animated:YES];
        
        break;
      }
        
      case 7:
        [self showRatePopoverWithPlayerInfo:self.rateList[indexPath.row]];
        break;
        
      default:
        break;
    }
  }
  
  // TEAM
  else if (self.gameType == kGameTypeTeam) {
    switch (indexPath.section) {
      case 2:
        if (indexPath.row == 1) {
          TeamDetailViewController *vc = [[TeamDetailViewController alloc] initWithTeamID:self.teamGame.teamID
                                                                                 teamName:self.teamGame.teamName];
          
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
    TeamGameRecords *record = self.teamGame.gameRecords[label.tag];
    TeamDetailViewController *vc = [[TeamDetailViewController alloc] initWithTeamID:record.homeTeamID
                                                                           teamName:record.homeTeamName];
    [self.navigationController pushViewController:vc animated:YES];
  }
}

- (void)guestTeamLabelTapped:(UIGestureRecognizer*)recognizer
{
  if (recognizer.state == UIGestureRecognizerStateEnded) {
    UILabel *label = (UILabel *)[recognizer view];
    TeamGameRecords *record = self.teamGame.gameRecords[label.tag];
    TeamDetailViewController *vc = [[TeamDetailViewController alloc] initWithTeamID:record.guestTeamID
                                                                           teamName:record.guestTeamName];
    [self.navigationController pushViewController:vc animated:YES];
  }
}
@end
