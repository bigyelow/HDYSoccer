//
//  CommentCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CommentCell.h"
#import "Comment.h"
#import "UITextView+Helper.h"
#import "UIImageView+WebCache.h"

#define GRAY_COLOR_FOR_COMMENT @"#c8c8c8"

// AVATAR
#define AVATAR_LEFT_MARGIN 20
#define AVATAR_TOP_MARGIN 23
#define AVATAR_HEIGHT 20

// NAME
#define NAME_LEFT_MARGIN 10
#define NAME_TOP_MARGIN 25
#define NAME_HEIGHT 17

// CONTENT
#define CONTENT_TOP_MARGIN 4
#define CONTENT_LEFT_MARGIN 15
#define CONTENT_FONT_SIZE 16
#define CONTENT_LINE_SPACE 3

// TIME
#define TIME_TOP_MARGIN 10
#define TIME_HEIGHT 12
#define TIME_LEFT_MARGIN (AVATAR_LEFT_MARGIN + 1)

// REPLY
#define REPLY_TOP_MARGIN 6
#define REPLY_HEIGHT 17
#define REPLY_RIGHT_MARGIN TIME_LEFT_MARGIN

#define CELL_BOTTOM_MARGIN 22

// REPLY IMAGE
#define REPLY_IMAGE_RIGHT_MARGIN 5
#define REPLY_IMAGE_TOP_MARGIN 4
#define REPLY_IMAGE_HEIGHT 20

// SEPERATOR
#define SEPERATOR_HEIGHT 0.5
#define SEPERATOR_LEFT_MARGIN (TIME_LEFT_MARGIN - 10)

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    CGFloat contentWidth = WINDOW_FRAME.size.width - 2 * NAME_LEFT_MARGIN;
    CGFloat bottomY;
    
    // AVATAR
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(AVATAR_LEFT_MARGIN, AVATAR_TOP_MARGIN, AVATAR_HEIGHT, AVATAR_HEIGHT)];
    [avatar setBackgroundColor:[UIConfiguration colorForHex:GRAY_COLOR_FOR_COMMENT]];
    [avatar.layer setCornerRadius:4];
    [avatar setClipsToBounds:YES];
    
    self.avatar = avatar;
    [self addSubview:avatar];
    
    // NAME
    CGFloat nameX = CGRectGetMaxX(avatar.frame) + NAME_LEFT_MARGIN;
    CGFloat nameWidth = contentWidth - nameX;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, NAME_TOP_MARGIN, nameWidth, NAME_HEIGHT)];
    [nameLabel setFont:[UIFont systemFontOfSize:CONTENT_FONT_SIZE]];
 
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    
    bottomY = CGRectGetMaxY(nameLabel.frame);
    
    // CONTENT
    CGFloat contentY = bottomY + CONTENT_TOP_MARGIN;
    UITextView *content = [[UITextView alloc] initWithFrame:CGRectMake(CONTENT_LEFT_MARGIN, contentY, contentWidth, 0)];
    [content setScrollEnabled:NO];
    [content setEditable:NO];
    [content setTextAlignment:NSTextAlignmentLeft];
    
    self.content = content;
    [self addSubview:content];
    
    bottomY = CGRectGetMaxY(content.frame);

    // Reply
    UILabel *replyLabel = [UIConfiguration labelWithText:TEXT_REPLY
                                               textColor:[UIColor blackColor]
                                                    font:[UIFont systemFontOfSize:16]
                                           numberOfLines:1];
    [replyLabel setTextColor:[UIConfiguration colorForHex:GRAY_COLOR_FOR_COMMENT]];
    
    CGFloat replyX = WINDOW_FRAME.size.width - REPLY_RIGHT_MARGIN - replyLabel.frame.size.width;
    CGFloat replyY = bottomY + REPLY_TOP_MARGIN;
    CGFloat replyImageY = bottomY + REPLY_IMAGE_TOP_MARGIN;
    [UIConfiguration setView:replyLabel origin:CGPointMake(replyX, replyY)];
    [UIConfiguration setView:replyLabel height:REPLY_HEIGHT];
    
    self.replyLabel = replyLabel;
    [self addSubview:replyLabel];
    
    bottomY = CGRectGetMaxY(replyLabel.frame);
    
    // Reply image
    CGFloat replyImageX = CGRectGetMinX(replyLabel.frame) - REPLY_IMAGE_RIGHT_MARGIN - REPLY_IMAGE_HEIGHT;
    UIImageView *replyImage = [[UIImageView alloc] initWithFrame:CGRectMake(replyImageX, replyImageY, REPLY_IMAGE_HEIGHT, REPLY_IMAGE_HEIGHT)];
    [replyImage setImage:[UIImage imageNamed:@"left2-50.png"]];
    
    self.replyImage = replyImage;
    [self addSubview:replyImage];
    
    // TIME
    CGFloat timeY = bottomY + TIME_TOP_MARGIN;
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(TIME_LEFT_MARGIN, timeY, 0, 0)];
    [timeLabel setTextColor:[UIConfiguration colorForHex:GRAY_COLOR_FOR_COMMENT]];
    [timeLabel setFont:[UIFont systemFontOfSize:13]];
    
    self.timeLabel = timeLabel;
    [self addSubview:timeLabel];
    
    // SEPERATOR
    CGFloat seperY = bottomY + CELL_BOTTOM_MARGIN - SEPERATOR_HEIGHT;
    CGFloat seperWidth = WINDOW_FRAME.size.width - SEPERATOR_LEFT_MARGIN;
    UIView *seper = [[UIView alloc] initWithFrame:CGRectMake(SEPERATOR_LEFT_MARGIN, seperY, seperWidth, SEPERATOR_HEIGHT)];
    [seper setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR_CLEAR]];
    
    self.seper = seper;
    [self addSubview:seper];
}
  return self;
}

- (void)configCellWithComment:(Comment *)comment
                   cellHeight:(CGFloat)cellHeight
{
  if (![Tools isNilOrEmpty:comment.avatarURL]) {
    [self.avatar setImageWithURL:[NSURL URLWithString:comment.avatarURL]];
  }
  else {
    [self.avatar setImage:[UIImage imageNamed:@"user_male-25.png"]];
  }
  [self.nameLabel setText:comment.userName];
  
  // CONTENT
  UIFont *font = [UIFont systemFontOfSize:CONTENT_FONT_SIZE];
  [self.content setAttributedText:comment.content font:font lineSpace:CONTENT_LINE_SPACE];

  CGFloat contentWidth = WINDOW_FRAME.size.width - 2 * CONTENT_LEFT_MARGIN;
  CGFloat contentHeight = cellHeight - NAME_TOP_MARGIN - NAME_HEIGHT
  - CONTENT_TOP_MARGIN
  - REPLY_TOP_MARGIN - REPLY_HEIGHT
  - CELL_BOTTOM_MARGIN;
  [UIConfiguration setView:self.content size:CGSizeMake(contentWidth, contentHeight)];
  
  // TIME
  CGFloat timeY = CGRectGetMaxY(self.content.frame) + TIME_TOP_MARGIN;
  [self.timeLabel setText:[Tools dateminuteToStr:comment.time preferUTC:NO]];
  [self.timeLabel sizeToFit];
  [UIConfiguration setView:self.timeLabel height:TIME_HEIGHT];
  [UIConfiguration setView:self.timeLabel y:timeY];

  CGFloat replyY = CGRectGetMaxY(self.content.frame) + REPLY_TOP_MARGIN;
  CGFloat replyImageY = CGRectGetMaxY(self.content.frame) + REPLY_IMAGE_TOP_MARGIN;
  [UIConfiguration setView:self.replyLabel y:replyY];
  [UIConfiguration setView:self.replyImage y:replyImageY];
  
  CGFloat seperY = CGRectGetMaxY(self.replyLabel.frame) + CELL_BOTTOM_MARGIN - SEPERATOR_HEIGHT;
  [UIConfiguration setView:self.seper y:seperY];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

+ (CGFloat)cellHeightForContent:(NSString *)content
{
  CGFloat height = NAME_TOP_MARGIN + NAME_HEIGHT
  + CONTENT_TOP_MARGIN
  + REPLY_TOP_MARGIN + REPLY_HEIGHT
  + CELL_BOTTOM_MARGIN;
  
  UITextView *textView = [[UITextView alloc] init];
  UIFont *font = [UIFont systemFontOfSize:CONTENT_FONT_SIZE];
  [textView setAttributedText:content font:font lineSpace:CONTENT_LINE_SPACE];
  
  CGFloat textViewWidth = WINDOW_FRAME.size.width - 2 * CONTENT_LEFT_MARGIN;
  CGSize textSize = [textView sizeThatFits:CGSizeMake(textViewWidth, MAXFLOAT)];
  
  return height + textSize.height;
}

@end
