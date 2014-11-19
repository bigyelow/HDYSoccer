//
//  SimpleEditCell.m
//  HDYSoccer
//
//  Created by bigyelow on 11/15/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "SimpleEditCell.h"

#define HORIZONTAL_MARGIN 30

#define FIELD_TOP_MARGIN 10
#define FIELD_LEFT_MARGIN 10

#define SEPERATOR_TOP_MARGIN 3

@interface SimpleEditCell ()
{
  UILabel *_titleLabel;
  UITextField *_textField;
  UIView *_seperator;
}

@end

@implementation SimpleEditCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    [self setSelectionStyle:UITableViewCellSelectionStyleNone];
    
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    
    _textField = [UITextField new];
    [self.contentView addSubview:_textField];
  }
  
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  [_titleLabel sizeToFit];
  [UIConfiguration setView:_titleLabel x:HORIZONTAL_MARGIN];
  [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:_titleLabel];

  CGFloat textFieldWidth = self.bounds.size.width -CGRectGetMaxX(_titleLabel.frame) - FIELD_LEFT_MARGIN - HORIZONTAL_MARGIN;
  CGFloat textFieldX = CGRectGetMaxX(_titleLabel.frame) + FIELD_LEFT_MARGIN;
  CGFloat textFieldHeight = self.bounds.size.height - 2 * FIELD_TOP_MARGIN;
  [_textField setFrame:CGRectMake(textFieldX, 0, textFieldWidth, textFieldHeight)];
  [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:_textField];
  
  CGFloat seperRightInset = self.bounds.size.width - CGRectGetMaxX(_textField.frame);
  _seperator = [UIConfiguration seperatorWithLeftInset:textFieldX rightInset:seperRightInset];
  [UIConfiguration setView:_seperator y:CGRectGetMaxY(_textField.frame) + SEPERATOR_TOP_MARGIN];
  [self.contentView addSubview:_seperator];
}

- (void)setTitle:(NSString *)title
{
  [_titleLabel setText:title];
}

- (void)setInputView:(UIView *)view
{
  [_textField setInputView:view];
}

- (BOOL)resignFirstResponder
{
  if ([_textField isFirstResponder]) {
    return [_textField resignFirstResponder];
  }
  return NO;
}
@end
