//
//  CommentField.m
//  HDYSoccer
//
//  Created by bigyelow on 8/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CommentField.h"

// TEXT FIELD
#define TEXT_FIELD_BOTTOM_MARGIN 11
#define TEXT_FIELD_TOP_MARIGN 10
#define TEXT_FIELD_LEFT_MARGIN 10
#define TEXT_FIELD_RIGHTN_MARGIN 70

// SEND
#define SEND_LEFT_MARGIN 10

@implementation CommentField

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR]];
    
    // FIELD
    CGFloat fieldWidth = frame.size.width - TEXT_FIELD_LEFT_MARGIN - TEXT_FIELD_RIGHTN_MARGIN;
    CGFloat fieldHeight = frame.size.height - TEXT_FIELD_TOP_MARIGN - TEXT_FIELD_BOTTOM_MARGIN;
    HPGrowingTextView *field = [[HPGrowingTextView alloc] initWithFrame:CGRectMake(TEXT_FIELD_LEFT_MARGIN, TEXT_FIELD_TOP_MARIGN, fieldWidth, fieldHeight)];
    [field setBackgroundColor:[UIColor whiteColor]];
    [field.layer setCornerRadius:4];
    [field setClipsToBounds:YES];
    [field setFont:[UIFont systemFontOfSize:16]];
    [field setPlaceholder:TEXT_ADD_COMMENT];
    [field setDelegate:self];
    
    CGFloat maxLines = DEVICE_GREATER_THAN_IPHONE_5 ? 10 : 6;
    [field setMaxNumberOfLines:maxLines];
    
    
    self.textView = field;
    [self addSubview:field];
    
    // SEND
    CGFloat sendX = CGRectGetMaxX(field.frame);
    UIButton *sendBtn = [[UIButton alloc] initWithFrame:CGRectMake(sendX, 0, TEXT_FIELD_RIGHTN_MARGIN, frame.size.height)];
    [sendBtn.titleLabel setFont:[UIFont systemFontOfSize:16]];
    [sendBtn setTitle:TEXT_SEND_MESSAGE forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [sendBtn setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [sendBtn setTitleEdgeInsets:UIEdgeInsetsMake(16, 0, 5, 0)];
    
    [sendBtn setAutoresizingMask:UIViewAutoresizingFlexibleTopMargin];
    
    self.sendButton = sendBtn;
    [self addSubview:sendBtn];
  }
  return self;
}

- (void)growingTextView:(HPGrowingTextView *)growingTextView willChangeHeight:(float)height
{
  float diff = (growingTextView.frame.size.height - height);
  
	CGRect r = self.frame;
  r.size.height -= diff;
  r.origin.y += diff;
	self.frame = r;
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
