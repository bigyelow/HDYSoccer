//
//  CostCell.m
//  HDYSoccer
//
//  Created by bigyelow on 6/16/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CostCell.h"
#import "GameListFilterTableViewCell.h"

// image
#define COST_IMAGE_LEFT_MARGIN 5.0F
#define COST_IMAGE_TOP_MARGIN 9.0F
#define COST_IMAGE_WIDTH 23.0F
#define COST_IMAGE_HEIGHT 25.0F

// title
#define TITLE_LEFT_MARGIN 7.0f

// text field
#define TEXT_FIELD_LEFT_MARGIN 5.0f
#define TEXT_FIELD_WIDTH 80.0f
#define TEXT_FIELD_HEIGHT 30.0f

// measure
#define MEASURE_LEFT_MARGIN 5.0f

@implementation CostCell

- (id)initWithStyle:(UITableViewCellStyle)style
    reuseIdentifier:(NSString *)reuseIdentifier
              title:(NSString *)title
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    //
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
    
    [self addSubview:titleLabel];

    // text field
    CGFloat fieldX = CGRectGetMaxX(titleLabel.frame) + TEXT_FIELD_LEFT_MARGIN;
    CGRect fieldRect = CGRectMake(fieldX, 0, TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT);
    UITextField *textField = [[UITextField alloc] initWithFrame:fieldRect];
    [textField setBackgroundColor:[UIColor whiteColor]];
    [textField setTintColor:[UIColor blackColor]];
    [textField.layer setBorderWidth:1.0f];
    [textField.layer setCornerRadius:5.0f];
    [textField.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [textField setKeyboardType:UIKeyboardTypeNumberPad];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:textField];
    
    self.textField = textField;
    [self addSubview:textField];

    // measure
    CGFloat measureX = CGRectGetMaxX(textField.frame) + MEASURE_LEFT_MARGIN;
    UILabel *measureLabel = [[UILabel alloc] initWithFrame:CGRectMake(measureX, 0, 0, 0)];
    [measureLabel setText:TEXT_CHINESE_MEASURE];
    [measureLabel sizeToFit];
    [measureLabel setTextColor:[UIColor whiteColor]];
    [UIConfiguration moveSubviewYToSuperviewCenter:self subview:measureLabel];
    
    [self addSubview:measureLabel];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
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
