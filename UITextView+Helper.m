//
//  UITextView+Helper.m
//  HDYSoccer
//
//  Created by bigyelow on 8/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "UITextView+Helper.h"


@implementation UITextView (Helper)

- (void)setAttributedText:(NSString *)text font:(UIFont *)font lineSpace:(CGFloat)lineSpace
{
  // adjust lineSpacing
  NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
  [style setLineBreakMode:NSLineBreakByWordWrapping];
  [style setLineSpacing:lineSpace];
  
  NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:text];
  [string addAttribute:NSFontAttributeName value:font range:NSMakeRange(0, string.length)];
  [string addAttribute:NSParagraphStyleAttributeName value:style range:NSMakeRange(0, string.length)];
  
  [self setAttributedText:string];
}

@end
