//
//  EditHeightCell.m
//  HDYSoccer
//
//  Created by bigyelow on 11/15/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "EditHeightCell.h"

#define HORIZONTAL_MARGIN 15

@interface EditHeightCell ()
{
  UILabel *_titleLabel;
}

@end

@implementation EditHeightCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
  self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
  if (self) {
    _titleLabel = [UILabel new];
    [_titleLabel setText:TEXT_HEIGHT];
    [self.contentView addSubview:_titleLabel];
  }
  return self;
}

- (void)layoutSubviews
{
  [super layoutSubviews];
  
  [_titleLabel sizeToFit];
  [UIConfiguration setView:_titleLabel x:HORIZONTAL_MARGIN];
  [UIConfiguration moveSubviewYToSuperviewCenter:self.contentView subview:_titleLabel];
}


@end
