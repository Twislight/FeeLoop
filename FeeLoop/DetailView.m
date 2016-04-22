//
//  DetailView.m
//  FeeLoop
//
//  Created by 郑翔匀 on 16/4/21.
//  Copyright © 2016年 twsit. All rights reserved.
//

#import "DetailView.h"
#import "MenuModel.h"

@interface DetailView ()

@end

@implementation DetailView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.detail.titleitem;//获取标题
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
