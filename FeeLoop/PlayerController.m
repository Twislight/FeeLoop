//
//  PlayerController.m
//  FeeLoop
//
//  Created by 贾亚丽 on 16/4/23.
//  Copyright © 2016年 twsit. All rights reserved.
//

#import "PlayerController.h"

@interface PlayerController ()

@end

@implementation PlayerController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    extern NSString *gsongSet;
    _playResource = gsongSet;
    gsongSet = nil;
    
    _songRow = self.songDetail.songRows;//获取所选歌曲所在的行
    
    [self setSongPlayer];//设置播放器
    
    [self loadSomething:_playResource];//加载信息
    
    [self loadNowPlaying];//加载当前播放
    
    [self setloopMode];
    
    [self createTimer];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)createTimer
{
    _refreshTime = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(loadRightNowTime) userInfo:nil repeats:YES];
//    [_refreshTime setFireDate:[NSDate distantFuture]];
}

-(MPMusicPlayerController *) setSongPlayer//设置播放器
{
    if(!_songPlayer)
    {
        _songPlayer = [MPMusicPlayerController systemMusicPlayer];//调用系统播放器
        [_songPlayer beginGeneratingPlaybackNotifications];//开启通知
//        _songPlayer.shuffleMode = 1;
    }
    
    [self addNotification];//添加通知
    
    return _songPlayer;
}

-(void)loadSomething :(NSString *)playSource
{
    if (playSource == nil)
    {
        [self loadNowPlaying];
    }
    else if ([playSource isEqual: @"songsSet"])
    {
        self.songQuery = [MPMediaQuery songsQuery];
        _songItems  = [self.songQuery collections];
        MPMediaItemCollection *collection = [_songItems objectAtIndex:_songRow];
        
        _songItem = collection.representativeItem;
        [_songPlayer setQueueWithQuery:_songQuery];
        _songItems = [_songQuery items];
        [_songPlayer setNowPlayingItem:[_songItems objectAtIndex:_songRow]];
        [_songPlayer play];
        [_playPause setBackgroundImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
        
    }
    else
    {
        _detailCollection = self.songDetail.itemCollection;
        _songItem = [_detailCollection.items objectAtIndex:self.songRow];

        [_songPlayer setQueueWithItemCollection:_detailCollection];
        [_songPlayer setNowPlayingItem:_songItem];
        [_songPlayer play];
        [_playPause setBackgroundImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
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
    //设置标题
    self.title = [item valueForProperty:MPMediaItemPropertyTitle];
    if(self.title == nil)
        self.title = @"已停止播放";
    //设置专辑封面
    self.artImageView.image = artwork;
    self.backImageView.image = artwork;
    self.totalTime.text = [self getSongTimeString];//加载歌曲总时间
}

-(void)addNotification//添加通知
{
    NSNotificationCenter *rowNotification = [NSNotificationCenter defaultCenter];
    [rowNotification addObserver:self selector:@selector(nowPlayingItemChange :) name:MPMusicPlayerControllerNowPlayingItemDidChangeNotification object:_songPlayer];
}

-(void)nowPlayingItemChange :(NSNotification *) notification//当前播放条目改变的通知
{
    MPMediaItem *item = _songPlayer.nowPlayingItem;//当前播放的音乐条目
    NSUInteger songRowNum = _songPlayer.indexOfNowPlayingItem;//当前播放的音乐所在队列的序号
    
    [self loadImage:songRowNum :item];//加载专辑封面
}

-(void) loadNowPlaying
{
    MPMediaItem *item = _songPlayer.nowPlayingItem;//当前播放的音乐条目
    NSUInteger songRowNum = _songPlayer.indexOfNowPlayingItem;//当前播放的音乐所在队列的序号
    [self loadImage:songRowNum :item];//加载专辑封面
    if(_songPlayer.playbackState == MPMusicPlaybackStatePlaying)
    {
        [_playPause setBackgroundImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
    }
    else
    {
        [_playPause setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
    }
}

-(void) dealloc//销毁通知
{
    [_songPlayer endGeneratingPlaybackNotifications];
}

-(NSString *)getSongTimeString//取得当前播放歌曲总时间
{
    float songTime = [[_songPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyPlaybackDuration] floatValue];
    float songMin = songTime / 60;
    float songSec = (int)songTime % 60;
    
    return [NSString stringWithFormat:@"%02d:%02d",(int)songMin,(int)songSec];
}

-(void) loadRightNowTime //加载当前时间
{
    NSTimeInterval rightNowTime = _songPlayer.currentPlaybackTime;
    NSString *rightNow = [NSString stringWithFormat:@"%02li:%02li", lround(floor(rightNowTime / 60.)) % 60,
                          lround(floor(rightNowTime)) % 60];
    if([rightNow isEqualToString:@"-8:-8"])
    {
        rightNow = @"00:00";
    }
    if([rightNow isEqualToString:@"-1:-1"])
    {
        rightNow = @"00:00";
    }
    _rightNow.text = rightNow;
    
    CGFloat rightNo = _songPlayer.currentPlaybackTime;
    float songTime = [[_songPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyPlaybackDuration] floatValue];
    self.songSlider.value = rightNo / songTime;
//    NSLog(@"%f",rightNo / songTime);
}

- (IBAction)playAndPause:(UIButton *)sender
{
    if (_songPlayer.playbackState == 1)
    {
        sender.selected = YES;
    }
    sender.selected = !sender.selected;
    if (sender.selected)
    {
        [_songPlayer play];
        [_refreshTime setFireDate:[NSDate date]];
        [_playPause setBackgroundImage:[UIImage imageNamed:@"Pause.png"] forState:UIControlStateNormal];
    }
    else
    {
        [_songPlayer pause];
        [_refreshTime setFireDate:[NSDate distantFuture]];
        [_playPause setBackgroundImage:[UIImage imageNamed:@"Play.png"] forState:UIControlStateNormal];
    }

}

- (IBAction)nextBut:(id)sender//下一曲
{
    [_songPlayer skipToNextItem];
}

- (IBAction)preciousBut:(id)sender//上一曲
{
    [_songPlayer skipToPreviousItem];
}

- (IBAction)stopBut:(id)sender//停止播放
{
    [_songPlayer stop];
    [self loadImage:0 :nil];
    self.songSlider.value = 0.0;
    self.rightNow.text = @"00:00";
    [_refreshTime setFireDate:[NSDate distantFuture]];
}

-(void)setloopMode//设置循环模式
{
    extern NSInteger gbutCount;
    NSInteger setLoop = gbutCount % 2;
    if(setLoop == 0)
        _songPlayer.repeatMode = setLoop + 1;
    if(setLoop == 1)
        _songPlayer.repeatMode = setLoop + 2;
}

- (IBAction)setMode:(UIButton *)sender//切换循环
{
    extern NSInteger gbutCount;
    gbutCount+=1;
    [self setloopMode];
}
- (IBAction)actionSlider:(UISlider *)sender//滑动条
{
    float songTime = [[_songPlayer.nowPlayingItem valueForProperty:MPMediaItemPropertyPlaybackDuration] floatValue];
    _songPlayer.currentPlaybackTime = songTime * self.songSlider.value;
//    NSLog(@"%f",self.songSlider.value);
}
@end
