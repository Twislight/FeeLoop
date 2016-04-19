//
//  MenuView.m
//  FeeLoop
//
//  Created by 郑翔匀 on 16/4/19.
//  Copyright © 2016年 twsit. All rights reserved.
//

#import "MenuView.h"
#import "SongModel.h"
#import "SongView.h"
#import "MenuModel.h"

@interface MenuView ()

@end

@implementation MenuView

{
    NSMutableArray *lists;//可变数组
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    lists = [[NSMutableArray alloc]initWithCapacity:10];
    
    MenuModel *list;//创建MenuModel类型的list对象
    
    list = [MenuModel new];
    list.titleitem = @"歌曲";
    [lists addObject:list];
    
    list = [MenuModel new];
    list.titleitem = @"专辑";
    [lists addObject:list];
    
    list = [MenuModel new];
    list.titleitem = @"表演者";
    [lists addObject:list];
    
    list = [MenuModel new];
    list.titleitem = @"选集";
    [lists addObject:list];
    
    list = [MenuModel new];
    list.titleitem = @"作曲";
    [lists addObject:list];
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

//返回行数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return list_num;//一共有5行
}

//重用cell并返回cell的内容
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"menuSongList"];//重用cell
    
    MenuModel *cellitem = [[MenuModel alloc]init];//创建MenuModel类型的item对象
    //通过item对象调用MenuModel中的方法
    NSString *title = [cellitem titleForRow: (int)indexPath.row];
    NSString *imageName = [cellitem imageNameForRow:(int)indexPath.row];
    //设置cell的title和图片
    cell.textLabel.text = title;
    cell.imageView.image = [UIImage imageNamed:imageName];
    
    return cell;
}

//按下其中一行
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MenuModel *itemcell = lists[indexPath.row];
    [self performSegueWithIdentifier:@"showSong" sender:itemcell];//使用segue进行跳转下一场景
}

//进入下一个场景
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if([segue.identifier isEqualToString:@"showSong"])
    {
        SongView *items = segue.destinationViewController;
        items.song = sender;
    }
}




@end
