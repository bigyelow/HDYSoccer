//
//  HDYSoccerGameFooter.m
//  HDYSoccer
//
//  Created by bigyelow on 3/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameFooter.h"
#import "GameViewParams.h"
#import "UIConfiguration+Color.h"

@implementation HDYSoccerGameFooter

- (id)initWithFrame:(CGRect)frame
{
  if (self = [super initWithFrame:frame]) {
    self.backgroundColor = [UIConfiguration colorForHex:SECTION_BACKGROUND_COLOR];
  }
  return self;
}

@end
