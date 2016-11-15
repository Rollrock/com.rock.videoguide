//
//  Model.h
//  com.rock.VideoGuide
//
//  Created by zhuang chaoxiao on 16/11/15.
//  Copyright © 2016年 zhuang chaoxiao. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Model : NSObject

@end

@interface AdvertModel : NSObject

@property(copy,nonatomic)NSString * imgUrl;
@property(copy,nonatomic)NSString * title;
@property(copy,nonatomic)NSString * desc;
@property(copy,nonatomic)NSString * url;
+(id)modelFromDict:(NSDictionary*)dict;
@end
