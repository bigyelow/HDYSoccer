//
//  ChooseTableCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define CHOOSE_TABLE_CELL_ID @"chooseTableCell"
#define CHOOSE_TABLE_CELL_HEIGHT 40

@interface ChooseTableCell : UITableViewCell

@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *nameLabel;

- (void)configCellWithImageURL:(NSString *)url
                          name:(NSString *)name;
@end
