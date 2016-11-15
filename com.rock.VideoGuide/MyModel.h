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

@property(strong,nonatomic) NSString * imageUrl;
@property(strong,nonatomic) NSString * name;
@property(strong,nonatomic) NSString * uploadTime;
@property(strong,nonatomic) NSString * hot;
@property(strong,nonatomic) NSString * down;
@property(strong,nonatomic) NSString * time;
+(id)modelFromDict:(NSDictionary*)dict;

@end
