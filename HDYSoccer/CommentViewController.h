//
//  CommentViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 8/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseTableViewController.h"
#import "CreateGameDetailViewController.h"

typedef NS_ENUM(NSUInteger, CommentType) {
  kCommentTypeGame,
  kCommentTypePerson
};

@interface CommentViewController : HDYSoccerBaseTableViewController

@property (nonatomic, assign) CommentType commentType;
@property (nonatomic, strong) NSArray *commentsArray;
@property (nonatomic, strong) NSMutableArray *cellHeightArray;

//GAME TYPE
@property (nonatomic, assign) GameType gameType;
@property (nonatomic, copy) NSString *gameID;


- (id)initWithGameType:(GameType)gameType
                gameID:(NSString *)gameID;
@end
