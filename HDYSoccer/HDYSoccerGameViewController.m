//
//  HDYSoccerGameViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 3/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameViewController.h"
#import "GameViewParams.h"
#import "HDYSoccerGameCell.h"
#import "HDYSoccerGameHeader.h"
#import "HDYSoccerGameFooter.h"
#import "AppDelegate.h"
#import "HDYSoccerGameViewController+CollectionView.h"
#import "HDYSoccerGameViewController+NetWork.h"
#import "HDYSoccerGameViewController+SegmentControl.h"
#import "SVPullToRefresh.h"

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
  [self setTitle:GAME_TITLE];
  
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
  HDYSoccerGameCell *cell = nil;
  if ([self.collectionViewArray containsObject:collectionView]) {
    NSInteger index = [self.collectionViewArray indexOfObject:collectionView];
    NSMutableArray *list = [self getGameListIndex:index];
    SimplePersonalGameInfo *gameInfo = list[indexPath.row];
    
    cell = (HDYSoccerGameCell *)[collectionView dequeueReusableCellWithReuseIdentifier:GAME_CELL_IDENTIFIER
                                                                   forIndexPath:indexPath];
    [cell configWithGameInfo:gameInfo];
  }
  return cell;
}

#pragma mark - CHTCollectionViewDelegateWaterfallLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
  CGSize cellSize = CGSizeMake(CELL_WIDTH, CELL_HEIGHT);
  return cellSize;
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
