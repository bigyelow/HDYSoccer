//
//  CostCell.h
//  HDYSoccer
//
//  Created by bigyelow on 6/16/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CREATE_GAEM_DETAIL_COST_CELL_ID @"costCell"

@interface CostCell : UITableViewCell

@property (nonatomic, strong) UITextField *textField;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              title:(NSString *)title;
@end
