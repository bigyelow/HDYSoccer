//
//  HDYSoccerGameViewController+CreateGame.h
//  HDYSoccer
//
//  Created by bigyelow on 6/8/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameViewController.h"
#import "CreateGameViewController.h"
#import "RegisterAndLoginViewController+Action.h"

@interface HDYSoccerGameViewController (CreateGame)
<createGameDelegate, RegisterAndLoginDelegate>

- (void)configTopCreateButton;
@end
