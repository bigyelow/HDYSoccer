//
//  GeekerListCell.m
//  HDYSoccer
//
//  Created by bigyelow on 7/2/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "GeekerListCell.h"
#import "SimpleGeekerInfo.h"
#import "UIImageView+WebCache.h"
#import "GeekerTag.h"

// avatar
#define AVATAR_LEFT_MARGIN 10.0f
#define AVATAR_WIDTH 50.0f
#define AVATAR_HEIGHT (AVATAR_WIDTH)

// name
#define NAME_LEFT_MARGIN 5.0f

// score
#define SCORE_LEFT_MARGIN 5.0f

// tag
#define TAG_LEFT_MARGIN 5.0f

@implementation GeekerListCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
         geekerInfo:(SimpleGeekerInfo *)geekerInfo
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // height
    [UIConfiguration setView:self.contentView height:GEEKER_LIST_CELL_HEIGHT];
    
    // avatar
    self.avatar = [[UIImageView alloc] initWithFrame:CGRectMake(AVATAR_LEFT_MARGIN, 0, AVATAR_WIDTH, AVATAR_HEIGHT)];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:self.avatar];
    [self.avatar setImageWithURL:[NSURL URLWithString:geekerInfo.avatarURL] placeholderImage:nil];
    
    [self.contentView addSubview:self.avatar];
    
    CGFloat rightMost;
    
    // name
    CGFloat nameX = CGRectGetMaxX(self.avatar.frame) + NAME_LEFT_MARGIN;
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, 0, 0, 0)];
    [self.nameLabel setText:geekerInfo.name];
    [self.nameLabel sizeToFit];
    
    [self.contentView addSubview:self.nameLabel];
    rightMost = CGRectGetMaxX(self.nameLabel.frame);
    
    // score
    if (geekerInfo.score) {
      CGFloat scoreX = rightMost + SCORE_LEFT_MARGIN;
      self.scoreLabel = [[UILabel alloc] initWithFrame:CGRectMake(scoreX, 0, 0, 0)];
      [self.scoreLabel setText:geekerInfo.score];
      [self.scoreLabel setTextColor:[UIColor redColor]];
      [self.scoreLabel sizeToFit];
      
      [self.contentView addSubview:self.scoreLabel];
      rightMost = CGRectGetMaxX(self.scoreLabel.frame);
    }
    
    // tag
    if (geekerInfo.tagsArray && [geekerInfo.tagsArray count]) {
      CGFloat tagX = rightMost + TAG_LEFT_MARGIN;
      self.tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(tagX, 0, 0, 0)];
      
      GeekerTag *tag = geekerInfo.tagsArray[0];
      [self.tagLabel setText:tag.tagName];
      [self.tagLabel setTextColor:[UIColor greenColor]];
      [self.tagLabel sizeToFit];
      
      [self.contentView addSubview:self.tagLabel];
      rightMost = CGRectGetMaxX(self.tagLabel.frame);
    }
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
