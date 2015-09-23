//
//  IssueModel.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/31.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "IssueModel.h"

@implementation IssueModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    if ([key isEqualToString:@"thumbnail_medias"])
    {
        _images = value;
    }
    else if ([key isEqualToString:@"thumbnail_pic"])
    {
        _imageUrl = [value copy];
    }
}

@end
