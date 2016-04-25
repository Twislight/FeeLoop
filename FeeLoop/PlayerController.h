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
@property (nonatomic) MPMediaQuery *songQuery;
@property (nonatomic,strong) NSArray *songItems;
@property (nonatomic,strong) MPMediaItem *songItem;

@property (weak, nonatomic) IBOutlet UIImageView *artImageView;//专辑图片
@property (weak, nonatomic) IBOutlet UIImageView *backImageView;//背景图片

@property (weak, nonatomic) IBOutlet UISlider *songSlider;//进度条
- (IBAction)actionSlider:(id)sender;//滑动条

@property (weak, nonatomic) IBOutlet UILabel *rightNow;//当前时间
@property (weak, nonatomic) IBOutlet UILabel *totalTime;//总时间

@property (weak, nonatomic) IBOutlet UIButton *playPause;//播放暂停
@property (weak, nonatomic) IBOutlet UIButton *nextBut;//下一曲
@property (weak, nonatomic) IBOutlet UIButton *previousBut;//上一曲

@property (weak, nonatomic) IBOutlet UIButton *setBut;//播放模式按钮

@property (nonatomic,assign) NSInteger *setCount;//设置播放模式


@end
