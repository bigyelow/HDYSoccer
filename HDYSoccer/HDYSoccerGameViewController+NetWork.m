//
//  HDYSoccerGameViewController+NetWork.m
//  HDYSoccer
//
//  Created by bigyelow on 6/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameViewController+NetWork.h"
#import "HDYSoccerGameViewController+SegmentControl.h"
#import "HDYSoccerGameViewController+CollectionView.h"
#import "HDYSoccerAPIClient+HTTP.h"
#import "PersonalGameList.h"
#import "TeamGameList.h"
#import "SVPullToRefresh.h"

@implementation HDYSoccerGameViewController (NetWork)

#define GAME_LIST_COUNT_LIMIT 5
#define STOP_PULLTOREFRESH_DELAY 0.3f

#define INDICATOR_TOP_MARGIN 20.0F

- (void)loadGameListWithSegIndex:(NSInteger)segIndex
                            time:(NSString *)time
                           field:(NSString *)field
                           start:(NSInteger)start
{
  NSString *type = [self getSegmentTypeWithIndex:segIndex];
  NSString *lat = [AppContext appContext].location.latitude;
  NSString *log = [AppContext appContext].location.longtitude;
  
  HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];

  __weak typeof(self) weakSelf = self;
  
  CGPoint indicatorOrigin = CGPointMake(self.view.center.x, TOP_BAR_HEIGHT
                                        + self.segmentBackView.frame.size.height
                                        + INDICATOR_TOP_MARGIN);
  [UIConfiguration showProcessIndicatorWithView:self.view atPoint:indicatorOrigin];
  [client getGameListWithType:type
                     latitude:lat
                   longtitude:log
                         time:time
                        field:field
                        start:start
                        count:GAME_LIST_COUNT_LIMIT
                    succeeded:^(NSDictionary *dictionary) {
                      [UIConfiguration hideProcessIndicatorWithView:weakSelf.view];
                      
                      // init game list for index
                      NSArray *listArray;
                      if (segIndex == 0) {  // person
                        PersonalGameList *gameList = [PersonalGameList objectWithDictionary:dictionary];
                        listArray = gameList.gameList;
                      }
                      else if (segIndex == 1) { // team
                        TeamGameList *gameList = [TeamGameList objectWithDictionary:dictionary];
                        listArray = gameList.gameList;
                      }

                      // update collection view
                      UICollectionView *collectionView = weakSelf.collectionViewArray[segIndex];
                      if (listArray) {
                        [weakSelf setGameListIndex:segIndex gameList:[NSMutableArray arrayWithArray:listArray]];
                        [collectionView reloadData];
                        
                        // may be empty
                        if ([listArray count]) {
                          NSIndexPath *firstIndex = [NSIndexPath indexPathForItem:0 inSection:0];
                          [collectionView scrollToItemAtIndexPath:firstIndex
                                                 atScrollPosition:UICollectionViewScrollPositionBottom
                                                         animated:NO];
                        }
                      }
                      [collectionView.pullToRefreshView stopAnimating];
                      
                      // update top buttons
                      [weakSelf.filterItem setEnabled:YES];
                      
                      // upate params
                      [weakSelf setLoadedOnceValueIndex:segIndex loadedOnce:YES];
                      [weakSelf setRefreshingValueIndex:segIndex refreshing:NO];
                      
                    } failed:^(HDYSoccerAPIError *error) {
                      [UIConfiguration hideProcessIndicatorWithView:weakSelf.view];

                      // update collection view
                      UICollectionView *collectionView = weakSelf.collectionViewArray[segIndex];
                      [collectionView.pullToRefreshView stopAnimating];
                      
                      // update top buttons
                      [weakSelf.filterItem setEnabled:YES];
                      
                      // update params
                      [weakSelf setRefreshingValueIndex:segIndex refreshing:NO];
                    }];
}

- (void)loadMoreGameListWithSegIndex:(NSInteger)segIndex
                                time:(NSString *)time
                               field:(NSString *)field
                               start:(NSInteger)start
{
  NSString *type = [self getSegmentTypeWithIndex:segIndex];
  NSString *lat = [AppContext appContext].location.latitude;
  NSString *log = [AppContext appContext].location.longtitude;
  
  HDYSoccerAPIClient *client = [HDYSoccerAPIClient newHttpsClient];
  
  __weak typeof(self) weakSelf = self;
  
  [client getGameListWithType:type
                     latitude:lat
                   longtitude:log
                         time:time
                        field:field
                        start:start
                        count:GAME_LIST_COUNT_LIMIT
                    succeeded:^(NSDictionary *dictionary) {
                      
                      // update game list for index
                      NSArray *listArray;
                      if (segIndex == 0) {  // person
                        PersonalGameList *gameList = [PersonalGameList objectWithDictionary:dictionary];
                        listArray = gameList.gameList;
                      }
                      else if (segIndex == 1) { // team
                        TeamGameList *gameList = [TeamGameList objectWithDictionary:dictionary];
                        listArray = gameList.gameList;
                      }
                      
                      // update collection view
                      UICollectionView *collectionView = weakSelf.collectionViewArray[segIndex];
                      if (listArray && [listArray count]) {
                        // generate indexpaths
                        NSMutableArray *gameList = [weakSelf getGameListIndex:segIndex];
                        NSInteger count = [gameList count];
                        NSMutableArray *indexPaths = [NSMutableArray array];
                        for (int i = count; i < count + [listArray count]; i++) {
                          [indexPaths addObject:[NSIndexPath indexPathForItem:i inSection:0]];
                        }
                        
                        // add new game list
                        [gameList addObjectsFromArray:listArray];
                        [weakSelf setGameListIndex:segIndex gameList:gameList];
                        
                        // reload collection view
                        [collectionView performBatchUpdates:^{
                          [collectionView insertItemsAtIndexPaths:indexPaths];
                        } completion:^(BOOL finished) {
                          // update top buttons
                          [weakSelf.filterItem setEnabled:YES];

                          // upate params
                          [weakSelf setLoadingMoreValueIndex:segIndex loadingMore:NO];
                        }];
                      }
                      
                      [collectionView.infiniteScrollingView stopAnimating];
                    } failed:^(HDYSoccerAPIError *error) {
                      
                      // update collection view
                      UICollectionView *collectionView = weakSelf.collectionViewArray[segIndex];
                      [collectionView.pullToRefreshView stopAnimating];
                      
                      // update top buttons
                      [weakSelf.filterItem setEnabled:YES];
                      
                      // update params
                      [weakSelf setLoadingMoreValueIndex:segIndex loadingMore:NO];
                      
                      [collectionView.infiniteScrollingView stopAnimating];
                    }];

}
@end
