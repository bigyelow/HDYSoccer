//
//  GeekerTableCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/9/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GeekerTableCell.h"
#import "SimpleGeekerInfo.h"
#import "UIImageView+WebCache.h"
#import "GeekerTag.h"
#import "GameListFilterTableViewCell.h"
#import "UILabel+Customize.h"

// BACKGROUND
#define BACKGROUND_BOTTOM_MARGIN 10

// content
#define CONTENT_RIGHT_MARING 10

// AVATAR
#define AVATAR_TOP_MARGIN 15
#define AVATAR_LEFT_MARGIN 10

// name
#define NAME_TOP_MARGIN (AVATAR_TOP_MARGIN)
#define NAME_LEFT_MARGIN 10

// SCORE
#define SCORE_TOP_MARGIN (NAME_TOP_MARGIN + 1)
#define SCORE_LEFT_MARGIN 7

// POSITION
#define POSITION_TOP_MARGIN (SCORE_TOP_MARGIN)
#define POSITION_TEFT_MARGIN 10

// tags
#define TAGS_NUMBER_LIMIT 3
#define TAGS_TOP_MARGIN 5
#define FIRST_TAGS_LEFT_MRGIN 10
#define TAGS_INTERAL_MARGIN 4
#define TAG_HEIGHT 25

// seperator
#define SEPERATOR_HEIGHT 0.3

@implementation GeekerTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [UIConfiguration setView:self height:GEEKER_TABLE_CELL_HEIGHT];
    [self setBackgroundColor:[UIColor clearColor]];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // BACKGROUND
    CGFloat backgroundHeight = self.frame.size.height - BACKGROUND_BOTTOM_MARGIN;
    UIView *backgroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, backgroundHeight)];
    [backgroundView setBackgroundColor:[UIColor whiteColor]];
    
    [self addSubview:backgroundView];
    
    // AVATAR
    CGFloat avatarWidth = backgroundView.frame.size.height - 2 * AVATAR_TOP_MARGIN;
    UIImageView *avatar = [[UIImageView alloc]
                           initWithFrame:CGRectMake(AVATAR_LEFT_MARGIN, AVATAR_TOP_MARGIN, avatarWidth, avatarWidth)];
    [avatar.layer setCornerRadius:avatarWidth / 2];
    [avatar setClipsToBounds:YES];
    avatar.contentMode = UIViewContentModeScaleAspectFill;
    
    self.avatar = avatar;
    [backgroundView addSubview:avatar];
    
    // name
    CGFloat nameX = CGRectGetMaxX(avatar.frame) + NAME_LEFT_MARGIN;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, NAME_TOP_MARGIN, 0, 0)];
    
    self.nameLabel = nameLabel;
    [backgroundView addSubview:nameLabel];
    
    // score
    UILabel *scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, SCORE_TOP_MARGIN, 0, 0)];
    
    self.scoreLabel = scoreLabel;
    [backgroundView addSubview:scoreLabel];
    
    // postion
    UILabel *positionLable = [[UILabel alloc] initWithFrame:CGRectMake(nameX, POSITION_TOP_MARGIN, 0, 0)];
    
    self.positionLabel = positionLable;
    [backgroundView addSubview:positionLable];
    
    // tags
    NSMutableArray *tempArray = [NSMutableArray array];
    for (int i = 0; i < TAGS_NUMBER_LIMIT; ++i) {
      UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
      [label setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_GREEN_COLOR]];
      [label setClipsToBounds:YES];
      [label setTextAlignment:NSTextAlignmentCenter];
      [label.layer setCornerRadius:12];
      [label setHidden:YES];
      
      [tempArray addObject:label];
      
      [backgroundView addSubview:label];
    }
    self.tagsArray = [tempArray copy];
  }
  return self;
}

- (void)configWithPlayerInfo:(SimpleGeekerInfo *)info
{
  // avatar
  [self.avatar sd_setImageWithURL:[NSURL URLWithString:info.avatarURL]];
  
  // name
  [self.nameLabel configWithText:info.name
                       textColor:[UIColor blackColor]
                            font:[UIFont systemFontOfSize:16]
                   numberOfLines:1];
  
  CGFloat rightMost = CGRectGetMaxX(self.nameLabel.frame);
  
  // score
  if (info.score) {
    [self.scoreLabel configWithText:info.score
                          textColor:[UIColor grayColor]
                               font:[UIFont fontWithName:GLOBAL_FONT_NAME size:14]
                      numberOfLines:1];
    CGFloat scoreX = rightMost + SCORE_LEFT_MARGIN;
    [UIConfiguration setView:self.scoreLabel x:scoreX];
    
    rightMost = CGRectGetMaxX(self.scoreLabel.frame);
  }
  
  // position
  NSMutableString *positionStr = [NSMutableString string];
  for (NSString *posit in info.position) {
    if ([info.position indexOfObject:posit] == 0) {
      [positionStr appendString:posit];
    }
    else {
      [positionStr appendString:[NSString stringWithFormat:@",%@", posit]];
    }
  }
  if (![positionStr isEqualToString:@""]) {
    [self.positionLabel configWithText:positionStr
                             textColor:[UIColor grayColor]
                                  font:[UIFont systemFontOfSize:14]
                         numberOfLines:1];
    CGFloat positionX = rightMost + POSITION_TEFT_MARGIN;
    [UIConfiguration setView:self.positionLabel x:positionX];
    if (CGRectGetMaxX(self.positionLabel.frame) > self.frame.size.width - CONTENT_RIGHT_MARING) {
      [UIConfiguration setView:self.positionLabel width:self.frame.size.width - CONTENT_RIGHT_MARING];
    }
  }
  
  // TAGS
  CGFloat tagY = CGRectGetMaxY(self.nameLabel.frame) + TAGS_TOP_MARGIN;
  CGFloat tagX = CGRectGetMaxX(self.avatar.frame) + FIRST_TAGS_LEFT_MRGIN;
  
  for (UILabel *label in self.tagsArray) {
    [label setHidden:YES];
  }
  
  CGFloat xLimit = self.frame.size.width - CONTENT_RIGHT_MARING;
  if (info.tagsArray) {
    int i = 0;
    for (GeekerTag *tag in info.tagsArray) {
      if (i == TAGS_NUMBER_LIMIT) {
        break;
      }
      
      UILabel *label = self.tagsArray[i];
      NSMutableString *text = [NSMutableString stringWithString:tag.tagName];
      if (tag.up != 0) {
        [text appendString:[NSString stringWithFormat:@" %zd", tag.up]];
      }
      [label configWithText:text
                  textColor:[UIColor whiteColor]
                       font:[UIFont fontWithName:GLOBAL_FONT_NAME size:11]
              numberOfLines:1];
      CGFloat labelWidth = label.frame.size.width + 20;
      [UIConfiguration setView:label x:tagX];
      [UIConfiguration setView:label origin:CGPointMake(tagX, tagY)];
      [UIConfiguration setView:label size:CGSizeMake(labelWidth, TAG_HEIGHT)];
      
      rightMost = CGRectGetMaxX(label.frame);
      if (rightMost > xLimit) {
        break;
      }
      [label setHidden:NO];
      
      tagX = CGRectGetMaxX(label.frame) + TAGS_INTERAL_MARGIN;
      ++i;
    }
  }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
