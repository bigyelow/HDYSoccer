//
//  CPTransitionAnimator.h
//  HDYSoccer
//
//  Created by bigyelow on 8/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <Foundation/Foundation.h>

#define CPTRANSITION_ENDFRAME_WIDTH (WINDOW_FRAME.size.width / 7 * 5)
#define CPTRANSITION_ENDFRAME_HEIGHT (WINDOW_FRAME.size.height)
#define CPTRANSITION_ENDFRAME_X (WINDOW_FRAME.size.width / 7 * 2)
#define CPTRANSITION_ENDFRAME_Y (0)
#define CPTRANSITION_ENDFRAME \
        CGRectMake(CPTRANSITION_ENDFRAME_X, CPTRANSITION_ENDFRAME_Y, CPTRANSITION_ENDFRAME_WIDTH, CPTRANSITION_ENDFRAME_HEIGHT)

@interface CPTransitionAnimator : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic, assign) BOOL presenting;
@end
