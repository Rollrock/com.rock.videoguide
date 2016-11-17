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
#import "SVProgressHUD.h"
#import "Model.h"

@import GoogleMobileAds;

@interface FirstViewController ()<GADInterstitialDelegate,AVPlayerViewControllerDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIView *bannerBgView;

@property(strong,nonatomic) AVPlayer * palyer;
@property(strong,nonatomic) AVPlayerViewController * palyerVC;
@property(strong,nonatomic) NSMutableArray * array;

@property(strong,nonatomic) GADBannerView * banner;
@property(nonatomic, strong) GADInterstitial *interstitial;
@property(strong,nonatomic) NSTimer * timer;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.tableView.rowHeight = 70;
    [self.tableView setTableFooterView:[UIView new]];
    
    [self getVideoReq];
    
    [self loadBanner];
    [self createAndLoadInterstitial];
    [self timer];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    [self.palyerVC.player pause];
}

#pragma GoogleAdv
- (void)interstitialDidDismissScreen:(GADInterstitial *)ad
{
    self.interstitial = nil;
    [self createAndLoadInterstitial];
}

-(NSTimer*)timer
{
    if( !_timer )
    {
        _timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(showInterstitial) userInfo:nil repeats:YES];
    }
    
    return _timer;
}

-(void)showInterstitial
{
    if (self.interstitial.isReady)
    {
        [self.interstitial presentFromRootViewController:self];
        self.interstitial.delegate = self;
        
        [self.timer invalidate];
        self.timer = nil;
    }
    else
    {
        
    }
}
- (void)createAndLoadInterstitial {
    
    self.interstitial = [[GADInterstitial alloc] initWithAdUnitID:@"ca-app-pub-3058205099381432/9391787145"];
    
    GADRequest *request = [GADRequest request];

    request.testDevices = @[ kGADSimulatorID, @"2440bd529647afc62d632f9d424f0679" ];
    [self.interstitial loadRequest:request];
    
}
-(void)loadBanner
{
    // Replace this ad unit ID with your own ad unit ID.
    GADAdSize size = GADAdSizeFromCGSize(CGSizeMake([UIScreen mainScreen].bounds.size.width,50));
    self.banner = [[GADBannerView alloc]initWithAdSize: size];
    self.banner.adUnitID = @"ca-app-pub-3058205099381432/5519990745";
    self.banner.rootViewController = self;
    
    [self.bannerBgView addSubview:self.banner];
    
    GADRequest *request = [GADRequest request];
    request.testDevices = @[ @"2440bd529647afc62d632f9d424f0679"];
    [self.banner loadRequest:request];


}
#pragma Net
-(void)getVideoReq
{
    [SVProgressHUD showWithStatus:@"Loading..."];
    
    NSString *urlstring = [NSString stringWithFormat:@"%@",@"http://www.hushup.com.cn/rockweb/videoguide/newest.php"];
    [NetWorkUikits requestWithUrl:urlstring param:nil completionHandle:^(id data) {
        NSLog(@"%@", data);
        
        [SVProgressHUD dismiss];
        
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
        
        [SVProgressHUD showWithStatus:error.description];
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
    if( [AdvertModel mustScore] )
    {
        UIAlertController * alert = [UIAlertController alertControllerWithTitle:@"提示" message:@"5星好评之后才能观看哦~" preferredStyle:UIAlertControllerStyleAlert];
        
        UIAlertAction * ok = [UIAlertAction actionWithTitle:@"好评" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            //[[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://itunes.apple.com/us/app/ping-guo-shou-ji-zhu-shou/id847434490?l=zh&ls=1&mt=8"] options:@{} completionHandler:nil];
        }];
        
        UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"不了" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            
            [self showInterstitial];
            
        }];
        
        [alert addAction:ok];
        [alert addAction:cancel];
        
        [self presentViewController:alert animated:YES completion:nil];
        
        return;
    }
    
    self.palyerVC = nil;
    self.palyer = nil;
    
    VideoModel * m = self.array[indexPath.row];
    
    self.palyer = [AVPlayer playerWithURL:[NSURL URLWithString:[@"http://www.hushup.com.cn/rockweb" stringByAppendingString:m.videoUrl]]];
    self.palyerVC = [[AVPlayerViewController alloc] init];
    self.palyerVC.player = self.palyer;
    self.palyerVC.delegate = self;
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
