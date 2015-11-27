//
//  ContactCellForGameInfo.m
//  HDYSoccer
//
//  Created by bigyelow on 7/30/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ContactCellForGameInfo.h"
#import "GameListFilterTableViewCell.h"

// image
#define CONTACT_IMAGE_LEFT_MARGIN 9.0F
#define CONTACT_IMAGE_TOP_MARGIN 15.0F
#define CONTACT_IMAGE_WIDTH 13.0F
#define CONTACT_IMAGE_HEIGHT 13.0F

// title
#define TITLE_LEFT_MARGIN 11.0f

@interface ContactCellForGameInfo ()

@property (nonatomic, strong) UIView *seperator;

@end

@implementation ContactCellForGameInfo

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              title:(NSString *)title
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
    [self.contentView setAlpha:0.5];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];

    // contact image
    UIImage *contactImage = [UIImage imageNamed:@"phone2-75.png"];
    CGRect contactRect = CGRectMake(CONTACT_IMAGE_LEFT_MARGIN, CONTACT_IMAGE_TOP_MARGIN, CONTACT_IMAGE_WIDTH, CONTACT_IMAGE_HEIGHT);
    UIImageView *contactView = [[UIImageView alloc] initWithFrame:contactRect];
    [contactView setImage:contactImage];
    
    [self addSubview:contactView];
    
    // title
    CGFloat titleX = CGRectGetMaxX(contactView.frame) + TITLE_LEFT_MARGIN;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, 0, 0, 0)];
    [titleLabel setText:title];
    [titleLabel sizeToFit];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:titleLabel];
    
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    // seperator line
    CGFloat seperatorY = self.frame.size.height - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.frame.size.width, GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT)];
    [seperator setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_SEPERATOR_COLOR]];
    self.seperator = seperator;
    
    [self addSubview:seperator];
  }
  return self;
}

- (void)updateWithTitle:(NSString *)title
{
  [self.titleLabel setText:title];
  [self.titleLabel sizeToFit];
}

- (void)layoutSubviews
{
  [super layoutSubviews];

  CGRect frame = self.seperator.frame;
  frame.size.width = self.bounds.size.width;
  self.seperator.frame = frame;
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
