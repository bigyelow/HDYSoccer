//
//  PlayersCell.m
//  HDYSoccer
//
//  Created by bigyelow on 6/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "PlayersCell.h"
#import "SimpleGeekerInfo.h"

#define AVATAR_WIDGH 30.0f
#define AVATAR_HEIGHT 30.0f
#define AVATAR_LINE_INTERVAL 10.0f
#define AVATAR_ROW_INTERVAL 10.0f

@implementation PlayersCell

- (id)initWithSponsor:(SimpleGeekerInfo *)sponsor
         participants:(NSArray *)participants
         averageScore:(NSString *)averageScore
                style:(UITableViewCellStyle)style
              reuseID:(NSString *)reuseID
{
  self = [super initWithStyle:style reuseIdentifier:reuseID];
  if (self) {
    
  }
  return self;
}

+ (CGFloat)cellHeight:(NSInteger)participantsCount
{
  CGFloat height = 0;
  
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
