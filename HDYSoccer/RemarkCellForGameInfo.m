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
#define TITLE_TOP_MARGIN 10.0F
#define TITLE_LEFT_MARGIN 10.0f

#define TEXTVIEW_TOP_MARGIN 6.0F
#define TEXTVIEW_LEFT_MARGIN 10.0F
#define TEXTVIEW_RIGHT_MARGIN 10.0F
#define TEXTVIEW_BOTTOM_MARGIN 6.0F

@implementation RemarkCellForGameInfo

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    //
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
    [self.contentView setAlpha:0.5];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];

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
    
    self.titleLabel = titleLabel;
    [self addSubview:titleLabel];
    
    // textView
    
    // seperator line
    CGFloat seperatorY = self.frame.size.height - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
    UIView *seperator = [[UIView alloc] initWithFrame:CGRectMake(0, seperatorY, self.frame.size.width, GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT)];
    [seperator setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_SEPERATOR_COLOR]];
    
    self.seperator = seperator;
    [self addSubview:seperator];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];

  CGRect frame = self.seperator.frame;
  frame.size.width = self.bounds.size.width;
  self.seperator.frame = frame;
}

#define REMARK_FONT_SIZE 14.0F

- (CGFloat)heightForCell:(NSString *)remarks
{
  // remarks
  self.remarksViewWidth = self.frame.size.width - CGRectGetMaxX(self.titleLabel.frame)
  - TEXTVIEW_LEFT_MARGIN - TEXTVIEW_RIGHT_MARGIN;
  CGFloat remarksX = CGRectGetMaxX(self.titleLabel.frame) + TEXTVIEW_LEFT_MARGIN;
  CGFloat remarksY = TEXTVIEW_TOP_MARGIN;
  UITextView *textView = [[UITextView alloc] initWithFrame:CGRectMake(remarksX, remarksY, self.remarksViewWidth, 0)];
  [textView setText:remarks];
  [textView setFont:[UIFont systemFontOfSize:REMARK_FONT_SIZE]];
  [textView.layer setBorderWidth:1.0f];
  [textView.layer setCornerRadius:5.0f];
  [textView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
  [textView setTintColor:[UIColor blackColor]];
  [textView setEditable:NO];
  [textView sizeToFit];
  
  self.remarksView = textView;
  [self addSubview:self.remarksView];
  
  CGFloat cellHeight = TEXTVIEW_TOP_MARGIN + TEXTVIEW_BOTTOM_MARGIN + textView.frame.size.height;

  // seperator line
  CGFloat seperatorY = cellHeight - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
  [UIConfiguration setView:self.seperator y:seperatorY];
  
  return cellHeight;
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
