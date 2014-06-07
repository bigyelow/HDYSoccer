//
//  HDYSoccerGameViewController+CollectionView.h
//  HDYSoccer
//
//  Created by bigyelow on 6/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameViewController.h"

@interface HDYSoccerGameViewController (CollectionView)

- (void)configCollectionViewWithCount:(NSInteger)count;
- (void)updateCollecionViewDisplayWithIndex:(NSInteger)index;

- (void)customPullToRefresh:(UIScrollView *)scrollView;

// params
- (NSMutableArray *)getGameListIndex:(NSInteger)index;
- (void)setGameListIndex:(NSInteger)index
                gameList:(NSMutableArray *)gameList;

- (BOOL)getLoadedOnceValueIndex:(NSInteger)index;
- (void)setLoadedOnceValueIndex:(NSInteger)index
                     loadedOnce:(BOOL)loadedOnce;

- (BOOL)getRefreshingIndex:(NSInteger)index;
- (void)setRefreshingValueIndex:(NSInteger)index
                     refreshing:(BOOL)refreshing;

- (BOOL)getLoadingMoreIndex:(NSInteger)index;
- (void)setLoadingMoreValueIndex:(NSInteger)index
                     loadingMore:(BOOL)loadingMore;
@end
