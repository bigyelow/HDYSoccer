//
//  CommentCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COMMENT_CELL_ID @"commentCell"

@class Comment;

@interface CommentCell : UITableViewCell

@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UITextView *content;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UIImageView *replyView;
@property (nonatomic, strong) UILabel *replyLabel;
@property (nonatomic, strong) UIView *seper;

- (void)configCellWithComment:(Comment *)comment
                   cellHeight:(CGFloat)cellHeight;
+ (CGFloat)cellHeightForContent:(NSString *)content;
@end
