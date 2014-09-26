//
//  HDYSoccerGeekerViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 3/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseTableViewController.h"
#import "HDYSoccerGeekerDetailViewController.h"

@interface HDYSoccerGeekerViewController : HDYSoccerBaseTableViewController <HDYSoccerGeekerEditDelegate>

@property (nonatomic, strong) UISegmentedControl *segControl;

// geekers
@property (nonatomic, strong) UIRefreshControl *playerRefreshControl;
@property (nonatomic, assign) BOOL geekersLoadedOnce;
@property (nonatomic, strong) NSMutableArray *geekersArray;
@property (nonatomic, strong) UITableView *geekerTable;

// team
@property (nonatomic, strong) UIRefreshControl *teamRefreshControl;
@property (nonatomic, assign) BOOL teamLoadedOnce;
@property (nonatomic, strong) NSMutableArray *teamsArray;
@property (nonatomic, strong) UITableView *teamTable;

@property (nonatomic, assign) UITableViewStyle style;
- (id)initWithStyle:(UITableViewStyle)style;
@end
