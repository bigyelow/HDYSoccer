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

@property (nonatomic, strong) UICollectionView *collectionView;

@end
