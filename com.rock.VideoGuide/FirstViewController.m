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

@interface FirstViewController ()<UITableViewDelegate,UITableViewDataSource>

@end

@implementation FirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma Net
-(void)getAdvertReq
{
    /*
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
     */
}


#pragma UITableView
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 0;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * cellID = @"FirstTableViewCell";
    
    FirstTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    
    if(!cell )
    {
        cell = [[[NSBundle mainBundle]loadNibNamed:cellID owner:self options:nil] lastObject];
    }
    
    //[cell refresCell:self.array[indexPath.row]];
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}



@end
