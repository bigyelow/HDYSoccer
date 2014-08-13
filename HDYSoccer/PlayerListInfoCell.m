//
//  PlayerListInfoCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/13/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "PlayerListInfoCell.h"

// SEPERATOR
#define SEPERATOR_LEFT_MARGIN 13
#define SEPERATOR_HEIGHT 1

// TITLE
#define TITLE_LABEL_LEFTMARGIN (SEPERATOR_LEFT_MARGIN + 5)
#define TITLE_FONT 14

@implementation PlayerListInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [UIConfiguration setView:self height:PLAYER_LIST_CELL_HEIGHT];
    
    // TOP SEPERATOR
    CGFloat seperatorWidth = self.frame.size.width - 2 * SEPERATOR_LEFT_MARGIN;
    UIView *topSeper = [[UIView alloc] initWithFrame:CGRectMake(SEPERATOR_LEFT_MARGIN, 0, seperatorWidth, SEPERATOR_HEIGHT)];
    [topSeper setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR]];
    
    [self addSubview:topSeper];
    
    // TITLE
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LABEL_LEFTMARGIN, 0, 0, 0)];
    [titleLabel setFont:[UIFont systemFontOfSize:TITLE_FONT]];
    [titleLabel setTextColor:[UIColor lightGrayColor]];
    [titleLabel setTextAlignment:NSTextAlignmentLeft];
    
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    // INFO
    UILabel *infoLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 0, 0)];
    [infoLabel setFont:[UIFont systemFontOfSize:TITLE_FONT]];
    [infoLabel setTextColor:[UIColor lightGrayColor]];
    [infoLabel setTextAlignment:NSTextAlignmentRight];
    
    self.infoLabel = infoLabel;
    [self addSubview:infoLabel];
    
    // BOTTOM SEPERATOR
    CGFloat seperatorY = self.frame.size.height - SEPERATOR_HEIGHT;
    UIView *bottomSeper = [[UIView alloc] initWithFrame:CGRectMake(SEPERATOR_LEFT_MARGIN, seperatorY, seperatorWidth, SEPERATOR_HEIGHT)];
    [bottomSeper setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR]];
    [bottomSeper setHidden:YES];
    
    self.bottomSeper = bottomSeper;
    [self addSubview:bottomSeper];
  }
  return self;
}

- (void)configCellWithTitle:(NSString *)title
                       info:(NSString *)info
              hasBottomLine:(BOOL)hasBottomLine
{
  if (hasBottomLine) {
    [self.bottomSeper setHidden:NO];
  }
  else {
    [self.bottomSeper setHidden:YES];
  }
  
  // TITLE
  [self.titleLabel setText:title];
  [self.titleLabel sizeToFit];
  
  [UIConfiguration moveSubviewYToSuperviewCenter:self subview:self.titleLabel];
  
  // INFO
  [self.infoLabel setText:info];
  [self.infoLabel sizeToFit];
  
  CGFloat infoX = self.frame.size.width - TITLE_LABEL_LEFTMARGIN - self.infoLabel.frame.size.width;
  [UIConfiguration setView:self.infoLabel x:infoX];
  [UIConfiguration moveSubviewYToSuperviewCenter:self subview:self.infoLabel];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
