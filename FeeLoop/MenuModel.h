//
//  MenuModel.h
//  FeeLoop
//
//  Created by 郑翔匀 on 16/4/19.
//  Copyright © 2016年 twsit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MediaPlayer/MediaPlayer.h>

//歌曲信息类型
typedef enum { song_list, album_list, artist_list,compilation_list, composer_list, list_num } SongListType;

@interface MenuModel : NSObject

//首页标题和图片
@property (nonatomic,strong) NSString *menuTitle;
@property (nonatomic,strong) NSString *menuImage;

//
@property (nonatomic) SongListType listType;//音乐类型
@property (nonatomic,strong) NSString *titleitem;//标题
@property (nonatomic,strong) MPMediaItemCollection *itemCollection;//音乐队列
@property (nonatomic) NSInteger songRows;//行号


- (NSString *) titleForRow: (int) row;
- (NSString *) imageNameForRow: (int) row;

@end
