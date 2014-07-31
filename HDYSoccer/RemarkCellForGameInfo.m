//
//  RemarkCellForGameInfo.m
//  HDYSoccer
//
//  Created by bigyelow on 7/30/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "RemarkCellForGameInfo.h"
#import "GameListFilterTableViewCell.h"

// image
#define REMARK_IMAGE_LEFT_MARGIN 11.0F
#define REMARK_IMAGE_TOP_MARGIN 15.0F
#define REMARK_IMAGE_WIDTH 13.0F
#define REMARK_IMAGE_HEIGHT 13.0F

// title
#define TITLE_LEFT_MARGIN 10.0f

@implementation RemarkCellForGameInfo

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    //
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
    [self.contentView setAlpha:0.5];
    
    // remark image
    UIImage *remarkImage = [UIImage imageNamed:@"info-75.png"];
    CGRect remarkRect = CGRectMake(REMARK_IMAGE_LEFT_MARGIN, REMARK_IMAGE_TOP_MARGIN, REMARK_IMAGE_WIDTH, REMARK_IMAGE_HEIGHT);
    UIImageView *remarkView = [[UIImageView alloc] initWithFrame:remarkRect];
    [remarkView setImage:remarkImage];
    
    [self addSubview:remarkView];
    
    // title
    CGFloat titleX = CGRectGetMaxX(remarkView.frame) + TITLE_LEFT_MARGIN;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, 0, 0, 0)];
    [titleLabel setText:TEXT_REMARK];
    [titleLabel sizeToFit];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:titleLabel];
    
    [self addSubview:titleLabel];
    
    // seperator line
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
