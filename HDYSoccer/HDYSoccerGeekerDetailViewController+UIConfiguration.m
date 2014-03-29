//
//  HDYSoccerGeekerDetailViewController+UIConfiguration.m
//  HDYSoccer
//
//  Created by bigyelow on 3/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGeekerDetailViewController+UIConfiguration.h"
#import "GeekerDetailParams.h"
#import "UIConfiguration.h"

@implementation HDYSoccerGeekerDetailViewController (UIConfiguration)

- (void)configTableView
{
  [self setTitle:self.geekerName];
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
}

- (void)configTableHeaderView
{
  UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, HEADER_HEIGHT)];
  
  // avatar
  UIImageView *avatarView = [[UIImageView alloc] initWithFrame:AVATAR_RECT];
  avatarView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
  avatarView.image = [UIImage imageNamed:@"bigyelow_avatar.jpg"];
  avatarView.layer.masksToBounds = YES;
  avatarView.layer.borderColor = [UIColor whiteColor].CGColor;
  avatarView.layer.borderWidth = AVATAR_BORDER_WIDTH;
  avatarView.layer.rasterizationScale = [UIScreen mainScreen].scale;
  avatarView.layer.shouldRasterize = YES;
  avatarView.clipsToBounds = YES;
  
  // name
  CGRect nameRect = AVATAR_RECT;
  CGFloat nameY = nameRect.origin.y + nameRect.size.height + NAME_TOP_MARGIN;
  nameRect.origin.y = nameY;
  UILabel *nameLabel = [[UILabel alloc] initWithFrame:nameRect];
  nameLabel.text = self.geekerName;
  nameLabel.font = NAME_LABEL_FONT;
  nameLabel.backgroundColor = [UIColor clearColor];
  nameLabel.textColor = NAME_LABEL_FONT_COLOR;
  [nameLabel setNumberOfLines:0];
  [nameLabel sizeToFit];
  nameLabel.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
  [UIConfiguration moveSubviewXToSuperviewCenter:avatarView subview:nameLabel];
  
  // short introduction
  CGFloat shortIntroWidth = self.view.bounds.size.width
  - LEFT_MARGIN
  - AVATAR_RECT.size.width
  - QUALITY_LEFT_MARGIN;
  
  CGFloat qualityX = AVATAR_RECT.origin.x + AVATAR_RECT.size.width + QUALITY_LEFT_MARGIN;
  CGFloat qualityY = QUALITY_Y;
  NSString *qualityText = [NSString stringWithFormat:QUALITY_TITLE, @"91"];
  UILabel *qualityLabel = [self createShortIntroductionWithRect:CGRectMake(qualityX, qualityY, shortIntroWidth, 0)
                                                           text:qualityText];
  
  CGFloat characterY = qualityLabel.frame.origin.y + qualityLabel.frame.size.height + INTER_ROW_SPACE;
  CGFloat characterX = qualityX;
  NSString *characterText = [NSString stringWithFormat:CHARACTER_TITLE, @"中场核心、调度者、脚法精准"];
  UILabel *characterLable = [self createShortIntroductionWithRect:CGRectMake(characterX, characterY, shortIntroWidth, 0)
                                                             text:characterText];
  
  CGFloat positionY = characterLable.frame.origin.y + characterLable.frame.size.height + INTER_ROW_SPACE;
  CGFloat positionX = qualityX;
  NSString *positionText = [NSString stringWithFormat:POSITION_TITLE, @"右前卫、前腰、后腰"];
  UILabel *positionLabel = [self createShortIntroductionWithRect:CGRectMake(positionX, positionY, shortIntroWidth, 0)
                                                            text:positionText];
  
  [headerView addSubview:qualityLabel];
  [headerView addSubview:characterLable];
  [headerView addSubview:positionLabel];
  [headerView addSubview:avatarView];
  [headerView addSubview:nameLabel];
  
  self.tableView.tableHeaderView = headerView;
}

- (UILabel *)createShortIntroductionWithRect:(CGRect)rect
                                   text:(NSString *)text
{
  UILabel *label = [[UILabel alloc] initWithFrame:rect];
  [label setText:text];
  [label setFont:SHORT_INTRO_FONT];
  [label setTextColor:NAME_LABEL_FONT_COLOR];
  [label setNumberOfLines:0];
  [label sizeToFit];
  
  return label;
}

@end
