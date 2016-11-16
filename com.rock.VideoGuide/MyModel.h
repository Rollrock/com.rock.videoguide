//
//  MyModel.h
//  com.rock.VideoGuide
//
//  Created by zhuang chaoxiao on 16/11/15.
//  Copyright © 2016年 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyModel : NSObject

@end


@interface VideoModel : NSObject

@property(copy,nonatomic) NSString * imageUrl;
@property(copy,nonatomic) NSString * name;
@property(copy,nonatomic) NSString * uploadTime;
@property(copy,nonatomic) NSString * hot;
@property(copy,nonatomic) NSString * down;
@property(copy,nonatomic) NSString * time;
@property(copy,nonatomic) NSString * downUrl;
@property(copy,nonatomic) NSString * videoUrl;

+(id)modelFromDict:(NSDictionary*)dict;

@end
