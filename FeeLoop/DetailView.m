//
//  DetailView.m
//  FeeLoop
//
//  Created by 郑翔匀 on 16/4/21.
//  Copyright © 2016年 twsit. All rights reserved.
//

#import "DetailView.h"
#import "MenuModel.h"
#import "PlayerController.h"

@interface DetailView ()
{
    NSMutableArray *lists;//可变数组
}

@end

@implementation DetailView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.detail.titleitem;//获取标题
    _detailCollection = self.detail.itemCollection;
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

//保存音乐信息
-(void)playList :(NSInteger)songRow :(MPMediaItemCollection *)songCollection
{
    lists = [[NSMutableArray alloc]initWithCapacity:1];
    MenuModel *list;
    list = [MenuModel new];
    list.songRows = songRow;
    list.itemCollection = songCollection;
    [lists addObject:list];
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
    return [_detailCollection.items count];//返回行数
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;//返回行高
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailList"];

    
    MPMediaItem *item = [_detailCollection.items objectAtIndex:indexPath.row];
    cell.textLabel.text = [item valueForProperty: MPMediaItemPropertyTitle];
    
    // Album Cover Art
    UIImage *artwork = nil;
    if ([item valueForProperty:MPMediaItemPropertyArtwork])
        artwork = [[item valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(60, 60)];
//        artwork = [item valueForProperty:MPMediaItemPropertyArtwork];
    if (artwork == nil)
        artwork = [UIImage imageNamed: @"img_no_cover"];
    cell.imageView.image = artwork;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSInteger songRow = indexPath.row;
    [self playList:songRow :self.detailCollection];
    MenuModel *itemcell = lists[0];
    [self performSegueWithIdentifier:@"detailPlay" sender:itemcell];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"detailPlay"])
    {
        PlayerController *items = segue.destinationViewController;
        items.songDetail = sender;
    }
}

@end
