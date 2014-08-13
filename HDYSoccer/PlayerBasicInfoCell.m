//
//  SoccerBasicInfoCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/13/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "PlayerBasicInfoCell.h"
#import "Geeker.h"
#import "UIImageView+WebCache.h"

// AVATAR
#define AVATAR_TOP_MARGIN 13
#define AVATAR_WIDTH 100

// NAME
#define NAME_TOP_MARGIN (AVATAR_TOP_MARGIN)
#define NAME_HEIGHT 16

// POSITION
#define POSITION_TOP_MARGIN (NAME_TOP_MARGIN - 2)
#define POSITION_HEIGHT 15
#define POSITION_BOTTOM_MARGIN 30

@implementation PlayerBasicInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    CGFloat cellHeight = [[self class] cellHeight];
    [UIConfiguration setView:self height:cellHeight];
    
    // AVATAR
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, AVATAR_TOP_MARGIN, AVATAR_WIDTH, AVATAR_WIDTH)];
    [avatar.layer setCornerRadius:AVATAR_WIDTH / 2];
    [avatar setClipsToBounds:YES];
    [avatar.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [avatar.layer setBorderWidth:2];
    [UIConfiguration moveSubviewXToSuperviewCenter:self subview:avatar];
    
    self.avatar = avatar;
    [self addSubview:avatar];
    
    // NAME
    CGFloat nameY = CGRectGetMaxY(avatar.frame) + NAME_TOP_MARGIN;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2, nameY, 0, 0)];
    [nameLabel setFont:[UIFont systemFontOfSize:16]];
    
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    
    // POSITION
    CGFloat positionY = nameY + NAME_HEIGHT + POSITION_TOP_MARGIN;
    UILabel *positionLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.frame.size.width / 2, positionY, 0, 0)];
    [positionLabel setTextColor:[UIColor lightGrayColor]];
    [positionLabel setFont:[UIFont systemFontOfSize:14]];
    
    self.positionLabel = positionLabel;
    [self addSubview:positionLabel];
  }
  return self;
}

- (void)configCellWithPlayer:(Geeker *)player
{
  // AVATAR
  [self.avatar setImageWithURL:[NSURL URLWithString:player.avatarURL]];
  
  // NAME
  [self.nameLabel setText:player.name];
  [self.nameLabel sizeToFit];
  
  [UIConfiguration moveSubviewXToSuperviewCenter:self subview:self.nameLabel];
  [UIConfiguration setView:self.nameLabel height:NAME_HEIGHT];
  
  // position
  NSMutableString *positionStr = [NSMutableString string];
  for (NSString *posit in player.position) {
    if ([player.position indexOfObject:posit] != 0) {
      [positionStr appendString:@","];
    }
    [positionStr appendString:posit];
  }
  [self.positionLabel setText:positionStr];
  [self.positionLabel sizeToFit];
  
  [UIConfiguration moveSubviewXToSuperviewCenter:self subview:self.positionLabel];
  [UIConfiguration setView:self.positionLabel height:POSITION_HEIGHT];
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
  return AVATAR_TOP_MARGIN + AVATAR_WIDTH + NAME_TOP_MARGIN + NAME_HEIGHT
  + POSITION_TOP_MARGIN + POSITION_HEIGHT + POSITION_BOTTOM_MARGIN;
}

@end
