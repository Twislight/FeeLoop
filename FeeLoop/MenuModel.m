//
//  MenuModel.m
//  FeeLoop
//
//  Created by 郑翔匀 on 16/4/19.
//  Copyright © 2016年 twsit. All rights reserved.
//

#import "MenuModel.h"

@implementation MenuModel
//menuTable标题
- (NSString *) titleForRow: (int) row
{
    switch (row)
    {
        case 0:
            _menuTitle = @"歌曲";
            break;
        case 1:
            _menuTitle = @"专辑";
            break;
        case 2:
            _menuTitle = @"表演者";
            break;
        case 3:
            _menuTitle = @"选集";
            break;
        case 4:
            _menuTitle = @"作曲";
            break;
    }
    return _menuTitle;
}
//menuTable图片
- (NSString *) imageNameForRow: (int) row
{
    switch (row){
        case 0:
            _menuImage = @"img_list_songs";
            break;
        case 1:
            _menuImage = @"img_list_albums";
            break;
        case 2:
            _menuImage = @"img_list_artists";
            break;
        case 3:
            _menuImage = @"img_list_compilations";
            break;
        case 4:
            _menuImage = @"img_list_composers";
            break;
    }
    return _menuImage;
}


@end
