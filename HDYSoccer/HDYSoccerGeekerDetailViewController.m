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
  switch (section) {
    case 0: {
      if (!self.playerInfo) {
        return 1;
      }
      else {
        NSInteger rowNumber = 1;
        if (self.playerInfo.birthDate) {
          rowNumber++;
        }
        if (self.playerInfo.height) {
          rowNumber++;
        }
        return rowNumber;
      }
    }
      
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
      
    default:
      break;
  }
  return nil;
}
@end
