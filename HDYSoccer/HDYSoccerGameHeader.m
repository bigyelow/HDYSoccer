//
//  HDYSoccerGameHeader.m
//  HDYSoccer
//
//  Created by bigyelow on 3/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameHeader.h"
#import "UIConfiguration+Color.h"
#import "GameViewParams.h"

@implementation HDYSoccerGameHeader

- (id)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIConfiguration colorForHex:SECTION_BACKGROUND_COLOR];
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
