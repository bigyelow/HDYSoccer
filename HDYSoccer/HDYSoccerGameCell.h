//
//  HDYSoccerGameCell.h
//  HDYSoccer
//
//  Created by bigyelow on 3/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SimplePersonalGameInfo;

@interface HDYSoccerGameCell : UICollectionViewCell

@property (nonatomic, copy) NSString *displayString;
@property (nonatomic, strong) IBOutlet UILabel *displayLabel;

//
@property (nonatomic, strong) UIImageView *imageView;
- (void)configWithGameInfo:(SimplePersonalGameInfo *)gameInfo;
@end
