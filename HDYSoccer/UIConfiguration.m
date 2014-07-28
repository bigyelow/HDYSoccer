//
//  UIConfiguration.m
//  HDYSoccer
//
//  Created by bigyelow on 3/27/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "UIConfiguration.h"
#import "MBProgresshud.h"

@implementation UIConfiguration

#pragma mark - label
+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font
             numberOfLines:(NSInteger)numberOfLines
{
  UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
  [label setText:text];
  if (textColor) {
    [label setTextColor:textColor];
  }
  if (font) {
    [label setFont:font];
  }
  [label setNumberOfLines:numberOfLines];
  [label sizeToFit];
  
  return label;
}

+ (UILabel *)labelWithText:(NSString *)text
                 textColor:(UIColor *)textColor
                      font:(UIFont *)font
{
  NSInteger numberOfLines = 0;
  return [self labelWithText:text textColor:textColor font:font numberOfLines:numberOfLines];
}

#pragma mark - loading view

// tip message
+ (void)showTipMessageToView:(UIView *)view
                       title:(NSString *)title
{
  MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:view animated:NO];
  [hud setMode:MBProgressHUDModeIndeterminate];
  [hud setLabelText:title];
}

+ (void)showTipMessageToView:(UIView *)view
{
  [UIConfiguration showTipMessageToView:view title:TEXT_LOADING];
}

+ (void)hideTipMessageOnView:(UIView *)view
{
  [MBProgressHUD hideAllHUDsForView:view animated:YES];
}


// indicator
+ (void)showProcessIndicatorWithView:(UIView *)view
{
  [self showProcessIndicatorWithView:view
                             atPoint:CGPointMake(view.bounds.size.width / 2.f, view.bounds.size.height / 2.f)];
}

+ (void)showProcessIndicatorWithView:(UIView *)view atPoint:(CGPoint)point
{
  [self showProcessIndicatorWithView:view atPoint:point indicatorStyle:UIActivityIndicatorViewStyleWhite];
}
+ (void)showProcessIndicatorWithView:(UIView *)view atPoint:(CGPoint)point indicatorStyle:(UIActivityIndicatorViewStyle)style
{
	if ([view viewWithTag:2045])//已经有了，不需要重复添加
	{
		return;
	}
  
	UIView *backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 50, 35)];
	backView.backgroundColor = [UIColor clearColor];//colorWithWhite:0.2 alpha:0.7
	backView.center = point;
	backView.layer.cornerRadius = 4;
	backView.tag = 2045;
	
	UIActivityIndicatorView *indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:style];
	indicator.autoresizingMask = UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin;
	indicator.frame = CGRectMake(0, 0, 20, 20);
  indicator.center = CGPointMake(25, 35/2);
	[backView addSubview:indicator];
	[view addSubview:backView];
	[indicator startAnimating];
}


+ (void)hideProcessIndicatorWithView:(UIView *)view
{
	UIView *maskView = [view viewWithTag:2046];
	if( maskView != nil && view != nil)
	{
		[maskView removeFromSuperview];
	}
	UIView *indicator = [view viewWithTag:2045];
	if( indicator != nil && view != nil)
	{
		[indicator removeFromSuperview];
	}
}

#pragma mark - position adjust
+ (void)moveSubviewXToSuperviewCenter:(UIView *)superView
                              subview:(UIView *)subview
{
  CGFloat x = superView.center.x;
  CGFloat y = subview.center.y;
  
  [subview setCenter:CGPointMake(x, y)];
}

+ (void)moveSubviewYToSuperviewCenter:(UIView *)superView
                              subview:(UIView *)subview
{
  CGFloat x = subview.center.x;
  CGFloat y = superView.center.y;
  
  [subview setCenter:CGPointMake(x, y)];
}

+ (void)setView:(UIView *)view origin:(CGPoint)origin
{
  [self setView:view x:origin.x];
  [self setView:view y:origin.y];
}

+ (void)setView:(UIView *)view size:(CGSize)size
{
  [self setView:view height:size.height];
  [self setView:view width:size.width];
}

+ (void)setView:(UIView *)view x:(CGFloat)x
{
  CGRect rect = view.frame;
  rect.origin.x = x;
  [view setFrame:rect];
}

+ (void)setView:(UIView *)view y:(CGFloat)y
{
  CGRect rect = view.frame;
  rect.origin.y = y;
  [view setFrame:rect];
}

+ (void)setView:(UIView *)view height:(CGFloat)height
{
  CGRect rect = view.frame;
  rect.size.height = height;
  [view setFrame:rect];
}

+ (void)setView:(UIView *)view width:(CGFloat)width
{
  CGRect rect = view.frame;
  rect.size.width = width;
  [view setFrame:rect];
}

#pragma mark - keyboard
+ (CGRect)keyBoardRect:(NSNotification *)notification
{
  return [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue];
}

#pragma mark - image
+ (UIImage *)resizeImage:(UIImage *)srcImage width:(NSUInteger)width height:(NSUInteger)height
{
  if (srcImage == nil || width == 0 || height == 0) {
    return nil;
  }
  
  UIGraphicsBeginImageContext(CGSizeMake((CGFloat)width, (CGFloat)height));
  [srcImage drawInRect:CGRectMake(0.0, 0.0, (CGFloat)width, (CGFloat)height)];
  UIImage* dstImage = UIGraphicsGetImageFromCurrentImageContext();
  UIGraphicsEndImageContext();
  
	return dstImage;
};


@end
