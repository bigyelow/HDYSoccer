//
//  SimpleEditCell.h
//  HDYSoccer
//
//  Created by bigyelow on 11/15/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SimpleEditCell : UITableViewCell

- (void)setTitle:(NSString *)title;
- (void)setText:(NSString *)text;
- (void)setKeyboardType:(UIKeyboardType)keyboardType;
- (void)setInputView:(UIView *)view;
- (void)setInputAccessoryView:(UIView *)view;
- (BOOL)resignFirstResponder;
@end
