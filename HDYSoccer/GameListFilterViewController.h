//
//  GameListFilterViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 6/7/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseTableViewController.h"
#import "RMDateSelectionViewController.h"

// protocol
@protocol reloadGameListDelegate <NSObject>

- (void)reloadGameListWithParams:(NSDictionary *)params;
@end

// interface
@interface GameListFilterViewController : HDYSoccerBaseTableViewController
<RMDateSelectionViewControllerDelegate>

#define PARAM_DATE @"date"
#define PARAM_FIELD @"field"
@property (nonatomic, strong) NSDate *filterDate;
@property (nonatomic, strong) NSString *filterField;

@property (nonatomic, strong) id<reloadGameListDelegate> reloadGameListDelegate;
@end
