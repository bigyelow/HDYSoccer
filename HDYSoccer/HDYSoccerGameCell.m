//
//  HDYSoccerGameCell.m
//  HDYSoccer
//
//  Created by bigyelow on 3/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameCell.h"
#import "UIConfiguration+Color.h"
#import "GameViewParams.h"
#import "SimplePersonalGameInfo.h"
#import "UIImageView+WebCache.h"

@implementation HDYSoccerGameCell

- (id)initWithFrame:(CGRect)frame
{
	if (self = [super initWithFrame:frame]) {
    [self.contentView setBackgroundColor:[UIColor lightGrayColor]];
    if (!self.imageView) {
      UIImageView *imageView = [[UIImageView alloc] initWithFrame:self.contentView.bounds];
      self.imageView = imageView;
      [self.contentView addSubview:self.imageView];
    }
	}
	return self;
}

- (void)configWithGameInfo:(SimplePersonalGameInfo *)gameInfo
{
  [self.imageView setImageWithURL:[NSURL URLWithString:gameInfo.avatarURL] placeholderImage:nil];
}

#pragma mark - Accessors
- (UILabel *)displayLabel
{
	if (!_displayLabel) {
		_displayLabel = [[UILabel alloc] initWithFrame:self.contentView.bounds];
		_displayLabel.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
		_displayLabel.backgroundColor = [UIConfiguration colorForHex:CELL_BACKGROUND_COLOR];
		_displayLabel.textColor = [UIColor whiteColor];
		_displayLabel.textAlignment = NSTextAlignmentCenter;
	}
	return _displayLabel;
}

- (void)setDisplayString:(NSString *)displayString
{
	if (![_displayString isEqualToString:displayString]) {
		_displayString = [displayString copy];
		self.displayLabel.text = _displayString;
	}
}


@end
