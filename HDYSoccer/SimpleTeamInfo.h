//
//  SimpleTeamInfo.h
//  HDYSoccer
//
//  Created by bigyelow on 8/11/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "BaseObject.h"

typedef NS_ENUM(NSUInteger, GameResult) {
  GameResultWin = 3,
  GameResultDraw = 1,
  GameResultLose = 0,
};

@interface SimpleTeamInfo : BaseObject

@property (nonatomic, copy) NSString *teamID;
@property (nonatomic, copy) NSString *teamName;
@property (nonatomic, copy) NSString *averageScore;
@property (nonatomic, copy) NSString *teamAvatarURL;
@property (nonatomic, copy) NSString *captain;
@property (nonatomic, assign) NSInteger memberCount;
@property (nonatomic, strong) NSArray *recentRecords;
@end
