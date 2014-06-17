//
//  RemarkCell.h
//  HDYSoccer
//
//  Created by bigyelow on 6/17/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CREATE_GAME_DETAIL_REMAR_CELL_ID @"remarkCell"
#define REMARK_CELL_FIELD_HEIGHT 150.0f

@interface RemarkCell : UITableViewCell

@property (nonatomic, strong) UITextView *textView;
@end
