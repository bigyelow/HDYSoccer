//
//  ChooseFieldCell.m
//  HDYSoccer
//
//  Created by bigyelow on 8/28/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ChooseFieldCell.h"
#import "GameListFilterTableViewCell.h"

// image
#define FIELD_IMAGE_LEFT_MARGIN 11.0F
#define FIELD_IMAGE_TOP_MARGIN 15.0F
#define FIELD_IMAGE_WIDTH 13.0F
#define FIELD_IMAGE_HEIGHT 13.0F

// title
#define TITLE_LEFT_MARGIN 10.0f

// text field
#define TEXT_FIELD_LEFT_MARGIN 7.0f
#define TEXT_FIELD_WIDTH 225.0f
#define TEXT_FIELD_TOP_MARGIN 9.0F
#define TEXT_FIELD_BOTTOM_MARGIN 9.0F
#define FIELD_FONT_SIZE 14.0F

@implementation ChooseFieldCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setBackgroundColor:[UIColor clearColor]];
    [self.contentView setBackgroundColor:[UIConfiguration colorForHex:GAME_LIST_FILTER_CELL_BACKGROUND_COLOR]];
    [self.contentView setAlpha:0.5];
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    // FIELD IMAGE
    UIImage *fieldImage = [UIImage imageNamed:@"location-75.png"];
    CGRect fieldRect = CGRectMake(FIELD_IMAGE_LEFT_MARGIN, FIELD_IMAGE_TOP_MARGIN, FIELD_IMAGE_WIDTH, FIELD_IMAGE_HEIGHT);
    UIImageView *fieldView = [[UIImageView alloc] initWithFrame:fieldRect];
    [fieldView setImage:fieldImage];
    
    [self addSubview:fieldView];
    
    // title
    CGFloat titleX = CGRectGetMaxX(fieldView.frame) + TITLE_LEFT_MARGIN;
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(titleX, 0, 0, 0)];
    [titleLabel setText:TEXT_FIELD];
    [titleLabel sizeToFit];
    [titleLabel setTextColor:[UIColor whiteColor]];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:titleLabel];
    
    [self addSubview:titleLabel];
    
    // text view
    CGFloat textX = CGRectGetMaxX(titleLabel.frame) + TEXT_FIELD_LEFT_MARGIN;
    CGFloat textHeight = CHOOSE_FIELD_CELL_HEIGHT - TEXT_FIELD_BOTTOM_MARGIN - TEXT_FIELD_TOP_MARGIN;
    CGRect textRect = CGRectMake(textX, TEXT_FIELD_TOP_MARGIN, TEXT_FIELD_WIDTH, textHeight);
    UITextView *textView = [[UITextView alloc] initWithFrame:textRect];
    [textView.layer setBorderWidth:1.0f];
    [textView.layer setCornerRadius:5.0f];
    [textView setFont:[UIFont systemFontOfSize:FIELD_FONT_SIZE]];
    [textView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [textView setKeyboardType:UIKeyboardTypeDefault];
    [textView setTintColor:[UIColor blackColor]];
    
    self.textView = textView;
    [self addSubview:textView];
    
    // seperator line
    CGFloat seperatorY = CHOOSE_FIELD_CELL_HEIGHT - GAME_LIST_FILTER_CELL_SEPERATOR_HEIGHT;
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
