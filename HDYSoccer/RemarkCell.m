//
//  RemarkCell.m
//  HDYSoccer
//
//  Created by bigyelow on 6/17/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "RemarkCell.h"

// title
#define TITLE_LEFT_MARGIN 10.0f

// text field
#define TEXT_FIELD_LEFT_MARGIN 10.0f
#define TEXT_FIELD_WIDTH 225.0f

@implementation RemarkCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    // title
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(TITLE_LEFT_MARGIN, 0, 0, 0)];
    [titleLabel setText:TEXT_REMARK];
    [titleLabel sizeToFit];
    [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:titleLabel];
    
    // text field
    CGFloat fieldX = CGRectGetMaxX(titleLabel.frame) + TEXT_FIELD_LEFT_MARGIN;
    CGRect fieldRect = CGRectMake(fieldX, 0, TEXT_FIELD_WIDTH, REMARK_CELL_FIELD_HEIGHT);
    UITextView *textView = [[UITextView alloc] initWithFrame:fieldRect];
    [textView.layer setBorderWidth:1.0f];
    [textView.layer setCornerRadius:5.0f];
    [textView.layer setBorderColor:[UIColor lightGrayColor].CGColor];
    [textView setKeyboardType:UIKeyboardTypeDefault];
    
    self.textView = textView;
    
    [self.contentView addSubview:titleLabel];
    [self.contentView addSubview:textView];
    
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
