//
//  TeamInfoCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/7/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "TeamInfoCell.h"
#import "GameListFilterTableViewCell.h"
#import "TeamGame.h"
#import "UIImageView+WebCache.h"

// avatar
#define AVATAR_TOP_MARGIN 8
#define AVATAR_WIDTH 35

// name
#define NAME_TOP_MARGIN 6
#define NAME_HEIGHT 15

// score
#define FIRST_SCORE_TOP_MARING 15
#define SCORE_LEFT_MARGIN 20
#define SCORE_INTERAL_MARGIN 20
#define SCORE_HEIGHT 30
#define SCORE_TOP_MARGIN 10
#define SCORE_BOTTOM_MARGIN 18

@implementation TeamInfoCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
           teamInfo:(TeamGame *)teamInfo
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [UIConfiguration setView:self height:[[self class] heightForCell]];
    
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
    [self.contentView setAlpha:0.5];
    
    // avatar
    UIImageView *avatar = [[UIImageView alloc] initWithFrame:CGRectMake(0, AVATAR_TOP_MARGIN, AVATAR_WIDTH, AVATAR_WIDTH)];
    [avatar sd_setImageWithURL:[NSURL URLWithString:teamInfo.teamAvatarURL] placeholderImage:nil];
    [UIConfiguration moveSubviewXToSuperviewCenter:self subview:avatar];
    
    [self addSubview:avatar];
    
    // name
    UILabel *nameLabel = [UIConfiguration labelWithText:teamInfo.teamName
                                              textColor:[UIColor whiteColor]
                                                   font:[UIFont systemFontOfSize:15]
                                          numberOfLines:1];
    [UIConfiguration setView:nameLabel y:CGRectGetMaxY(avatar.frame) + NAME_TOP_MARGIN];
    [UIConfiguration setView:nameLabel height:NAME_HEIGHT];
    [UIConfiguration moveSubviewXToSuperviewCenter:self subview:nameLabel];
    
    [self addSubview:nameLabel];
    
//    // score
//    CGFloat scoreWidth = (self.frame.size.width - SCORE_LEFT_MARGIN * 2 - SCORE_INTERAL_MARGIN) / 2;
//    CGFloat scoreHeight = SCORE_HEIGHT;
//    CGFloat scoreY = CGRectGetMaxY(nameLabel.frame) + FIRST_SCORE_TOP_MARING;
//    CGFloat scoreX = SCORE_LEFT_MARGIN;
//    NSArray *scoreArray = [self getScoreArrayWithScore:teamInfo.teamScore];
//    for (NSString *scoreStr in scoreArray) {
//      UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(scoreX, scoreY, scoreWidth, scoreHeight)];
//      [label setText:scoreStr];
//      [label setFont:[UIFont systemFontOfSize:15]];
//      [label setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_GREEN_COLOR]];
//      [label setTextColor:[UIColor whiteColor]];
//      [label setTextAlignment:NSTextAlignmentCenter];
//      [label.layer setCornerRadius:12];
//      [label setClipsToBounds:YES];
//      
//      [self addSubview:label];
//      
//      if ([scoreArray indexOfObject:scoreStr] % 2 == 0) {
//        scoreX += (scoreWidth + SCORE_INTERAL_MARGIN);
//      }
//      else { // new line
//        scoreX = SCORE_LEFT_MARGIN;
//        scoreY += (scoreHeight + SCORE_TOP_MARGIN);
//      }
//    }
//    
//    // seperator line
//    CGFloat seperatorY = self.frame.size.height - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
//    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.frame.size.width, GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT)];
//    [seperator setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_SEPERATOR_COLOR]];
//    
//    [self addSubview:seperator];
  }
  return self;
}

#define ABILITY_FORMAT @"%@ %@"
- (NSArray *)getScoreArrayWithScore:(TeamScore *)score
{
  NSMutableArray *scoreArray = [NSMutableArray array];
  NSString *ability = [NSMutableString stringWithFormat:ABILITY_FORMAT, TEXT_ATTACK, score.attack];
  [scoreArray addObject:ability];

  ability =  [NSMutableString stringWithFormat:ABILITY_FORMAT, TEXT_DEFENTD, score.defend];
  [scoreArray addObject:ability];
  
  ability =  [NSMutableString stringWithFormat:ABILITY_FORMAT, TEXT_SKILL, score.skill];
  [scoreArray addObject:ability];
  
  ability =  [NSMutableString stringWithFormat:ABILITY_FORMAT, TEXT_COORPERATION, score.coorperation];
  [scoreArray addObject:ability];
  
  ability =  [NSMutableString stringWithFormat:ABILITY_FORMAT, TEXT_SPEED, score.speed];
  [scoreArray addObject:ability];
  
  ability =  [NSMutableString stringWithFormat:ABILITY_FORMAT, TEXT_PHYSICAL_STRENGTH, score.physicalStrength];
  [scoreArray addObject:ability];
  
  return [scoreArray copy];
}

+ (CGFloat)heightForCell
{
  CGFloat height = AVATAR_TOP_MARGIN + AVATAR_WIDTH
  + NAME_TOP_MARGIN + NAME_HEIGHT
  + FIRST_SCORE_TOP_MARING;
//  + SCORE_HEIGHT * 3 + SCORE_TOP_MARGIN * 2 + SCORE_BOTTOM_MARGIN;
  return height;
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
