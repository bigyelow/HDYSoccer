//
//  TeamMemberCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/18/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SimpleGeekerInfo;

#define TEAM_MEMBER_CELL_ID @"teamMemberCell"
#define TEAM_MEMBER_CELL_HEIGHT 70

@interface TeamMemberCell : UITableViewCell
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) NSArray *tagsArray;

- (void)configWithPlayerInfo:(SimpleGeekerInfo *)info;
@end
