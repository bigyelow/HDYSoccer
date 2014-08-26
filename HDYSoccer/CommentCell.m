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

// NAME
#define NAME_LEFT_MARGIN 20
#define NAME_TOP_MARGIN 25
#define NAME_HEIGHT 17

// CONTENT
#define CONTENT_TOP_MARGIN 0
#define CONTENT_LEFT_MARGIN 15
#define CONTENT_FONT_SIZE 16
#define CONTENT_LINE_SPACE 3

// TIME
#define TIME_TOP_MARGIN 10
#define TIME_HEIGHT 12

// REPLY
#define REPLY_TOP_MARGIN 6
#define REPLY_HEIGHT 17

#define CELL_BOTTOM_MARGIN 22

// SEPERATOR
#define SEPERATOR_HEIGHT 1
#define SEPERATOR_LEFT_MARGIN (NAME_LEFT_MARGIN - 10)

@implementation CommentCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    CGFloat contentWidth = WINDOW_FRAME.size.width - 2 * NAME_LEFT_MARGIN;
    CGFloat bottomY;
    
    // NAME
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(NAME_LEFT_MARGIN, NAME_TOP_MARGIN, contentWidth, NAME_HEIGHT)];
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
    [replyLabel setTextColor:[UIColor lightGrayColor]];
    
    CGFloat replyX = WINDOW_FRAME.size.width - NAME_LEFT_MARGIN - replyLabel.frame.size.width;
    CGFloat replyY = bottomY + REPLY_TOP_MARGIN;
    [UIConfiguration setView:replyLabel origin:CGPointMake(replyX, replyY)];
    [UIConfiguration setView:replyLabel height:REPLY_HEIGHT];
    
    self.replyLabel = replyLabel;
    [self addSubview:replyLabel];
    
    bottomY = CGRectGetMaxY(replyLabel.frame);
    
    // TIME
    CGFloat timeY = bottomY + TIME_TOP_MARGIN;
    UILabel *timeLabel = [[UILabel alloc] initWithFrame:CGRectMake(NAME_LEFT_MARGIN, timeY, 0, 0)];
    [timeLabel setTextColor:[UIColor lightGrayColor]];
    [timeLabel setFont:[UIFont systemFontOfSize:13]];
    
    self.timeLabel = timeLabel;
    [self addSubview:timeLabel];
    
    // SEPERATOR
    CGFloat seperY = bottomY + CELL_BOTTOM_MARGIN - SEPERATOR_HEIGHT;
    CGFloat seperWidth = WINDOW_FRAME.size.width - SEPERATOR_LEFT_MARGIN;
    UIView *seper = [[UIView alloc] initWithFrame:CGRectMake(SEPERATOR_LEFT_MARGIN, seperY, seperWidth, SEPERATOR_HEIGHT)];
    [seper setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR]];
    
    self.seper = seper;
    [self addSubview:seper];
}
  return self;
}

- (void)configCellWithComment:(Comment *)comment
                   cellHeight:(CGFloat)cellHeight
{
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
  [UIConfiguration setView:self.replyLabel y:replyY];
  
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
