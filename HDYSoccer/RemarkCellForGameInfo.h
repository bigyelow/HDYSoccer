//
//  RemarkCellForGameInfo.h
//  HDYSoccer
//
//  Created by bigyelow on 7/30/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GAME_INFO_REMAR_CELL_ID @"gameInfoRemarkCell"

@interface RemarkCellForGameInfo : UITableViewCell

@property (nonatomic, assign) CGFloat remarksViewWidth;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITextView *remarksView;
@property (nonatomic, strong) UIView *seperator;

- (CGFloat)heightForCell:(NSString *)remarks;
@end
