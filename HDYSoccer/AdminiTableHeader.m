//
//  adminiTableHeader.m
//  HDYSoccer
//
//  Created by bigyelow on 8/25/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "AdminiTableHeader.h"

@implementation AdminiTableHeader

- (id)initWithFrame:(CGRect)frame
              title:(NSString *)title
{
  self = [super initWithFrame:frame];
  if (self) {
    UILabel *label = [UIConfiguration labelWithText:title textColor:[UIColor blackColor] font:[UIFont systemFontOfSize:14] numberOfLines:1];
    [UIConfiguration setView:label x:10];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:label];
    
    [self addSubview:label];
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
