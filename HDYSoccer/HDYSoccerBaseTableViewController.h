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

- (id)initWithStyle:(UITableViewStyle)style;
@end
