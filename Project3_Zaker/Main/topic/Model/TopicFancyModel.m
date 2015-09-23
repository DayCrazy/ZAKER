//
//  TopicFancyModel.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/12.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "TopicFancyModel.h"

@implementation TopicFancyModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"auther"])
    {
        _name = [value objectForKey:@"name"];
        _icon = [value objectForKey:@"icon"];
    }
    else if ([key isEqualToString:@"thumbnail_medias"])
    {
        _images = value;
    }
    else if ([key isEqualToString:@"special_info"])
    {
        _discussion_title = [value objectForKey:@"discussion_title"];
    }
}

@end
