//
//  PlayerTagsCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/13/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "PlayerTagsCell.h"
#import "GeekerTag.h"

// TITLE
#define TITLE_LEFT_MARGIN 18
#define TITLE_TOP_MARGIN 8
#define TITLE_HEIGHT 18

// TAGS
#define TAG_LEFT_MARGIN 10
#define TAG_TOP_MARGIN 8
#define TAG_HEIGHT 27
#define TAG_INTERAL_MARGIN 10
#define TAG_ROW_MARGIN 10
#define TAG_PLUS_WIDTH 14
#define TAG_FONT_SIZE 13
#define TAG_BOTTOM_MARGIN 14

@implementation PlayerTagsCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
               tags:(NSArray *)tags
       tagsPosition:(NSArray *)tagsPosition
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // TITLE
    UILabel *titleLabel = [UIConfiguration labelWithText:TEXT_GOT_TAGS
                                               textColor:[UIColor lightGrayColor]
                                                    font:[UIFont systemFontOfSize:14]
                                           numberOfLines:1];
    [UIConfiguration setView:titleLabel origin:CGPointMake(TITLE_LEFT_MARGIN, TITLE_TOP_MARGIN)];
    [UIConfiguration setView:titleLabel height:TITLE_HEIGHT];
    
    [self addSubview:titleLabel];
    
    // TAGS
    for (GeekerTag *tag in tags) {
      NSString *tagStr = [NSString stringWithFormat:@"%@ %d", tag.tagName, tag.up];
      UILabel *tagLabel = [UIConfiguration labelWithText:tagStr
                                               textColor:[UIColor whiteColor]
                                                    font:[UIFont fontWithName:GLOBAL_FONT_NAME size:TAG_FONT_SIZE]
                                           numberOfLines:1];
      [tagLabel setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_GREEN_COLOR]];
      [tagLabel.layer setCornerRadius:13];
      [tagLabel setTextAlignment:NSTextAlignmentCenter];
      [tagLabel setClipsToBounds:YES];
      [UIConfiguration setView:tagLabel height:TAG_HEIGHT];
      [UIConfiguration setView:tagLabel width:tagLabel.frame.size.width + TAG_PLUS_WIDTH];
      
      NSInteger index = [tags indexOfObject:tag];
      NSValue *value = [tagsPosition objectAtIndex:index + 1];
      [UIConfiguration setView:tagLabel origin:value.CGPointValue];
      
      [self addSubview:tagLabel];
    }
  }
  return self;
}

+ (NSArray *)tagPositionsForCellWithTags:(NSArray *)tags
{
  CGFloat x = TAG_LEFT_MARGIN;
  CGFloat y = TITLE_TOP_MARGIN + TITLE_HEIGHT + TAG_TOP_MARGIN;
  CGFloat xLimit = WINDOW_FRAME.size.width - TAG_LEFT_MARGIN;
  CGFloat height;
  
  NSMutableArray *array = [NSMutableArray array];
  
  for (GeekerTag *tag in tags) {
    NSString *tagStr = [NSString stringWithFormat:@"%@ %d", tag.tagName, tag.up];
    UILabel *tagLabel = [UIConfiguration labelWithText:tagStr
                                             textColor:[UIColor whiteColor]
                                                  font:[UIFont fontWithName:GLOBAL_FONT_NAME size:TAG_FONT_SIZE]
                                         numberOfLines:1];
    [UIConfiguration setView:tagLabel height:TAG_HEIGHT];
    [UIConfiguration setView:tagLabel width:tagLabel.frame.size.width + TAG_PLUS_WIDTH];
    
    if (x + tagLabel.frame.size.width > xLimit) {
      y += (tagLabel.frame.size.height + TAG_ROW_MARGIN);
      x = TAG_LEFT_MARGIN;
    }
    [UIConfiguration setView:tagLabel origin:CGPointMake(x, y)];
    
    [array addObject:[NSValue valueWithCGPoint:CGPointMake(x, y)]];
    
    x = CGRectGetMaxX(tagLabel.frame) + TAG_INTERAL_MARGIN;
    height = y + tagLabel.frame.size.height + TAG_BOTTOM_MARGIN;
  }
  
  [array insertObject:[NSNumber numberWithFloat:height] atIndex:0];
  
  return [array copy];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
