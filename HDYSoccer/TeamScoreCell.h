//
//  TeamScoreCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/18/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class UICountingLabel;

#define TEAM_SCORE_CELL_ID @"teamScoreCell"
#define TEAM_SCORE_CELL_HEIGHT 18

@interface TeamScoreCell : UITableViewCell

@property (nonatomic, strong) UILabel *abilityNameLabel;
@property (nonatomic, strong) UICountingLabel *scoreLabel;
@property (nonatomic, strong) UIView *scoreBar;

- (void)configCellWithAbilityName:(NSString *)abilityName
                     abilityScore:(NSInteger)abilityScore
                        animation:(BOOL)animation;
@end
