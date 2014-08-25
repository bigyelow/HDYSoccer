//
//  CommentBar.h
//  HDYSoccer
//
//  Created by bigyelow on 8/25/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define COMMENT_BAR_HEIGHT 44

@interface CommentBar : UIView
- (id)initWithFrame:(CGRect)frame
      commentsCount:(NSInteger)commentsCount;
@end
