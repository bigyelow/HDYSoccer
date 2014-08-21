//
//  JoinGameCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/1/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "JoinGameCell.h"
#import "GameListFilterTableViewCell.h"

#define JOIN_BUTTON_TOP_MARGIN 30.0F
#define STAT_LABEL_BOTTOM_MARING 5.0F
#define MIDDLE_SEPERATOR_HEIGHT 2

@implementation JoinGameCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
           gameType:(GameType)gameType
 showStatisticTitle:(BOOL)showStatisticsTitle
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [UIConfiguration setView:self height:JOIN_GAME_CELL_HEIGHT];

    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
    [self.contentView setAlpha:0.5];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];

    // join button
    UIButton *joinButton = [[UIButton alloc] initWithFrame:CGRectZero];
    [joinButton setTitle:TEXT_JOIN forState:UIControlStateNormal];
    [joinButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateHighlighted];
    
    [joinButton setBackgroundImage:[UIConfiguration imageForColor:[UIConfiguration colorForHex:GLOBAL_TINT_COLOR]]
                          forState:UIControlStateNormal];
    [joinButton setBackgroundImage:[UIConfiguration imageForColor:[UIColor grayColor]]
                          forState:UIControlStateHighlighted];
    
    [joinButton sizeToFit];
    [UIConfiguration setView:joinButton width:joinButton.frame.size.width + 120];
    [UIConfiguration setView:joinButton height:joinButton.frame.size.height + 10];
    [UIConfiguration setView:joinButton y:JOIN_BUTTON_TOP_MARGIN];
    [UIConfiguration moveSubviewXToSuperviewCenter:self subview:joinButton];
    [self addSubview:joinButton];
    
    // statistics
    if (showStatisticsTitle) {
      UILabel *statLabel = [UIConfiguration labelWithText:TEXT_PERSONAL_GAME_STATISTICS
                                                textColor:[UIColor whiteColor]
                                                     font:[UIFont systemFontOfSize:12]
                                            numberOfLines:1];
      CGFloat statY = self.frame.size.height - STAT_LABEL_BOTTOM_MARING - statLabel.frame.size.height;
      [UIConfiguration setView:statLabel y:statY];
      [UIConfiguration moveSubviewXToSuperviewCenter:self subview:statLabel];
      
      [self addSubview:statLabel];
    }
    
    // middle seperator
//    CGFloat seperatorY = statLabel.frame.origin.y - 5;
//    UIView *midSeperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.frame.size.width, MIDDLE_SEPERATOR_HEIGHT)];
//    [midSeperator setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_SEPERATOR_COLOR]];
//    
//    [self addSubview:midSeperator];
    
    // bottom seperator
//    CGFloat seperatorY = self.frame.size.height - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
//    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.frame.size.width, GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT)];
//    [seperator setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_SEPERATOR_COLOR]];
//    
//    [self addSubview:seperator];
  }
  return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
