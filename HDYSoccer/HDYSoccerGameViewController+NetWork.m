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
#import "SVPullToRefresh.h"

@implementation HDYSoccerGameViewController (NetWork)

#define GAME_LIST_COUNT_LIMIT 5
#define STOP_PULLTOREFRESH_DELAY 0.3f

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
  
  [client getGameListWithType:type
                     latitude:lat
                   longtitude:log
                         time:time
                        field:field
                        start:start
                        count:GAME_LIST_COUNT_LIMIT
                    succeeded:^(NSDictionary *dictionary) {
                      
                      // init game list for index
                      PersonalGameList *gameList = [PersonalGameList objectWithDictionary:dictionary];
                      NSArray *listArray = gameList.gameList;
                      [weakSelf setGameListIndex:segIndex gameList:[NSMutableArray arrayWithArray:listArray]];
                      
                      // update collection view
                      UICollectionView *collectionView = weakSelf.collectionViewArray[segIndex];
                      if (listArray) {
                        [collectionView reloadData];
                        
                        if ([listArray count]) {
                          NSIndexPath *firstIndex = [NSIndexPath indexPathForItem:0 inSection:0];
                          [collectionView scrollToItemAtIndexPath:firstIndex
                                                 atScrollPosition:UICollectionViewScrollPositionBottom
                                                         animated:NO];
                        }
                      }
                      [Tools performAfterDelay:STOP_PULLTOREFRESH_DELAY block:^{
                        [collectionView.pullToRefreshView stopAnimating];
                      }];
                      
                      // upate params
                      [weakSelf setLoadedOnceValueIndex:segIndex loadedOnce:YES];
                      
                    } failed:^(HDYSoccerAPIError *error) {
                      
                      // update collection view
                      UICollectionView *collectionView = weakSelf.collectionViewArray[segIndex];
                      [Tools performAfterDelay:STOP_PULLTOREFRESH_DELAY block:^{
                        [collectionView.pullToRefreshView stopAnimating];
                      }];
                      
                    }];
}
@end
