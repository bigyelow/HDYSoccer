//
//  CostCellForGameInfo.m
//  HDYSoccer
//
//  Created by bigyelow on 7/30/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CostCellForGameInfo.h"
#import "GameListFilterTableViewCell.h"

// image
#define COST_IMAGE_LEFT_MARGIN 5.0F
#define COST_IMAGE_TOP_MARGIN 9.0F
#define COST_IMAGE_WIDTH 25.0F
#define COST_IMAGE_HEIGHT 25.0F

// title
#define TITLE_LEFT_MARGIN 3.0f

@implementation CostCellForGameInfo

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              title:(NSString *)title
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
    [self.contentView setAlpha:0.5];
    
    // cost image
    UIImage *costImage = [UIImage imageNamed:@"money-75.png"];
    CGRect costRect = CGRectMake(COST_IMAGE_LEFT_MARGIN, COST_IMAGE_TOP_MARGIN, COST_IMAGE_WIDTH, COST_IMAGE_HEIGHT);
    UIImageView *costView = [[UIImageView alloc] initWithFrame:costRect];
    [costView setImage:costImage];
    
    [self addSubview:costView];
    
    // title
    CGFloat titleX = CGRectGetMaxX(costView.frame) + TITLE_LEFT_MARGIN;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, 0, 0, 0)];
    [titleLabel setText:title];
    [titleLabel sizeToFit];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:titleLabel];
    
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    // seperator line
    CGFloat seperatorY = self.frame.size.height - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.frame.size.width, GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT)];
    [seperator setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_SEPERATOR_COLOR]];
    
    [self addSubview:seperator];
  }
  return self;
}

- (void)updateWithTitle:(NSString *)title
{
  [self.titleLabel setText:title];
  [self.titleLabel sizeToFit];
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
