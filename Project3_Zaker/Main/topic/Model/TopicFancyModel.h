//
//  TopicFancyModel.h
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/12.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TopicFancyModel : NSObject

@property (nonatomic,copy) NSString *content;

@property (nonatomic,copy) NSString *name;

@property (nonatomic,copy) NSString *date;

@property (nonatomic,copy) NSString *icon;

@property (nonatomic,copy) NSString *discussion_title;

@property (nonatomic,strong) NSArray *images;

@property (nonatomic,copy) NSString *weburl;

@property (nonatomic,assign) NSInteger comment_count;

@property (nonatomic,assign) NSInteger hot_num;

@property (nonatomic,assign) NSInteger like_num;

@end
