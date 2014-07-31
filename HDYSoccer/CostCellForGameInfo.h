//
//  CostCellForGameInfo.h
//  HDYSoccer
//
//  Created by bigyelow on 7/30/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GAME_INFO_COST_CELL_ID @"gameInfoCostCell"

@interface CostCellForGameInfo : UITableViewCell

@property (nonatomic, strong) UILabel *titleLabel;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              title:(NSString *)title;
- (void)updateWithTitle:(NSString *)title;
@end
