//
//  CommentBar.m
//  HDYSoccer
//
//  Created by bigyelow on 8/25/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CommentBar.h"

// UP LABEL
#define UP_LABEL_LEFT_MARGIN 10
#define UP_LABEL_TOP_MARGIN 10

// COMMENT
#define COMMENT_LEFT_MARGIN 10
#define COMMENT_TOP_MARGIN 10

// COUNT
#define COUNT_LEFT_MARGIN 10

@implementation CommentBar

- (id)initWithFrame:(CGRect)frame
      commentsCount:(NSInteger)commentsCount
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIColor whiteColor]];
    
    // UP LABEL
    CGFloat upHeight = COMMENT_BAR_HEIGHT - 2 * UP_LABEL_TOP_MARGIN;
    UIImageView *upView = [[UIImageView alloc]  initWithFrame:CGRectMake(UP_LABEL_LEFT_MARGIN, 0, upHeight, upHeight)];
    [upView setImage:[UIImage imageNamed:@"up4-75.png"]];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:upView];
    
    [self addSubview:upView];
    
     // COMMENT IMAGE
    CGFloat commentHeight = COMMENT_BAR_HEIGHT - 2 * COMMENT_TOP_MARGIN;
    CGFloat commentX = frame.size.width - COMMENT_LEFT_MARGIN - commentHeight;
    UIImageView *commentView = [[UIImageView alloc] initWithFrame:CGRectMake(commentX, 0, commentHeight, commentHeight)];
    [commentView setImage:[UIImage imageNamed:@"speech_bubble-50.png"]];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:commentView];
    
    [self addSubview:commentView];
    
    // COMMENTS COUNT LABEL
    CGFloat countX = CGRectGetMaxX(upView.frame) + COUNT_LEFT_MARGIN;
    UILabel *countLabel = [UIConfiguration labelWithText:[NSString stringWithFormat:TEXT_COMMENT_COUNT, commentsCount]
                                               textColor:[UIColor lightGrayColor]
                                                    font:[UIFont systemFontOfSize:14]
                                           numberOfLines:1];
    [UIConfiguration setView:countLabel x:countX];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:countLabel];
    
    [self addSubview:countLabel];
  }
  return self;
}

/*
 // Only override drawRect: if you perform custom drawing.
 // An empty implementation adversely affects performance during animation.
 - (void)drawRect:(CGRect)rect
 {
 // Drawing code
 }
 */

@end
