//
//  MyModel.m
//  com.rock.VideoGuide
//
//  Created by zhuang chaoxiao on 16/11/15.
//  Copyright © 2016年 zhuang chaoxiao. All rights reserved.
//

#import "MyModel.h"

@implementation MyModel

@end


@implementation VideoModel

+(id)modelFromDict:(NSDictionary*)dict
{
    VideoModel * m = [VideoModel new];
    
    m.imageUrl = dict[@"imageUrl"];
    m.name = dict[@"name"];
    m.uploadTime = dict[@"uploadTime"];
    m.hot = dict[@"hot"];
    m.down = dict[@"down"];
    m.time = dict[@"time"];
    
    return m;
}

@end
