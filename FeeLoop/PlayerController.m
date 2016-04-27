//
//  PlayerController.m
//  FeeLoop
//
//  Created by 郑翔匀 on 16/4/23.
//  Copyright © 2016年 twsit. All rights reserved.
//

#import "PlayerController.h"

@interface PlayerController ()
{
    MPMusicPlayerController *songPlayer;
}

@end

@implementation PlayerController

- (void)viewDidLoad {
    [super viewDidLoad];

    _songRow = self.songDetail.songRows;//获取所选歌曲所在的行
    
    [self songPlayer];
    
    [self loadSomething];//加载信息
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)rowChange
//{
//    [self.rowControl addObserver:self forKeyPath:@"indexOfNowPlayingItem" options:NSKeyValueObservingOptionInitial context:nil ];
//}
//
//-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSString *,id> *)change context:(void *)context
//{
//    NSLog(@"%@",[change objectForKey:@"new"]);
//}
//
//-(void)dealloc
//{
//    [self.rowControl removeObserver:self forKeyPath:@"indexOfNowPlayingItem"];
//}

-(MPMusicPlayerController *) songPlayer
{
    if(!songPlayer)
    {
        songPlayer = [MPMusicPlayerController systemMusicPlayer];
        [songPlayer beginGeneratingPlaybackNotifications];
        
    }
    [self addNotification];
    NSLog(@"shezhi");
    return songPlayer;
}

-(void)loadSomething
{
    if (self.songDetail.itemCollection == nil)
    {
        self.songQuery = [MPMediaQuery songsQuery];
        if(self.songQuery == nil)//如果没有媒体文件，则加载为空
        {
            _songRow = 0;
            _songItem = nil;
            self.title = @"Empty...";
        }
        else
        {
            _songItems  = [self.songQuery collections];
            MPMediaItemCollection *collection = [_songItems objectAtIndex:_songRow];
            _songItem = collection.representativeItem;
            self.title = [_songItem valueForProperty:MPMediaItemPropertyTitle];
            
//            songPlayer = [MPMusicPlayerController systemMusicPlayer];
            [songPlayer setQueueWithQuery:_songQuery];
            _songItems = [_songQuery items];
            [songPlayer setNowPlayingItem:[_songItems objectAtIndex:_songRow]];
            [songPlayer play];
        }
    }
    else
    {
        _detailCollection = self.songDetail.itemCollection;
        _songItem = [_detailCollection.items objectAtIndex:self.songRow];
        self.title = [_songItem valueForProperty:MPMediaItemPropertyTitle];
        
//        songPlayer = [MPMusicPlayerController systemMusicPlayer];
        [songPlayer setQueueWithItemCollection:_detailCollection];
        [songPlayer setNowPlayingItem:_songItem];
        [songPlayer play];
    }
    
    [self loadImage:_songRow :_songItem];//加载所选歌曲专辑封面
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
    
    
    self.artImageView.image = artwork;
    self.backImageView.image = artwork;
}

-(void)addNotification
{
    NSNotificationCenter *rowNotification = [NSNotificationCenter defaultCenter];
    [rowNotification addObserver:self selector:@selector(nowPlayingItemChange :) name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:songPlayer];
    NSLog(@"tongzhi");
}

-(void)nowPlayingItemChange :(NSNotification *) notification
{
    MPMediaItem *item = songPlayer.nowPlayingItem;
    NSUInteger songRowNum = songPlayer.indexOfNowPlayingItem;
    NSLog(@"%lu",(unsigned long)songRowNum);
}

-(void) dealloc
{
    [songPlayer endGeneratingPlaybackNotifications];
}

- (IBAction)actionSlider:(id)sender//滑动条
{
    
}
- (IBAction)playPause:(id)sender//播放暂停
{
    
}

- (IBAction)nextBut:(id)sender//下一曲
{
    
}

- (IBAction)previousBut:(id)sender//上一曲
{
    
}

- (IBAction)setBut:(id)sender//播放模式
{
    
}
@end
