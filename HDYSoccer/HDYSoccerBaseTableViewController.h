//
//  HDYSoccerBaseTableViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 3/24/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseViewController.h"

@interface HDYSoccerBaseTableViewController : HDYSoccerBaseViewController
<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, assign) UITableViewStyle style;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, assign) BOOL enableTopPullToRefresh;
@property (nonatomic, assign) BOOL enableBottomPullToLoadMore;

- (id)initWithStyle:(UITableViewStyle)style;

#pragma mark - pull to refresh and load more
- (void)setEnableTopPullToRefresh:(BOOL)enableTopPullToRefresh
                    actionHandler:(void (^)(void))actionHandler;
- (void)setEnableBottomPullToLoadMore:(BOOL)enableBottomPullToLoadMore
                        actionHandler:(void (^)(void))actionHandler;
@end
