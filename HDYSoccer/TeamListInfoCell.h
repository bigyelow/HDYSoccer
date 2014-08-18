//
//  TeamListInfoCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/18/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define TEAM_LIST_INFO_CELL_ID @"teamListInfoCell"
#define TEAM_LIST_INFO_CELL_HEIGHT 30

@interface TeamListInfoCell : UITableViewCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *infoLabel;
@property (nonatomic, strong) UIView *bottomSeper;

- (void)configCellWithTitle:(NSString *)title
                       info:(NSString *)info
              hasBottomLine:(BOOL)hasBottomLine;
@end
