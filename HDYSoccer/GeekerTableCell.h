//
//  GeekerTableCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/9/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GEEKER_TABLE_CELL_ID @"geekerTableCell"
#define GEEKER_TABLE_CELL_HEIGHT 90

@class SimpleGeekerInfo;

@interface GeekerTableCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) NSArray *tagsArray;

- (void)configWithPlayerInfo:(SimpleGeekerInfo *)info;
@end
