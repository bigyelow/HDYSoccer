//
//  ReplyCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define REPLY_CELL_ID @"replyCell"

@class Reply;

@interface ReplyCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextView *content;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *replyImage;
@property (nonatomic, strong) UIView *seper;
@property (nonatomic, strong) UIImageView *avatar;

+ (CGFloat)cellHeightForContent:(NSString *)content;
- (void)configCellWithReply:(Reply *)reply
                 cellHeight:(CGFloat)cellHeight;
@end
