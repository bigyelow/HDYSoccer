//
//  HDYSoccerGameViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 3/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HDYSoccerBaseViewController.h"
#import "CHTCollectionViewWaterfallLayout.h"

@interface HDYSoccerGameViewController : HDYSoccerBaseViewController
<UICollectionViewDataSource, CHTCollectionViewDelegateWaterfallLayout>

// segment control
@property (nonatomic, strong) UISegmentedControl *segControl;
@property (nonatomic, strong) UIView *segmentBackView;

// collection view
@property (nonatomic, strong) NSArray *collectionViewArray;
@property (nonatomic, strong) NSArray *collectionViewParams;
@property (nonatomic, strong) UIView *collectionBackgroundView;
- (void)updateCollectionViewLayout;

// filter item
@property (nonatomic, strong) UIBarButtonItem *filterItem;

// create game view
@property (nonatomic, strong) UIButton *personalGameButton;
@property (nonatomic, strong) UIButton *teamGameButton;
@property (nonatomic, strong) UIView *createView;
@property (nonatomic, strong) UIView *createBackBlurView;

@end
