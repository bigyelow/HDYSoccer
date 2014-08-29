//
//  ChooseParticipantViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 8/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseTableViewController.h"

typedef NS_ENUM(NSUInteger, ChooseTableType) {
  kChooseTableTypeFriend,
  kChooseTableTypeTeam
};

@interface ChooseTableViewController : HDYSoccerBaseTableViewController

@property (nonatomic, assign) ChooseTableType type;
@property (nonatomic, strong) NSArray *friendsArray;
@property (nonatomic, strong) NSArray *teamsArray;
@property (nonatomic, strong) NSMutableArray *selectedArray;

- (id)initWithType:(ChooseTableType)type;
@end

