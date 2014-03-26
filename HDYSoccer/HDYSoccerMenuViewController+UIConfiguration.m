//
//  HDYSoccerMenuViewController+UIConfiguration.m
//  HDYSoccer
//
//  Created by bigyelow on 3/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerMenuViewController+UIConfiguration.h"

@implementation HDYSoccerMenuViewController (UIConfiguration)

- (void)configTableView
{
  self.tableView.opaque = NO;
  self.tableView.backgroundColor = [UIColor clearColor];
}

- (void)configTableHeaderView
{
  UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 0, 184.0f)];
  UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 40, 100, 100)];
  imageView.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
  imageView.image = [UIImage imageNamed:@"bigyelow_avatar.jpg"];
  imageView.layer.masksToBounds = YES;
  imageView.layer.cornerRadius = 50.0;
  imageView.layer.borderColor = [UIColor whiteColor].CGColor;
  imageView.layer.borderWidth = 3.0f;
  imageView.layer.rasterizationScale = [UIScreen mainScreen].scale;
  imageView.layer.shouldRasterize = YES;
  imageView.clipsToBounds = YES;
  
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 150, 0, 24)];
  label.text = @"Bigyelow";
  label.font = [UIFont fontWithName:@"HelveticaNeue" size:21];
  label.backgroundColor = [UIColor clearColor];
  label.textColor = [UIColor colorWithRed:62/255.0f green:68/255.0f blue:75/255.0f alpha:1.0f];
  [label sizeToFit];
  label.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleRightMargin;
  
  [view addSubview:imageView];
  [view addSubview:label];
  
  self.tableView.tableHeaderView = view;
}

@end
