//
//  GeekerChatsViewController.h
//  HDYSoccer
//
//  Created by XueMing on 11/27/15.
//  Copyright © 2015 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GeekerChatsViewController;

@protocol ModalViewControllerDelegate <NSObject>

- (void)modelViewControllerDismiss:(GeekerChatsViewController *)controller;

@end

@interface GeekerChatsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, weak) id<ModalViewControllerDelegate> delegate;

@end
