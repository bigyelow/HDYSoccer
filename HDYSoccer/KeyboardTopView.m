//
//  KeyboardTopView.m
//  HDYSoccer
//
//  Created by bigyelow on 7/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "KeyboardTopView.h"

#define LINE_TOP_MARGIN 1.0F
#define LINE_HEIGHT 0.5F
#define SEPERATOR_WIDTH 0.5F

#define BUTTON_HEIGHT 30.0F

@implementation KeyboardTopView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    [self setBackgroundColor:[UIColor lightGrayColor]];
    
//    // top line
//    UIView *topLine = [[UIView alloc] initWithFrame:CGRectMake(0, LINE_TOP_MARGIN, self.bounds.size.width, LINE_HEIGHT)];
//    [topLine setBackgroundColor:[UIColor lightGrayColor]];
//    [self addSubview:topLine];
//    
//    // bottom line
//    CGFloat bottomY = self.bounds.size.height - LINE_HEIGHT - LINE_TOP_MARGIN;
//    UIView *bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, bottomY, self.bounds.size.width, LINE_HEIGHT)];
//    [bottomLine setBackgroundColor:[UIColor lightGrayColor]];
//    [self addSubview:bottomLine];
//    
//    // seperator
//    CGFloat seperatorX = self.center.x;
//    CGFloat seperatorHeight = self.bounds.size.height;
//    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(seperatorX, LINE_TOP_MARGIN, SEPERATOR_WIDTH, seperatorHeight)];
//    [seperator setBackgroundColor:[UIColor whiteColor]];
//    [self addSubview:seperator];
//    
//    // cancel button
//    CGFloat buttonWidth = self.bounds.size.width / 2;
//    CGFloat centerY = self.bounds.size.height / 2;
//    
//    CGPoint cancelCenter = CGPointMake(self.bounds.size.width / 4, centerY);
//    UIButton *cancelButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, buttonWidth, BUTTON_HEIGHT)];
//    [cancelButton setTitle:TEXT_CANCEL forState:UIControlStateNormal];
//    [cancelButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
//    [cancelButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
//    [cancelButton setCenter:cancelCenter];
//
//    self.cancelButton = cancelButton;
//    [self addSubview:cancelButton];
    
    // confirm button
    CGPoint confirmCenter = CGPointMake(self.center.x, self.bounds.size.height / 2);
    UIButton *confirmButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, BUTTON_HEIGHT)];
    [confirmButton setTitle:TEXT_ACCOMPLISH forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [confirmButton setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [confirmButton setCenter:confirmCenter];
    
    self.confirmButton = confirmButton;
    [self addSubview:confirmButton];
  }
  return self;
}

@end
