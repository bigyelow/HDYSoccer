//
//  PlayerAbilityCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/14/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UICountingLabel;

#define PLAYER_ABILITY_CELL_ID @"playerAbilityCell"
#define PLAYER_ABILITY_CELL_HEIGHT 18

@interface PlayerAbilityCell : UITableViewCell

@property (nonatomic, strong) UILabel *abilityNameLabel;
@property (nonatomic, strong) UICountingLabel *scoreLabel;
@property (nonatomic, strong) UIView *scoreBar;

- (void)configCellWithAbilityName:(NSString *)abilityName
                     abilityScore:(NSInteger)abilityScore
                        animation:(BOOL)animation;
@end
