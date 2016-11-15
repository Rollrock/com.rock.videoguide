//
//  AdvertViewController.m
//  test
//
//  Created by 停有钱 on 16/11/15.
//  Copyright © 2016年 rock. All rights reserved.
//

/*
 设计方案：
 1.设置openAdv标志，打开之后才会显示里面的内容
 2.传APPID到后台，后台根据APPID来判断是否打开
 3.
 */

#import "AdvertViewController.h"
#import "AdvertTableViewCell.h"
#import "NetWorkUikits.h"
#import "Model.h"

/////////////////////////////////////////////////////////////////////////////////

@interface AdvertViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong,nonatomic) NSMutableArray * array;

@end

@implementation AdvertViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.tableView.rowHeight = 60;
    [self.tableView setTableFooterView:[UIView new]];
    
    [self getAdvertReq];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Net
-(void)getAdvertReq
{
    NSString *urlstring = [NSString stringWithFormat:@"%@",@"http://www.hushup.com.cn/rockweb/index.php?appid=ALL"];
    [NetWorkUikits requestWithUrl:urlstring param:nil completionHandle:^(id data) {
        NSLog(@"%@", data);
        
        if( [data[@"success"] boolValue] != 1 ) return;
        
        [self.array removeAllObjects];
        for( NSDictionary * dict in data[@"data"])
        {
            AdvertModel * m = [AdvertModel modelFromDict:dict];
            m.imgUrl = [@"http://www.hushup.com.cn/rockweb" stringByAppendingString:m.imgUrl];
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
    static NSString * cellID = @"AdvertTableViewCell";
    
    AdvertTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell )
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil] lastObject];
    }
    
    [cell refresCell:self.array[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:((AdvertModel*)self.array[indexPath.row]).url] options:@{} completionHandler:^(BOOL success) {
        
        
    }];
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
