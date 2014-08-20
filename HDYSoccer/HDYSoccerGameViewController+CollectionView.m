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
#import "HDYSoccerGameHeader.h"
#import "FXBlurView.h"
#import "PersonalGameCell.h"
#import "TeamGameCell.h"

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
  
  layout.sectionInset = UIEdgeInsetsZero;
  layout.headerHeight = 0;
  layout.footerHeight = FOOTER_HEIGHT;
  layout.minimumColumnSpacing = MINIMUM_COLUMN_SPACE;
  layout.minimumInteritemSpacing = MINIMUM_INTERITEM_SPACE;
  
  CGFloat collectionY = 0;
  CGFloat collectionHeight = self.view.frame.size.height;
  CGRect collectionRect = CGRectMake(0, collectionY, self.view.bounds.size.width, collectionHeight);
  UICollectionView *collectionView = [[UICollectionView alloc] initWithFrame:collectionRect collectionViewLayout:layout];
  
  [collectionView setBackgroundColor:[UIColor clearColor]];
  collectionView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
  [collectionView setContentInset:SECTION_INSET];
  [collectionView setScrollIndicatorInsets:UIEdgeInsetsMake(SEGMENT_VIEW_HEIGHT, 0, 0, 0)];
  collectionView.dataSource = self;
  collectionView.delegate = self;
  [collectionView registerClass:[PersonalGameCell class] forCellWithReuseIdentifier:PERSONAL_GAME_CELL_ID];
  [collectionView registerClass:[TeamGameCell class] forCellWithReuseIdentifier:TEAM_GAME_CELL_ID];
  
  // back ground
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
  [imageView setImage:[UIImage imageNamed:GAME_LIST_PERSONAL_BACKGROUND_IMAGE]];
  [collectionView setBackgroundView:imageView];
  
  // pull to refresh
  __weak typeof(self) weakSelf = self;
  [collectionView addPullToRefreshWithActionHandler:^{
    NSInteger segIndex = weakSelf.segControl.selectedSegmentIndex;
    BOOL refreshing = [weakSelf getRefreshingIndex:segIndex];
    BOOL loadingMore = [weakSelf getLoadingMoreIndex:segIndex];

    if (!loadingMore && !refreshing) {
      [weakSelf setRefreshingValueIndex:segIndex refreshing:YES];
      [weakSelf.filterItem setEnabled:NO];
      
      NSDate *time = [weakSelf getFilterParamTime:segIndex];
      NSString *field = [weakSelf getFilterParamField:segIndex];
      NSInteger start = 0;
      [weakSelf loadGameListWithSegIndex:segIndex
                                    time:[Tools dateminuteToStr:time preferUTC:NO]
                                   field:field
                                   start:start];
    }
  }];
  
  // load more
  [collectionView addInfiniteScrollingWithActionHandler:^{
    NSInteger segIndex = weakSelf.segControl.selectedSegmentIndex;
    BOOL refreshing = [weakSelf getRefreshingIndex:segIndex];
    BOOL loadingMore = [weakSelf getLoadingMoreIndex:segIndex];
    
    if (!refreshing && !loadingMore) {
      [weakSelf setLoadingMoreValueIndex:segIndex loadingMore:YES];
      [weakSelf.filterItem setEnabled:NO];
      
      NSDate *time = [weakSelf getFilterParamTime:segIndex];
      NSString *field = [weakSelf getFilterParamField:segIndex];
      NSInteger start = [[weakSelf getGameListIndex:segIndex] count];
      [weakSelf loadMoreGameListWithSegIndex:segIndex
                                        time:[Tools dateminuteToStr:time preferUTC:NO]
                                       field:field
                                       start:start];
    }
  }];
  
  [self customPullToRefresh:collectionView];
  
  return collectionView;
}

- (void)customPullToRefresh:(UIScrollView *)scrollView
{
  [scrollView.pullToRefreshView setTitle:PTREFRESH_TEXT_PULL_TO_REFRESH forState:SVPullToRefreshStateStopped];
  [scrollView.pullToRefreshView setTitle:PTREFRESH_TEXT_RELEASE_TO_REFRESH forState:SVPullToRefreshStateTriggered];
  [scrollView.pullToRefreshView setTitle:TEXT_LOADING forState:SVPullToRefreshStateLoading];
  [scrollView.pullToRefreshView.titleLabel setTextColor:[UIConfiguration colorForHex:PTREFRESH_TITLE_COLOR]];
  [scrollView.pullToRefreshView.titleLabel setFont:[UIFont systemFontOfSize:PTREFRESH_REFRESH_TITLE_FONT_SIZE]];
  [scrollView.pullToRefreshView setArrowColor:[UIConfiguration colorForHex:PTREFRESH_ARROW_COLOR]];
  
  [scrollView.pullToRefreshView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];
  [scrollView.infiniteScrollingView setActivityIndicatorViewStyle:UIActivityIndicatorViewStyleWhite];

  CGFloat centerX = scrollView.center.x + PTREFRESH_REFRESH_X_PLUS;
  CGFloat centerY = scrollView.pullToRefreshView.center.y;
  [scrollView.pullToRefreshView setCenter:CGPointMake(centerX, centerY)];
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
#define PARAM_FILTER_LIMIT_TIME @"filterTime"
#define PARAM_FILTER_LIMIT_FIELD @"filterField"

- (void)initCollectionViewParams
{
  NSMutableArray *tempArray = [NSMutableArray array];
  for (int i = 0; i < [self.collectionViewArray count]; ++i) {
    NSMutableDictionary *tempDic = [NSMutableDictionary dictionary];
    // collection view datasource
    [tempDic setObject:[NSMutableArray array] forKey:PARAM_GAMELIST];

    // collection view load status
    [tempDic setObject:[NSNumber numberWithBool:NO] forKey:PARAM_LOADED_ONCE];
    [tempDic setObject:[NSNumber numberWithBool:NO] forKey:PARAM_REFRESHING];
    [tempDic setObject:[NSNumber numberWithBool:NO] forKey:PARAM_LOADING_MORE];
    
    // collection view filter params
    [tempDic setObject:[NSDate date] forKey:PARAM_FILTER_LIMIT_TIME];
    [tempDic setObject:@"" forKey:PARAM_FILTER_LIMIT_FIELD];
    
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

// filter time
- (NSDate *)getFilterParamTime:(NSInteger)index
{
  NSMutableDictionary *dic = self.collectionViewParams[index];
  return [dic objectForKey:PARAM_FILTER_LIMIT_TIME];
}

- (void)setfilterParam:(NSInteger)index
                  date:(NSDate *)date
{
  NSMutableDictionary *dic = self.collectionViewParams[index];
  [dic setObject:date forKey:PARAM_FILTER_LIMIT_TIME];
}

// filter field
- (NSString *)getFilterParamField:(NSInteger)index
{
  NSMutableDictionary *dic = self.collectionViewParams[index];
  return [dic objectForKey:PARAM_FILTER_LIMIT_FIELD];
}

- (void)setfilterParam:(NSInteger)index
                 field:(NSString *)field
{
  NSMutableDictionary *dic = self.collectionViewParams[index];
  [dic setObject:field forKey:PARAM_FILTER_LIMIT_FIELD];
}

@end
