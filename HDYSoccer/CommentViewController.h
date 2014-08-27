//
//  CommentViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 8/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseTableViewController.h"
#import "CreateGameDetailViewController.h"
@class CommentField;

typedef NS_ENUM(NSUInteger, CommentType) {
  kCommentTypeGame,
  kCommentTypePerson
};

@interface CommentViewController : HDYSoccerBaseTableViewController

@property (nonatomic, assign) CommentType commentType;
@property (nonatomic, strong) NSArray *commentsArray;
@property (nonatomic, strong) NSMutableArray *cellHeightArray;
@property (nonatomic, assign) BOOL isKeyboardShowed;

// COMMENT FIELD
@property (nonatomic, assign) BOOL isReply;
@property (nonatomic, strong) CommentField *commentView;

//GAME TYPE
@property (nonatomic, assign) GameType gameType;
@property (nonatomic, copy) NSString *gameID;


- (id)initWithGameType:(GameType)gameType
                gameID:(NSString *)gameID;
@end
