//
//  ThemeManager.h
//  Project2 weibo
//
//  Created by 黄珂耀 on 15/8/21.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import <Foundation/Foundation.h>

#define kThemeDidChangeNotification @"kThemeDidChangeNotification"

#define kThemeName @"kThemeName"

@interface ThemeManager : NSObject

@property (nonatomic,copy) NSString *themeName;

@property (nonatomic,strong) NSDictionary *themeConfig;

@property (nonatomic,strong) NSDictionary *themeColorConfig;

+ (ThemeManager *)shareInstance;

- (UIImage *)getThemeImageWithImageName:(NSString *)imageName;

- (UIColor *)getThemeColorWithColorName:(NSString *)colorName;

@end
