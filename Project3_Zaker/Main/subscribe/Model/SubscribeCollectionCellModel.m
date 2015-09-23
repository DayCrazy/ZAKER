//
//  SubscribeCollectionCellModel.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/13.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "SubscribeCollectionCellModel.h"

@implementation SubscribeCollectionCellModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"block_info"])
    {
        _pic = [value objectForKey:@"pic"];
        
        _block_title = [value objectForKey:@"block_title"];
    }
    else if ([key isEqualToString:@"articles"])
    {
        _articles = value;
    }
}

@end
