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

@protocol ChooseTableViewDelegate <NSObject>

- (void)confirmWithChooseTableSelectedArray:(NSArray *)selectedArray;

@end

@interface ChooseTableViewController : HDYSoccerBaseTableViewController

@property (nonatomic, assign) ChooseTableType type;
@property (nonatomic, strong) NSArray *friendsArray;
@property (nonatomic, strong) NSArray *teamsArray;
@property (nonatomic, strong) NSMutableArray *selectedArray;
@property (nonatomic, strong) id<ChooseTableViewDelegate> chooseTableDelegate;

- (id)initWithType:(ChooseTableType)type
           delegae:(id<ChooseTableViewDelegate>)delegate;
@end

