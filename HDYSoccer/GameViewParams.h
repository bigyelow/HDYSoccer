//
//  GameViewParams.h
//  HDYSoccer
//
//  Created by bigyelow on 3/29/14.
//  Copyright (c) 2014 bigyelow. All rights reserved.
//

#import "HDYSoccerGameCell.h"
#import "SegmentView.h"

#ifndef HDYSoccer_GameViewParams_h
#define HDYSoccer_GameViewParams_h


#define HEADER_IDENTIFIER @"GameListHeader"
#define FOOTER_IDENTIFIER @"GameListFooter"

#define GAME_TITLE @"约球"

// layout
#define FOOTER_HEIGHT 0.0f

#define MINIMUM_COLUMN_SPACE 0  // 列距
#define MINIMUM_INTERITEM_SPACE 10 // 行距

#define COLUMN_NUMBER 1
#define SECTION_NUMBER 1
#define SECTION_BACKGROUND_COLOR @"#e7f9ff"
#define SECTION_INSET (UIEdgeInsetsMake(SEGMENT_VIEW_HEIGHT, 0, 10, 0))

// cell
#define GAME_CELL_IDENTIFIER @"GameCell"
#define CELL_HEIGHT 44
#define CELL_WIDTH 125
#define CELL_BACKGROUND_COLOR @"#eeeeee"

#endif
