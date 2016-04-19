//
//  MenuModel.h
//  FeeLoop
//
//  Created by 郑翔匀 on 16/4/19.
//  Copyright © 2016年 twsit. All rights reserved.
//

#import <Foundation/Foundation.h>

//歌曲信息类型
typedef enum { song_list, album_list, artist_list,compilation_list, composer_list, list_num } SongListType;

@interface MenuModel : NSObject

//首页标题和图片
@property (nonatomic,strong) NSString *menuTitle;
@property (nonatomic,strong) NSString *menuImage;

//
@property (nonatomic,strong) NSString *titleitem;
@property (nonatomic) NSInteger *num;

- (NSString *) titleForRow: (int) row;
- (NSString *) imageNameForRow: (int) row;

@end
