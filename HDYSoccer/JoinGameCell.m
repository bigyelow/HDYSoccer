//
//  JoinGameCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/1/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "JoinGameCell.h"
#import "GameListFilterTableViewCell.h"

@implementation JoinGameCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
           gameType:(GameType)gameType
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [UIConfiguration setView:self height:JOIN_GAME_CELL_HEIGHT];

    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
    [self.contentView setAlpha:0.5];
    
    // join button
    UIButton *joinButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [joinButton setTitle:TEXT_JOIN forState:UIControlStateNormal];
    [joinButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    [joinButton setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR]];
    [joinButton sizeToFit];
    [UIConfiguration setView:joinButton width:joinButton.frame.size.width + 120];
    [UIConfiguration moveSubviewToSuperviewCenter:self subview:joinButton];

    [self addSubview:joinButton];
    
    CGFloat seperatorY = self.frame.size.height - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.frame.size.width, GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT)];
    [seperator setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_SEPERATOR_COLOR]];
    
    [self addSubview:seperator];
  }
  return self;
}

- (void)awakeFromNib
{
  // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
