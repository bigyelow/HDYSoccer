//
//  TeamDetailViewController+NetworkOperation.h
//  HDYSoccer
//
//  Created by bigyelow on 8/18/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "TeamDetailViewController.h"

@interface TeamDetailViewController (NetworkOperation)
- (void)loadTeamInfoWithTeamID:(NSString *)teamID;
@end
