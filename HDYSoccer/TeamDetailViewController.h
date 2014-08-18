//
//  TeamDetailViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 8/18/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseTableViewController.h"
@class Team;

@interface TeamDetailViewController : HDYSoccerBaseTableViewController


@property (nonatomic, copy) NSString *teamID;
@property (nonatomic, copy) NSString *teamName;
@property (nonatomic, strong) Team *teamInfo;

@property (nonatomic, strong) UISegmentedControl *segControl;
@property (nonatomic, strong) UITableView *teamInfoTable;
@property (nonatomic, strong) UITableView *statisticsTable;

- (id)initWithTeamID:(NSString *)teamID teamName:(NSString *)teamName;
@end
