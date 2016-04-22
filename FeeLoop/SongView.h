//
//  SongView.h
//  FeeLoop
//
//  Created by 郑翔匀 on 16/4/19.
//  Copyright © 2016年 twsit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MenuModel.h"

@class MenuModel;

@interface SongView : UITableViewController

@property (nonatomic,strong) MenuModel *song;

@property (nonatomic) SongListType listType;
@property (nonatomic,strong) NSArray *songItems;
@property (strong) MPMediaQuery *songQuery;


@end
