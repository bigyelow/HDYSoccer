//
//  ReplyCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ReplyCell.h"
#import "Reply.h"
#import "UITextView+Helper.h"
#import "UIImageView+WebCache.h"

#define GRAY_COLOR_FOR_REPLY @"#c8c8c8"

// REPLY IMAGE
#define REPLY_IMAGE_LEFT_MARGIN 30
#define REPLY_IMAGE_TOP_MARGIN 23
#define REPLY_IMAGE_HEIGHT 20

// AVATAR
#define AVATAR_LEFT_MARGIN 20
#define AVATAR_TOP_MARGIN REPLY_IMAGE_TOP_MARGIN
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

#define CELL_BOTTOM_MARGIN 22

// SEPERATOR
#define SEPERATOR_HEIGHT 0.5
#define SEPERATOR_LEFT_MARGIN (TIME_LEFT_MARGIN - 10)

@implementation ReplyCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    CGFloat contentWidth = WINDOW_FRAME.size.width - 2 * NAME_LEFT_MARGIN;
    CGFloat bottomY;
    
    // Reply image
    UIImageView *replyImage = [[UIImageView alloc] initWithFrame:
                               CGRectMake(REPLY_IMAGE_LEFT_MARGIN, REPLY_IMAGE_TOP_MARGIN, REPLY_IMAGE_HEIGHT, REPLY_IMAGE_HEIGHT)];
    [replyImage setImage:[UIImage imageNamed:@"right2-50.png"]];
    
    self.replyImage = replyImage;
    [self addSubview:replyImage];
    
    // AVATAR
    CGFloat avatarX = CGRectGetMaxX(replyImage.frame) + AVATAR_LEFT_MARGIN;
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(avatarX, AVATAR_TOP_MARGIN, AVATAR_HEIGHT, AVATAR_HEIGHT)];
    [avatar setBackgroundColor:[UIConfiguration colorForHex:GRAY_COLOR_FOR_REPLY]];
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
    CGFloat contentX = CGRectGetMaxX(replyImage.frame) + CONTENT_LEFT_MARGIN;
    UITextView *content = [[UITextView alloc] initWithFrame:CGRectMake(contentX, contentY, contentWidth, 0)];
    [content setScrollEnabled:NO];
    [content setEditable:NO];
    [content setTextAlignment:NSTextAlignmentLeft];
    
    self.content = content;
    [self addSubview:content];
    
    bottomY = CGRectGetMaxY(content.frame);
    
    // TIME
    CGFloat timeY = bottomY + TIME_TOP_MARGIN;
    CGFloat timeX = CGRectGetMaxX(replyImage.frame) + TIME_LEFT_MARGIN;
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(timeX, timeY, 0, 0)];
    [timeLabel setTextColor:[UIConfiguration colorForHex:GRAY_COLOR_FOR_REPLY]];
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

- (void)configCellWithReply:(Reply *)reply
                 cellHeight:(CGFloat)cellHeight
{
  if (![Tools isNilOrEmpty:reply.avatarURL]) {
    [self.avatar setImageWithURL:[NSURL URLWithString:reply.avatarURL]];
  }
  else {
    [self.avatar setImage:[UIImage imageNamed:@"user_male-25.png"]];
  }
  [self.nameLabel setText:reply.userName];
  
  // CONTENT
  UIFont *font = [UIFont systemFontOfSize:CONTENT_FONT_SIZE];
  [self.content setAttributedText:reply.content font:font lineSpace:CONTENT_LINE_SPACE];
  
  CGFloat contentWidth = WINDOW_FRAME.size.width - 2 * CONTENT_LEFT_MARGIN;
  CGFloat contentHeight = cellHeight - NAME_TOP_MARGIN - NAME_HEIGHT
  - CONTENT_TOP_MARGIN
  - TIME_TOP_MARGIN - TIME_HEIGHT
  - CELL_BOTTOM_MARGIN;
  [UIConfiguration setView:self.content size:CGSizeMake(contentWidth, contentHeight)];
  
  // TIME
  CGFloat timeY = CGRectGetMaxY(self.content.frame) + TIME_TOP_MARGIN;
  [self.timeLabel setText:[Tools dateminuteToStr:reply.time preferUTC:NO]];
  [self.timeLabel sizeToFit];
  [UIConfiguration setView:self.timeLabel height:TIME_HEIGHT];
  [UIConfiguration setView:self.timeLabel y:timeY];
  
  CGFloat seperY = CGRectGetMaxY(self.timeLabel.frame) + CELL_BOTTOM_MARGIN - SEPERATOR_HEIGHT;
  [UIConfiguration setView:self.seper y:seperY];
}


+ (CGFloat)cellHeightForContent:(NSString *)content
{
  CGFloat height = NAME_TOP_MARGIN + NAME_HEIGHT
  + CONTENT_TOP_MARGIN
  + TIME_TOP_MARGIN + TIME_HEIGHT
  + CELL_BOTTOM_MARGIN;
  
  UITextView *textView = [[UITextView alloc] init];
  UIFont *font = [UIFont systemFontOfSize:CONTENT_FONT_SIZE];
  [textView setAttributedText:content font:font lineSpace:CONTENT_LINE_SPACE];
  
  CGFloat textViewWidth = WINDOW_FRAME.size.width - 2 * CONTENT_LEFT_MARGIN;
  CGSize textSize = [textView sizeThatFits:CGSizeMake(textViewWidth, MAXFLOAT)];
  
  return height + textSize.height;
}

- (void)awakeFromNib
{
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
