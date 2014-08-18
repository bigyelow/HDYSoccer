//
//  HDYSoccerGeekerDetailViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 3/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseTableViewController.h"
@class Geeker;
@interface HDYSoccerGeekerDetailViewController : HDYSoccerBaseTableViewController

@property (nonatomic, strong) NSString *playerName;
@property (nonatomic, strong) NSString *playerID;
@property (nonatomic, strong) Geeker *playerInfo;
@property (nonatomic, strong) NSArray *tagsPositionArray;

@property (nonatomic, strong) NSArray *comprehensiveAbilityArray;
@property (nonatomic, strong) NSArray *skillAbilityArray;
@property (nonatomic, strong) NSArray *qualityAbilityArray;
@property (nonatomic, strong) NSMutableArray *compreAbilityScoreAnimationArray;
@property (nonatomic, strong) NSMutableArray *skillAbilityScoreAnimationArray;
@property (nonatomic, strong) NSMutableArray *qualityAbilityScoreAnimationArray;

@property (nonatomic, strong) UISegmentedControl *segControl;
@property (nonatomic, strong) UITableView *playerInfoTable;
@property (nonatomic, strong) UITableView *StatisticsTable;

- (id)initWithPlayerID:(NSString *)playerID
            playerName:(NSString *)playerName;
@end
