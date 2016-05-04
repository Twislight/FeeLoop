//
//  PlayerController.h
//  FeeLoop
//
//  Created by 郑翔匀 on 16/4/23.
//  Copyright © 2016年 twsit. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MediaPlayer/MediaPlayer.h>
#import "MenuModel.h"

@interface PlayerController : UIViewController


@property (nonatomic,strong) MenuModel *songDetail;
@property (nonatomic) NSInteger songRow;
@property (nonatomic,strong) MPMediaItemCollection *detailCollection;
@property (nonatomic) MPMediaQuery *songQuery;//音乐队列
@property (nonatomic,strong) NSArray *songItems;
@property (nonatomic,strong) MPMediaItem *songItem;
@property (nonatomic,strong) MPMusicPlayerController *songPlayer;//播放器
@property (nonatomic,strong) NSString *playResource;//播放来源

@property (weak, nonatomic) IBOutlet UIImageView *artImageView;//专辑图片
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;//背景图片

@property (weak, nonatomic) IBOutlet UISlider *songSlider;//进度条
- (IBAction)actionSlider:(UISlider *)sender;//滑动条

@property (nonatomic,strong) NSTimer *refreshTime;//刷新时间

@property (weak, nonatomic) IBOutlet UILabel *rightNow;//当前时间
@property (weak, nonatomic) IBOutlet UILabel *totalTime;//总时间


- (IBAction)palyAndPayse:(UIButton *)sender;//播放暂停
- (IBAction)nextBut:(id)sender;//下一曲

- (IBAction)preciousBut:(id)sender;//上一曲

- (IBAction)stopBut:(id)sender;//停止播放
- (IBAction)setMode:(UIButton *)sender;//设置循环模式

//@property (nonatomic,assign) NSInteger *setCount;//设置播放模式


@end
