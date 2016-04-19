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
    [self loadCollections];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return [_songItems count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 55.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songList"];
    
    MPMediaItemCollection *collection = [_songItems objectAtIndex:indexPath.row];
    MPMediaItem *item = collection.representativeItem;
    NSString *property = [MPMediaItem titlePropertyForGroupingType:_songQuery.groupingType];
    cell.textLabel.text = [item valueForProperty:property];
    
    switch (_listType)
    {
        case song_list:
            break;
        case album_list:
            cell.detailTextLabel.text = [item valueForProperty: MPMediaItemPropertyArtist];
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
    UIImage *artwork = nil;
    if ([item valueForProperty:MPMediaItemPropertyArtwork])
        artwork = [[item valueForProperty:MPMediaItemPropertyArtwork] imageWithSize:CGSizeMake(60, 60)];
    if (artwork == nil)
        artwork = [UIImage imageNamed: @"img_no_cover"];
    cell.imageView.image = artwork;
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}


@end
