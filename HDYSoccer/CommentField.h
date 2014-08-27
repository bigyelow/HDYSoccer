//
//  CommentField.h
//  HDYSoccer
//
//  Created by bigyelow on 8/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HPGrowingTextView.h"

#define COMMENT_BACK_HEIGHT 52

@interface CommentField : UIView
<HPGrowingTextViewDelegate>

@property (nonatomic, strong) HPGrowingTextView *textView;
@property (nonatomic, strong) UIButton *sendButton;
@end
