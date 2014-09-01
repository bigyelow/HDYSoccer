//
//  HDYSoccerGameViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameViewController.h"
#import "GameViewParams.h"
#import "HDYSoccerGameHeader.h"
#import "HDYSoccerGameFooter.h"
#import "AppDelegate.h"
#import "HDYSoccerGameViewController+CollectionView.h"
#import "HDYSoccerGameViewController+NetWork.h"
#import "HDYSoccerGameViewController+SegmentControl.h"
#import "HDYSoccerGameViewController+Filter.h"
#import "HDYSoccerGameViewController+CreateGame.h"
#import "SVPullToRefresh.h"
#import "CreateGameDetailViewController.h"
#import "SimplePersonalGameInfo.h"
#import "SimpleTeamGameInfo.h"
#import "GameDetailViewController.h"
#import "PersonalGameCell2.h"
#import "TeamGameCell2.h"

@interface HDYSoccerGameViewController ()

@end

@implementation HDYSoccerGameViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
  self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
  if (self) {
    // Custom initialization
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self setEdgesForExtendedLayout:UIRectEdgeNone];
  
  [self setTitle:GAME_TITLE];
  
  // top buttons
  [self configTopFilterButton];
  [self configTopCreateButton];
  [self configTopMenuButton];
  
  // segment control and collection views
  [self configSegControlWithIndex:0];
  
  [self.view addGestureRecognizer:[[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                          action:@selector(panGestureRecognized:)]];
}

- (void)viewDidAppear:(BOOL)animated
{
  [super viewDidAppear:animated];
  [self updateCollectionViewLayout];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
  [super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
  [self updateCollectionViewLayout];
}

- (void)updateCollectionViewLayout
{
  if (self.collectionViewArray) {
    for (int i = 0; i < [self.collectionViewArray count]; ++i) {
      UICollectionView *collectionView = (UICollectionView *)[self.collectionViewArray objectAtIndex:i];
      CHTCollectionViewWaterfallLayout *layout =
      (CHTCollectionViewWaterfallLayout *)collectionView.collectionViewLayout;
      layout.columnCount = COLUMN_NUMBER;
    }
  }
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];
  // Dispose of any resources that can be recreated.
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
  if ([self.collectionViewArray containsObject:collectionView]) {
    NSInteger index = [self.collectionViewArray indexOfObject:collectionView];
    NSMutableArray *list = [self getGameListIndex:index];
    
    return [list count];
  }
  return 0;
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
  return SECTION_NUMBER;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
  if ([self.collectionViewArray containsObject:collectionView]) {
    NSInteger index = [self.collectionViewArray indexOfObject:collectionView];
    NSMutableArray *list = [self getGameListIndex:index];
    
    if (index == 0) {
      static NSString *cellID = PERSONAL_GAME_CELL2_ID;
      PersonalGameCell2 *cell = nil;
      cell = (PersonalGameCell2 *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
  
      SimplePersonalGameInfo *gameInfo = list[indexPath.row];
      [cell configCellWithGameInfo:gameInfo];
      return cell;
    }
    else if (index == 1) {
      static NSString *cellID = TEAM_GAME_CELL2_ID;
      TeamGameCell2 *cell = nil;
      cell = (TeamGameCell2 *)[collectionView dequeueReusableCellWithReuseIdentifier:cellID forIndexPath:indexPath];
      
      SimpleTeamGameInfo *gameInfo = list[indexPath.row];
      [cell configCellWithGameInfo:gameInfo];
      return cell;
    }
  }

  return nil;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
  NSInteger index = [self.collectionViewArray indexOfObject:collectionView];
  NSMutableArray *list = [self getGameListIndex:index];
  
  GameType gameType;
  NSString *gameID;
  if (index == 0) {
    SimplePersonalGameInfo *gameInfo = list[indexPath.row];
    gameType = kGameTypePersonal;
    gameID = gameInfo.personalGameID;
  }
  else {
    SimpleTeamGameInfo *gameInfo = list[indexPath.row];
    gameType = kGameTypeTeam;
    gameID = gameInfo.teamGameID;
  }
  
  GameDetailViewController *viewCtr = [[GameDetailViewController alloc] initWithgameID:gameID
                                                                              gameType:gameType
                                                                        tableviewStyle:UITableViewStylePlain];
  [self.navigationController pushViewController:viewCtr animated:YES];
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  NSInteger index = [self.collectionViewArray indexOfObject:collectionView];

  CGFloat cellWidth = self.view.bounds.size.width;
  if (index == 0) {
    return CGSizeMake(cellWidth, PERSONAL_GAEM_CELL2_HEIGHT);
  }
  else if (index == 1) {
    return CGSizeMake(cellWidth, TEAM_GAME_CELL2_HEIGHT);
  }

  return CGSizeZero;
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
