//
//  DataService.h
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/27.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DataService : NSObject

typedef void (^BlockType) (id result);

+ (void)BaseUrl:(NSString *)baseUrl
     requestUrl:(NSString *)urlString //url
    httpMethod:(NSString *)method //GET  POST
        params:(NSMutableDictionary *)params //参数
         block:(BlockType)block; //接收到的数据的处理


@end
