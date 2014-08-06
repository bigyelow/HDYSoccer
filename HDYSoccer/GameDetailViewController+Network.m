//
//  GameDetailViewController+Network.m
//  HDYSoccer
//
//  Created by bigyelow on 6/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GameDetailViewController+Network.h"
#import "HDYSoccerAPIClient+HTTP.h"
#import "PersonalGame.h"
#import "TeamGame.h"

@implementation GameDetailViewController (Network)

- (void)loadGameInfoWithGameID:(NSString *)gameID
                      gameType:(GameType)gameType
{
  __weak typeof(self) weakSelf = self;
  
  if (gameType == kGameTypePersonal) {
    
    [UIConfiguration showTipMessageToView:self.view title:TEXT_LOADING];
    [self.httpsClient getPersonalGameWithID:gameID
                                 succeeded:^(NSDictionary *dictionary) {
                                   [UIConfiguration hideTipMessageOnView:weakSelf.view];
                                   weakSelf.personalGame = [PersonalGame objectWithDictionary:dictionary];
                                   [weakSelf setTitle:weakSelf.personalGame.gameName];
                                   [weakSelf.tableView reloadData];
                                  
                                 } failed:^(HDYSoccerAPIError *error) {
                                   [UIConfiguration hideTipMessageOnView:weakSelf.view];

                                 }];
  }
  else if (gameType == kGameTypeTeam) {
    [UIConfiguration showTipMessageToView:self.view title:TEXT_LOADING];
    [self.httpsClient getTeamGameWithID:gameID
                             succeeded:^(NSDictionary *dictionary) {
                               [UIConfiguration hideTipMessageOnView:weakSelf.view];
                               weakSelf.teamGame = [TeamGame objectWithDictionary:dictionary];
                               [weakSelf setTitle:weakSelf.teamGame.gameName];
                               [weakSelf.tableView reloadData];
                               
                             } failed:^(HDYSoccerAPIError *error) {
                               [UIConfiguration hideTipMessageOnView:weakSelf.view];

                             }];
  }
}

- (void)loadTags
{
  NSUserDefaults *userDefaults = [NSUserDefaults standardUserDefaults];
  self.tagsArray = [userDefaults objectForKey:DEFAULTS_TAGS_KEY];
  
  if (!self.tagsArray) {
    __weak typeof(self) weakSelf = self;
    [self.httpsClient getTagsSucceeded:^(NSArray *array) {
      weakSelf.tagsArray = [array copy];
    } failed:^(HDYSoccerAPIError *error) {
      weakSelf.tagsArray = [LOCAL_TAGS copy];
    }];
  }
}
@end
