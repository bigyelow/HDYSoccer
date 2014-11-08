//
//  ProfileEditViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 11/2/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "ProfileEditViewController.h"
#import "Geeker.h"
#import "ProfileEditHeaderView.h"

@interface ProfileEditViewController ()
{
  Geeker *_soccer;
  ProfileEditHeaderView *_headerView;
}

@end

@implementation ProfileEditViewController

- (id)initWithSoccer:(Geeker *)soccer
{
  self = [super init];
  if (self) {
    _soccer = soccer;
  }
  
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];
  
  [self setTitle:[NSString stringWithFormat:@"%@的个人资料", _soccer.name]];
  
  _headerView = [[ProfileEditHeaderView alloc] init];
  [_headerView updateWithImageURLStr:_soccer.avatarURL];
  CGSize headerSize = [_headerView sizeThatFits:CGSizeMake(self.view.bounds.size.width, 0)];
  [UIConfiguration setView:_headerView size:headerSize];
  
  [self.tableView setTableHeaderView:_headerView];
}
@end
