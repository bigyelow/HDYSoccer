//
//  GeekerListCell.h
//  HDYSoccer
//
//  Created by bigyelow on 7/2/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define GEEKER_LIST_CELL_HEIGHT 80.0f

@class SimpleGeekerInfo;

@interface GeekerListCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIImageView *avatar;
@property (nonatomic, strong) UILabel *scoreLabel;
@property (nonatomic, strong) UILabel *tagLabel;
@property (nonatomic, strong) UILabel *positionLabel;

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
         geekerInfo:(SimpleGeekerInfo *)geekerInfo;
@end
