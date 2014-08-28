//
//  CommentViewController.h
//  HDYSoccer
//
//  Created by bigyelow on 8/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerBaseTableViewController.h"
#import "CreateGameDetailViewController.h"
#import "RegisterAndLoginViewController.h"

@class CommentField;

typedef NS_ENUM(NSUInteger, CommentType) {
  kCommentTypeGame,
  kCommentTypePerson
};

@interface CommentViewController : HDYSoccerBaseTableViewController
<RegisterAndLoginDelegate>

@property (nonatomic, assign) CommentType commentType;
@property (nonatomic, strong) NSMutableArray *commentsArray;
@property (nonatomic, strong) NSMutableArray *cellHeightArray;
@property (nonatomic, assign) BOOL isKeyboardShowed;
@property (nonatomic, assign) NSInteger commentStart;
@property (nonatomic, assign) NSInteger selectedCommentIndex;

// COMMENT FIELD
@property (nonatomic, assign) BOOL isReply;
@property (nonatomic, strong) CommentField *commentView;

//GAME TYPE
@property (nonatomic, assign) GameType gameType;
@property (nonatomic, copy) NSString *gameID;


- (id)initWithGameType:(GameType)gameType
                gameID:(NSString *)gameID;
@end
