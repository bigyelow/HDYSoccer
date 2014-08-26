//
//  CommentViewController.m
//  HDYSoccer
//
//  Created by bigyelow on 8/26/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "CommentViewController.h"
#import "CommentViewController+Network.h"
#import "Comment.h"
#import "CommentCell.h"
#import "ReplyCell.h"

@interface CommentViewController ()

@end

@implementation CommentViewController

- (id)initWithGameType:(GameType)gameType
                gameID:(NSString *)gameID
{
  self = [super init];
  if (self) {
    self.commentType = kCommentTypeGame;
    self.gameType = gameType;
    self.gameID = @"1000";
  }
  return self;
}

- (void)viewDidLoad
{
  [super viewDidLoad];

  [self.tableView setHidden:YES];
  [self.tableView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
  
  [self configTopButtons];
  [self loadGameCommentsWithGameType:self.gameType gameID:self.gameID];
}

- (void)didReceiveMemoryWarning
{
  [super didReceiveMemoryWarning];

}

- (void)configTopButtons
{
  // cancel item
  UIButton *cancelButton = [self topButtonWithImageName:TOP_CANCEL_IMAGE];
  [UIConfiguration setView:cancelButton size:CGSizeMake(TOP_CANCEL_BUTTON_WIDTH, TOP_CANCEL_BUTTON_WIDTH)];
  [cancelButton addTarget:self action:@selector(cancelItemPressed) forControlEvents:UIControlEventTouchUpInside];
  UIBarButtonItem *cancelItem = [[UIBarButtonItem alloc] initWithCustomView:cancelButton];
  [self.navigationItem setLeftBarButtonItem:cancelItem];
}

- (void)cancelItemPressed
{
  [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tableView delegate & datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
  return [self.commentsArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
  Comment *comment = self.commentsArray[section];
  return 1 + [comment.replys count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
  Comment *comment = self.commentsArray[indexPath.section];
  if (indexPath.row == 0) {
    CGFloat height = [CommentCell cellHeightForContent:comment.content];
    NSMutableArray *array = self.cellHeightArray[indexPath.section];
    NSNumber *number = [NSNumber numberWithFloat:height];
    [array replaceObjectAtIndex:indexPath.row withObject:number];
    
    return height;
  }
  else {
    return 0;
  }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
  Comment *comment = self.commentsArray[indexPath.section];
  NSNumber *cellHeight;
  if (indexPath.row == 0) {
    static NSString *cellID = COMMENT_CELL_ID;
    CommentCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
      cell = [[CommentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cellHeight = self.cellHeightArray[indexPath.section][indexPath.row];
    [cell configCellWithComment:comment cellHeight:cellHeight.floatValue];
    
    return cell;
  }
  else {
    static NSString *cellID = REPLY_CELL_ID;
    ReplyCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
      cell = [[ReplyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    return cell;
  }
}

@end
