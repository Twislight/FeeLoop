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
    _detailCollection = self.detail.itemCollection;
    NSLog(@"%lu",(unsigned long)[_detailCollection.items count]);
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
//    NSLog(@"%lu",(unsigned long)[_detailCollection.items count]);
    return [_detailCollection.items count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailList"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"detailList"];
    
    MPMediaItem *item = [_detailCollection.items objectAtIndex:indexPath.row];
    cell.textLabel.text = [item valueForProperty: MPMediaItemPropertyTitle];
    
    // Album Cover Art
    UIImage *artwork = nil;
    if ([item valueForProperty:MPMediaItemPropertyArtwork])
        artwork = [[item valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(60, 60)];
    if (artwork == nil) artwork = [UIImage imageNamed: @"img_no_cover"];
    cell.imageView.image = artwork;
    
    return cell;
}

@end
