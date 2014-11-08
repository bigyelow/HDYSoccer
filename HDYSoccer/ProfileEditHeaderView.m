//
//  ProfileEditHeaderView.m
//  HDYSoccer
//
//  Created by bigyelow on 11/8/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

static CGFloat const kAvatarTopMargin                   = 15;
static CGFloat const kAvatarWidth                       = 80;
static CGFloat const kAvatarBoarderWidth                = 3;

static CGFloat const kTitleTopMargin                    = 10;
static CGFloat const KTitleBottomMargin                 = 10;

#import "ProfileEditHeaderView.h"

#import "UIImageView+WebCache.h"

@interface ProfileEditHeaderView ()
{
  UIImageView *_avatarView;
  UILabel *_titleLabel;
}

@end

@implementation ProfileEditHeaderView

- (id)initWithFrame:(CGRect)frame
{
  self = [super initWithFrame:frame];
  if (self) {
    
    // avatar
    _avatarView = [UIImageView newAutoLayoutView];
    _avatarView.layer.cornerRadius = kAvatarWidth / 2;
    _avatarView.layer.borderColor = [UIColor whiteColor].CGColor;
    _avatarView.layer.borderWidth = kAvatarBoarderWidth;
    _avatarView.layer.rasterizationScale = [UIScreen mainScreen].scale;
    _avatarView.layer.shouldRasterize = YES;
    _avatarView.clipsToBounds = YES;
    
    [self addSubview:_avatarView];
    
    // title
    _titleLabel = [UILabel newAutoLayoutView];
    [_titleLabel setText:TEXT_UPLOAD_AVATAR];
    [_titleLabel setTextColor:[UIColor lightGrayColor]];
    [_titleLabel setFont:[UIFont systemFontOfSize:16]];
    
    [self addSubview:_titleLabel];
    
    [self initConstraints];
  }
  
  return self;
}

- (void)initConstraints
{
  [_avatarView autoSetDimensionsToSize:CGSizeMake(kAvatarWidth, kAvatarWidth)];
  [_avatarView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:kAvatarTopMargin];
  [_avatarView autoAlignAxisToSuperviewAxis:ALAxisVertical];
  
  [_titleLabel autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_avatarView withOffset:kTitleTopMargin];
  [_titleLabel autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:KTitleBottomMargin];
  [_titleLabel autoAlignAxisToSuperviewAxis:ALAxisVertical];
}

- (void)updateWithImageURLStr:(NSString *)imageURLStr
{
  [_avatarView sd_setImageWithURL:[NSURL URLWithString:imageURLStr]];
}

- (CGSize)sizeThatFits:(CGSize)size
{
  CGFloat titleHeight = [_titleLabel sizeThatFits:CGSizeMake(size.width, 0)].height;
  return CGSizeMake(size.width, kAvatarTopMargin + kAvatarWidth + kTitleTopMargin + titleHeight + KTitleBottomMargin);
}
@end
