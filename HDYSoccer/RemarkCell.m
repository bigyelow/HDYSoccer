//
//  RemarkCell.m
//  HDYSoccer
//
//  Created by bigyelow on 6/17/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "RemarkCell.h"
#import "GameListFilterTableViewCell.h"

// image
#define REMARK_IMAGE_LEFT_MARGIN 11.0F
#define REMARK_IMAGE_TOP_MARGIN 15.0F
#define REMARK_IMAGE_WIDTH 13.0F
#define REMARK_IMAGE_HEIGHT 13.0F

// title
#define TITLE_LEFT_MARGIN 10.0f

// text field
#define TEXT_FIELD_LEFT_MARGIN 10.0f
#define TEXT_FIELD_WIDTH 225.0f
#define TEXT_FIELD_TOP_MARGIN 9.0F
#define TEXT_FIELD_BOTTOM_MARGIN 9.0F

@implementation RemarkCell

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
    
    // text field
    CGFloat fieldX = CGRectGetMaxX(titleLabel.frame) + TEXT_FIELD_LEFT_MARGIN;
    CGFloat fieldHeight = REMARK_CELL_FIELD_HEIGHT - TEXT_FIELD_BOTTOM_MARGIN - TEXT_FIELD_TOP_MARGIN;
    CGRect fieldRect = CGRectMake(fieldX, TEXT_FIELD_TOP_MARGIN, TEXT_FIELD_WIDTH, fieldHeight);
    UITextView *textView = [[UITextView alloc] initWithFrame:fieldRect];
    [textView.layer setBorderWidth:1.0f];
    [textView.layer setCornerRadius:5.0f];
    [textView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [textView setKeyboardType:UIKeyboardTypeDefault];
    
    self.textView = textView;
    [self addSubview:textView];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // seperator line
    CGFloat seperatorY = REMARK_CELL_FIELD_HEIGHT - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
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
