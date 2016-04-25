//
//  PlayerController.m
//  FeeLoop
//
//  Created by 郑翔匀 on 16/4/23.
//  Copyright © 2016年 twsit. All rights reserved.
//

#import "PlayerController.h"

@interface PlayerController ()

@end

@implementation PlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
//    NSLog(@"%ld",(long)self.songDetail.songRows);
    _songRow = self.songDetail.songRows;//获取所选歌曲所在的行

    if (self.songDetail.itemCollection == nil)
    {
        self.songQuery = [MPMediaQuery songsQuery];
        if(self.songDetail == nil)//如果没有媒体文件，则加载为空
        {
            _songRow = 0;
            _songItem = nil;
        }
        else
        {
            _songItems  = [self.songQuery collections];
            MPMediaItemCollection *collection = [_songItems objectAtIndex:_songRow];
            _songItem = collection.representativeItem;
        }
        
    }
    else
    {
        _detailCollection = self.songDetail.itemCollection;
        _songItem = [_detailCollection.items objectAtIndex:self.songRow];
        
    }
    
    [self loadImage:_songRow :_songItem];//加载所选歌曲专辑封面
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//加载专辑封面
-(void)loadImage :(NSInteger) songRow :(MPMediaItem *)item
{
    
    UIImage *artwork = nil;//创建图片对象
    //如果歌曲包含专辑封面，则显示歌曲中的专辑封面
    if ([item valueForProperty:MPMediaItemPropertyArtwork])
        artwork = [[item valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(500, 500)];//加载图片的像素大小
    //如果歌曲未包含封面，则显示预设的图片
    if (artwork == nil)
        artwork = [UIImage imageNamed: @"empty"];
//    UIImage *artworkEffect = [artwork blurImage];
    
    
    
    self.artImageView.image = artwork;
    self.backImageView.image = artwork;
}

- (IBAction)actionSlider:(id)sender {
}
@end
