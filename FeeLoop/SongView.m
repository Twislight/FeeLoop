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
#import "DetailView.h"

@interface SongView ()

{
    NSMutableArray *lists;//可变数组
}

@end

@implementation SongView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = self.song.titleitem;//获取标题
    _listType = self.song.listType;//获取音乐类型
    [self loadCollections];//加载音乐队列
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//保存音乐信息
-(void) songDetailList :(NSString*)titleItems :(MPMediaItemCollection*)collection
{
    lists = [[NSMutableArray alloc]initWithCapacity:1];
    MenuModel *list;
//    NSLog(@"%@",titleItems);
    list = [MenuModel new];
    list.titleitem = titleItems;
    list.itemCollection = collection;
    [lists addObject:list];
}

//读取音乐队列
-(void)loadCollections
{
    switch (_listType)
    {
        case song_list:
            self.songQuery = [MPMediaQuery songsQuery];
            break;
        case album_list:
            self.songQuery = [MPMediaQuery albumsQuery];
            break;
        case artist_list:
            self.songQuery = [MPMediaQuery artistsQuery];
            break;
        case composer_list:
            self.songQuery = [MPMediaQuery composersQuery];
            break;
        case compilation_list:
            self.songQuery = [MPMediaQuery compilationsQuery];
            break;
        default:
            break;
    }
    _songItems  = [self.songQuery collections];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_songItems count];//返回行数
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;//设定行高度
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songList"];
    cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"songList"];//设定cell风格
    MPMediaItemCollection *collection = [_songItems objectAtIndex:indexPath.row];
    MPMediaItem *item = collection.representativeItem;
    NSString *property = [MPMediaItem titlePropertyForGroupingType:_songQuery.groupingType];
    cell.textLabel.text = [item valueForProperty:property];
    
    switch (_listType)
    {
        case song_list:
            cell.detailTextLabel.text = [item valueForProperty: MPMediaItemPropertyArtist];//如果是歌曲，则显示副标题为表演者
            break;
        case album_list:
            cell.detailTextLabel.text = [item valueForProperty: MPMediaItemPropertyArtist];//如果是专辑，则显示副标题为表演者
            break;
        case artist_list:
            break;
        case compilation_list:
            break;
        case composer_list:
            break;
        default:
            break;
    }
    
    // Album Cover Art
    UIImage *artwork = nil;//创建图片对象
    //如果歌曲包含专辑封面，则显示歌曲中的专辑封面
    if ([item valueForProperty:MPMediaItemPropertyArtwork])
        artwork = [[item valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(60, 60)];
    //如果歌曲未包含封面，则显示预设的图片
    if (artwork == nil)
        artwork = [UIImage imageNamed: @"img_no_cover"];
    cell.imageView.image = artwork;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_listType == song_list)//如果是歌曲列表则直接播放
    {
        [self performSegueWithIdentifier:@"songPlay" sender:nil];
    }
    else//如果是专辑等其他列表则进入下一列表
    {
        MPMediaItemCollection *collection   = [_songItems objectAtIndex:indexPath.row];
        MPMediaItem *item                   = collection.representativeItem;
        NSString *property                  = [MPMediaItem titlePropertyForGroupingType: _songQuery.groupingType ];
        NSString *title                     = [item valueForProperty: property];
        [self songDetailList:title :collection];
//        NSLog(@"%d",indexPath.row);
        MenuModel *itemcell = lists[0];
        [self performSegueWithIdentifier:@"showDetail" sender:itemcell];
    }
    
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"showDetail"])
    {
        DetailView *items = segue.destinationViewController;
        items.detail = sender;
    }
}


@end
