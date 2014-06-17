//
//  CostCell.m
//  HDYSoccer
//
//  Created by bigyelow on 6/16/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CostCell.h"

// title
#define TITLE_LEFT_MARGIN 10.0f

// text field
#define TEXT_FIELD_LEFT_MARGIN 10.0f
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
    // title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LEFT_MARGIN, 0, 0, 0)];
    [titleLabel setText:title];
    [titleLabel sizeToFit];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:titleLabel];
    
    // text field
    CGFloat fieldX = CGRectGetMaxX(titleLabel.frame) + TEXT_FIELD_LEFT_MARGIN;
    CGRect fieldRect = CGRectMake(fieldX, 0, TEXT_FIELD_WIDTH, TEXT_FIELD_HEIGHT);
    UITextField *textField = [[UITextField alloc] initWithFrame:fieldRect];
    [textField.layer setBorderWidth:1.0f];
    [textField.layer setCornerRadius:5.0f];
    [textField.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [textField setKeyboardType:UIKeyboardTypeNumberPad];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:textField];
    
    self.textField = textField;
    
    // measure
    CGFloat measureX = CGRectGetMaxX(textField.frame) + MEASURE_LEFT_MARGIN;
    UILabel *measureLabel = [[UILabel alloc] initWithFrame:CGRectMake(measureX, 0, 0, 0)];
    [measureLabel setText:TEXT_CHINESE_MEASURE];
    [measureLabel sizeToFit];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:measureLabel];
    
    [self.contentView addSubview:titleLabel];
    [self.contentView addSubview:textField];
    [self.contentView addSubview:measureLabel];
    
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
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
