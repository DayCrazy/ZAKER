//
//  DataService.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/27.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "DataService.h"
#import "AFNetworking.h"

@implementation DataService

+ (void)BaseUrl:(NSString *)baseUrl requestUrl:(NSString *)urlString httpMethod:(NSString *)method params:(NSMutableDictionary *)params block:(BlockType)block
{
    
    NSString *fullStr = baseUrl;
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer = [AFJSONResponseSerializer serializer];
    
    if ([method isEqualToString:@"GET"])
    {
        [manager GET:fullStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"get succeed");
            block(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"get error");
        }];
        
    }
    else if ([method isEqualToString:@"POST"])
    {
        [manager POST:fullStr parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
            NSLog(@"post succeed");
            block(responseObject);
        } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
            NSLog(@"post error");
        }];
    }
}

@end
