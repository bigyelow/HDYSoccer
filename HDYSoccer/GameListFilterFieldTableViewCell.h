//
//  GameListFilterFieldTableViewCell.h
//  HDYSoccer
//
//  Created by bigyelow on 7/19/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface GameListFilterFieldTableViewCell : UITableViewCell

@property (nonatomic, strong) UILabel *fieldLabel;

- (void)configCellWithField:(NSString *)field;

@end
