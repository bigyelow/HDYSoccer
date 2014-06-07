//
//  HDYSoccerGameViewController+CollectionView.m
//  HDYSoccer
//
//  Created by bigyelow on 6/5/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GameViewParams.h"
#import "HDYSoccerGameViewController+CollectionView.h"
#import "HDYSoccerGameViewController+NetWork.h"
#import "HDYSoccerGameViewController+SegmentControl.h"
#import "SVPullToRefresh.h"
#import "UIConfiguration+Color.h"
#import "HDYSoccerGameCell.h"

@implementation HDYSoccerGameViewController (CollectionView)

- (void)configCollectionViewWithCount:(NSInteger)count
{
  NSMutableArray *temp = [NSMutableArray array];
  for (int i = 0; i < count; ++i) {
    UICollectionView *collectView = [self createCollectionView];
    [temp addObject:collectView];
    [self.view addSubview:collectView];
  }
  self.collectionViewArray = [NSArray arrayWithArray:temp];
  
  [self updateCollectionViewLayout];
  
  // config params
  [self initCollectionViewParams];
}

- (UICollectionView *)createCollectionView
{
  CHTCollectionViewWaterfallLayout *layout = [[CHTCollectionViewWaterfallLayout alloc] init];
  
  layout.sectionInset = SECTION_INSET;
  layout.headerHeight = HEADER_HEIGHT;
  layout.footerHeight = FOOTER_HEIGHT;
  layout.minimumColumnSpacing = MINIMUM_COLUMN_SPACE;
  layout.minimumInteritemSpacing = MINIMUM_INTERITEM_SPACE;
  
  CGFloat collectionY = self.segControl.frame.size.height;
  CGFloat collectionHeight = self.view.frame.size.height - self.segControl.frame.size.height;
  CGRect collectionRect = CGRectMake(0, collectionY, self.view.bounds.size.width, collectionHeight);
  UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionRect collectionViewLayout:layout];
  
  [collectionView setBackgroundColor:[UIColor whiteColor]];
  collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  collectionView.dataSource = self;
  collectionView.delegate = self;
  [collectionView registerClass:[HDYSoccerGameCell class]
     forCellWithReuseIdentifier:GAME_CELL_IDENTIFIER];
  
  // pull to refresh
  __weak typeof(self) weakSelf = self;
  [collectionView addPullToRefreshWithActionHandler:^{
    NSInteger segIndex = weakSelf.segControl.selectedSegmentIndex;
    BOOL loadingMore = [weakSelf getLoadingMoreIndex:segIndex];

    if (!loadingMore) {
      [weakSelf setRefreshingValueIndex:segIndex refreshing:YES];
      
      NSString *time = @"";
      NSString *field = @"";
      NSInteger start = 0;
      [weakSelf loadGameListWithSegIndex:segIndex
                                    time:time
                                   field:field
                                   start:start];
    }
  }];
  
  // load more
  [collectionView addInfiniteScrollingWithActionHandler:^{
    NSInteger segIndex = weakSelf.segControl.selectedSegmentIndex;
    BOOL refreshing = [weakSelf getRefreshingIndex:segIndex];
    
    if (!refreshing) {
      [weakSelf setLoadingMoreValueIndex:segIndex loadingMore:YES];
      
      NSString *time = @"";
      NSString *field = @"";
      NSInteger start = [[weakSelf getGameListIndex:segIndex] count];
      [weakSelf loadMoreGameListWithSegIndex:segIndex
                                        time:time
                                       field:field
                                       start:start];
    }
  }];
  
  [self customPullToRefresh:collectionView];
  
  return collectionView;
}

#define TEXT_PULL_TO_REFRESH @"下拉刷新"
#define TEXT_RELEASE_TO_REFRESH @"松开刷新"
#define REFRESH_TITLE_FONT_SIZE 13.0f
#define REFRESH_ARROW_COLOR @"#dfdfdf"
#define REFRESH_X_PLUS 35.0f

- (void)customPullToRefresh:(UIScrollView *)scrollView
{
  [scrollView.pullToRefreshView setTitle:TEXT_PULL_TO_REFRESH forState:SVPullToRefreshStateStopped];
  [scrollView.pullToRefreshView setTitle:TEXT_RELEASE_TO_REFRESH forState:SVPullToRefreshStateTriggered];
  [scrollView.pullToRefreshView.titleLabel setFont:[UIFont systemFontOfSize:REFRESH_TITLE_FONT_SIZE]];
  
  CGFloat centerX = scrollView.center.x + REFRESH_X_PLUS;
  CGFloat centerY = scrollView.pullToRefreshView.center.y;
  [scrollView.pullToRefreshView setCenter:CGPointMake(centerX, centerY)];
  [scrollView.pullToRefreshView setArrowColor:[UIConfiguration colorForHex:REFRESH_ARROW_COLOR]];
}

- (void)updateCollecionViewDisplayWithIndex:(NSInteger)index
{
  // collectionView[index] is to be displayed
  for (int i = 0; i < [self.collectionViewArray count]; ++i) {
    UICollectionView *view = self.collectionViewArray[i];
    if (i == index) {
      [view setHidden:NO];
    }
    else {
      [view setHidden:YES];
    }
  }
}

#pragma mark - params management

#define PARAM_LOADED_ONCE @"loadedOnce"
#define PARAM_GAMELIST @"gameList"
#define PARAM_REFRESHING @"refreshing"
#define PARAM_LOADING_MORE @"loadingMore"

- (void)initCollectionViewParams
{
  NSMutableArray *tempArray = [NSMutableArray array];
  for (int i = 0; i < [self.collectionViewArray count]; ++i) {
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    [tempDic setObject:[NSNumber numberWithBool:NO] forKey:PARAM_LOADED_ONCE];
    [tempDic setObject:[NSMutableArray array] forKey:PARAM_GAMELIST];
    [tempDic setObject:[NSNumber numberWithBool:NO] forKey:PARAM_REFRESHING];
    [tempDic setObject:[NSNumber numberWithBool:NO] forKey:PARAM_LOADING_MORE];
    
    [tempArray addObject:tempDic];
  }
  
  self.collectionViewParams = [NSArray arrayWithArray:tempArray];
}

// game list array
- (NSMutableArray *)getGameListIndex:(NSInteger)index
{
  NSMutableDictionary *dic = self.collectionViewParams[index];
  NSMutableArray *gameList = [dic objectForKey:PARAM_GAMELIST];
  return gameList;
}

- (void)setGameListIndex:(NSInteger)index
                gameList:(NSMutableArray *)gameList
{
  NSMutableDictionary *dic = self.collectionViewParams[index];
  [dic setObject:gameList forKey:PARAM_GAMELIST];
}

// loaded once
- (BOOL)getLoadedOnceValueIndex:(NSInteger)index
{
  NSMutableDictionary *dic = self.collectionViewParams[index];
  NSNumber *loadedOnce = [dic objectForKey:PARAM_LOADED_ONCE];
  return loadedOnce.boolValue;
}


- (void)setLoadedOnceValueIndex:(NSInteger)index
                     loadedOnce:(BOOL)loadedOnce
{
  NSMutableDictionary *dic = self.collectionViewParams[index];
  [dic setObject:[NSNumber numberWithBool:loadedOnce] forKey:PARAM_LOADED_ONCE];
}

// refreshing
- (BOOL)getRefreshingIndex:(NSInteger)index
{
  NSMutableDictionary *dic = self.collectionViewParams[index];
  NSNumber *refreshing = [dic objectForKey:PARAM_REFRESHING];
  return refreshing.boolValue;
}

- (void)setRefreshingValueIndex:(NSInteger)index
                     refreshing:(BOOL)refreshing
{
  NSMutableDictionary *dic = self.collectionViewParams[index];
  [dic setObject:[NSNumber numberWithBool:refreshing] forKey:PARAM_REFRESHING];
}

// loading more
- (BOOL)getLoadingMoreIndex:(NSInteger)index
{
  NSMutableDictionary *dic = self.collectionViewParams[index];
  NSNumber *loadingMore = [dic objectForKey:PARAM_LOADING_MORE];
  return loadingMore.boolValue;
}

- (void)setLoadingMoreValueIndex:(NSInteger)index
                     loadingMore:(BOOL)loadingMore
{
  NSMutableDictionary *dic = self.collectionViewParams[index];
  [dic setObject:[NSNumber numberWithBool:loadingMore] forKey:PARAM_LOADING_MORE];
}

@end
