//
//  IssueModel.h
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/31.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface IssueModel : NSObject

@property (nonatomic,copy) NSString *title;
@property (nonatomic,copy) NSString *auther_name;
@property (nonatomic,copy) NSString *date;

@property (nonatomic,strong) NSArray *images;

@property (nonatomic,copy) NSString *weburl;

@property (nonatomic,copy) NSString *imageUrl;

@end
