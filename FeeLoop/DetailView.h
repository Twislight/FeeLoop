//
//  DetailView.h
//  FeeLoop
//
//  Created by 郑翔匀 on 16/4/21.
//  Copyright © 2016年 twsit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MenuModel.h"

@class MenuModel;

@interface DetailView : UITableViewController

@property (nonatomic,strong) MenuModel *detail;
@property (nonatomic) SongListType listType;
@property (nonatomic,strong) MPMediaItemCollection *collection;

@end
