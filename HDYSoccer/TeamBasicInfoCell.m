//
//  TeamBasicInfoCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/18/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "TeamBasicInfoCell.h"
#import "UIImageView+WebCache.h"

// AVATAR
#define AVATAR_TOP_MARGIN 13
#define AVATAR_WIDTH 100

// NAME
#define NAME_TOP_MARGIN (AVATAR_TOP_MARGIN)
#define NAME_HEIGHT 16
#define NAME_BOTTOM_MARGIN 30

@implementation TeamBasicInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    CGFloat cellHeight = [[self class] cellHeight];
    [UIConfiguration setView:self height:cellHeight];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
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
  }
  return self;
}

- (void)configCellWithTeam:(Team *)team
{
  // AVATAR
  [self.avatar setImageWithURL:[NSURL URLWithString:team.teamAvatarURL]];
  
  // NAME
  [self.nameLabel setText:team.teamName];
  [self.nameLabel sizeToFit];
  
  [UIConfiguration moveSubviewXToSuperviewCenter:self subview:self.nameLabel];
  [UIConfiguration setView:self.nameLabel height:NAME_HEIGHT];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

+ (CGFloat)cellHeight
{
  return AVATAR_TOP_MARGIN + AVATAR_WIDTH + NAME_TOP_MARGIN + NAME_HEIGHT + NAME_BOTTOM_MARGIN;
}

@end
