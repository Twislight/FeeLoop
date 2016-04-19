//
//  SongView.m
//  FeeLoop
//
//  Created by 郑翔匀 on 16/4/19.
//  Copyright © 2016年 twsit. All rights reserved.
//

#import "SongView.h"
#import "SongModel.h"
#import "MenuView.h"
#import "MenuModel.h"

@interface SongView ()

@end

@implementation SongView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.song.titleitem;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
