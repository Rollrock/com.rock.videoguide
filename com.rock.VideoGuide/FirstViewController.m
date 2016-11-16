//
//  FirstViewController.m
//  com.rock.VideoGuide
//
//  Created by zhuang chaoxiao on 16/11/14.
//  Copyright © 2016年 zhuang chaoxiao. All rights reserved.
//

#import "FirstViewController.h"
#import "MyModel.h"
#import "FirstTableViewCell.h"
#import "NetWorkUikits.h"
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(strong,nonatomic) AVPlayer * palyer;
@property(strong,nonatomic) AVPlayerViewController * palyerVC;
@property(strong,nonatomic) NSMutableArray * array;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.rowHeight = 80;
    
    [self getVideoReq];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Net
-(void)getVideoReq
{
    NSString *urlstring = [NSString stringWithFormat:@"%@",@"http://www.hushup.com.cn/rockweb/videoguide/videoguideindex.php"];
    [NetWorkUikits requestWithUrl:urlstring param:nil completionHandle:^(id data) {
        NSLog(@"%@", data);
        
        if( [data[@"success"] boolValue] != 1 ) return;
        
        [self.array removeAllObjects];
        for( NSDictionary * dict in data[@"data"])
        {
            VideoModel * m = [VideoModel modelFromDict:dict];
            m.imageUrl = [@"http://www.hushup.com.cn/rockweb" stringByAppendingString:m.imageUrl];
            [self.array addObject:m];
        }
        
        [self.tableView reloadData];
        //
        
    } failureHandle:^(NSError *error) {
        
        
    }];
}


#pragma UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.array.count;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"FirstTableViewCell";
    
    FirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell )
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil] lastObject];
    }
    
    [cell refresCell:self.array[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.palyerVC = nil;
    self.palyer = nil;
    
    VideoModel * m = self.array[indexPath.row];
    
    self.palyer = [AVPlayer playerWithURL:[NSURL URLWithString:[@"http://www.hushup.com.cn/rockweb" stringByAppendingString:m.videoUrl]]];
    self.palyerVC = [[AVPlayerViewController alloc] init];
    self.palyerVC.player = self.palyer;
    self.palyerVC.videoGravity = AVLayerVideoGravityResizeAspect;
    self.palyerVC.allowsPictureInPicturePlayback = true;    //画中画，iPad可用
    self.palyerVC.showsPlaybackControls = true;
    
    [self.palyerVC.player play];
    
    [self.navigationController pushViewController:self.palyerVC animated:YES];
}


#pragma setter & getter
-(NSMutableArray*)array
{
    if( !_array )
    {
        _array = [NSMutableArray new];
    }
    
    return _array;
}



@end
