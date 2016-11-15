//
//  Model.m
//  com.rock.VideoGuide
//
//  Created by zhuang chaoxiao on 16/11/15.
//  Copyright © 2016年 zhuang chaoxiao. All rights reserved.
//

#import "Model.h"

@implementation Model

@end


@implementation AdvertModel

+(id)modelFromDict:(NSDictionary*)dict
{
    AdvertModel * m = [AdvertModel new];
    
    m.imgUrl = dict[@"imgUrl"];
    m.title = dict[@"title"];
    m.desc = dict[@"descp"];
    m.url = dict[@"url"];
    
    return m;
}

@end
