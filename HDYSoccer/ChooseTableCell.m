//
//  ChooseTableCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ChooseTableCell.h"
#import "UIImageView+WebCache.h"

#define IMAGE_LEFT_MARGIN 9
#define IMAGE_TOP_MARGIN 5

#define NAME_LEFT_MARGIN 7
#define NAME_TOP_MARGIN 5

// SEPERATOR
#define SEPERATOR_HEIGHT 0.5
#define SEPERATOR_LEFT_MARGIN (IMAGE_LEFT_MARGIN - 5)

@implementation ChooseTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // IMAGE
    CGFloat imageWidth = CHOOSE_TABLE_CELL_HEIGHT - 2 * IMAGE_TOP_MARGIN;
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(IMAGE_LEFT_MARGIN, IMAGE_TOP_MARGIN, imageWidth, imageWidth)];
    
    self.avatarView = imageView;
    [self addSubview:imageView];
    
    // NAME
    CGFloat nameX = CGRectGetMaxX(imageView.frame) + IMAGE_LEFT_MARGIN;
    CGFloat nameWidth = self.frame.size.width - nameX;
    CGFloat nameHeight = CHOOSE_TABLE_CELL_HEIGHT - 2 * NAME_TOP_MARGIN;
    UILabel *nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(nameX, NAME_TOP_MARGIN, nameWidth, nameHeight)];
    [nameLabel setFont:[UIFont systemFontOfSize:15]];
    
    self.nameLabel = nameLabel;
    [self addSubview:nameLabel];
    
    // SEPERATOR
    CGFloat seperY = CHOOSE_TABLE_CELL_HEIGHT - SEPERATOR_HEIGHT;
    CGFloat seperWidth = self.frame.size.width - SEPERATOR_LEFT_MARGIN;
    UIView *seper = [[UIView alloc] initWithFrame:CGRectMake(SEPERATOR_LEFT_MARGIN, seperY, seperWidth, SEPERATOR_HEIGHT)];
    [seper setBackgroundColor:[UIConfiguration colorForHex:GLOBAL_SEPERATOR_COLOR]];
    
    [self addSubview:seper];
  }
  return self;
}

- (void)configCellWithImageURL:(NSString *)url
                          name:(NSString *)name
{
  [self.avatarView sd_setImageWithURL:[NSURL URLWithString:url]];
  [self.nameLabel setText:name];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
  [super setSelected:selected animated:animated];
  
  // Configure the view for the selected state
}

@end
