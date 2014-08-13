//
//  PlayerTagsCell.h
//  HDYSoccer
//
//  Created by bigyelow on 8/13/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

#define PLAYER_TAGS_CELL_ID @"playerTagsCell"

@interface PlayerTagsCell : UITableViewCell
- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
               tags:(NSArray *)tags
       tagsPosition:(NSArray *)tagsPosition;
+ (NSArray *)tagPositionsForCellWithTags:(NSArray *)tags;
@end
