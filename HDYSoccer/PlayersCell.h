//
//  PlayersCell.h
//  HDYSoccer
//
//  Created by bigyelow on 6/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import <UIKit/UIKit.h>
@class SimpleGeekerInfo;

@interface PlayersCell : UITableViewCell

- (id)initWithSponsor:(SimpleGeekerInfo *)sponsor
         participants:(NSArray *)participants
         averageScore:(NSString *)averageScore
                style:(UITableViewCellStyle)style
              reuseID:(NSString *)reuseID;
+ (CGFloat)cellHeight:(NSInteger)participantsCount;
@end
