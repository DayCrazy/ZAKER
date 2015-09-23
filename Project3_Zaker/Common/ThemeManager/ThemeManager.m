//
//  ThemeManager.m
//  Project2 weibo
//
//  Created by 黄珂耀 on 15/8/21.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "ThemeManager.h"

#define kDefaultThemeName @"red"

@implementation ThemeManager

+ (ThemeManager *)shareInstance
{
    static ThemeManager *instance = nil;
    static dispatch_once_t token;
    dispatch_once(&token, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _themeName = kDefaultThemeName;
        
        NSString *savedThemeName = [[NSUserDefaults standardUserDefaults] objectForKey:kThemeName];
        
        if (savedThemeName.length > 0)
        {
            _themeName = [savedThemeName copy];
        }
        
        NSString *configPath = [[NSBundle mainBundle] pathForResource:@"theme" ofType:@"plist"];
        self.themeConfig = [NSDictionary dictionaryWithContentsOfFile:configPath];
        
        self.themeColorConfig = [NSDictionary dictionaryWithContentsOfFile:[self getColorPath]];
    }
    return self;
}

- (NSString *)getThemePath
{
    NSString *bundlePath = [[NSBundle mainBundle] resourcePath];
    
    NSString *shortPath = [self.themeConfig objectForKey:self.themeName];
    
    NSString *themePath = [bundlePath stringByAppendingPathComponent:shortPath];
    
    return themePath;
}

- (NSString *)getColorPath
{
    NSString *colorPath = [[NSBundle mainBundle] pathForResource:@"themeColor" ofType:@"plist"];
    
    return colorPath;
}

- (void)setThemeName:(NSString *)themeName
{
    if (![_themeName isEqualToString:themeName])
    {
        _themeName = [themeName copy];
        
        [[NSUserDefaults standardUserDefaults] setObject:_themeName forKey:kThemeName];
        
        [[NSUserDefaults standardUserDefaults] synchronize];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kThemeDidChangeNotification object:nil];
    }
}

- (UIImage *)getThemeImageWithImageName:(NSString *)imageName
{
    if (imageName.length == 0)
    {
        return nil;
    }
    NSString *themePath = [self getThemePath];
    
    NSString *filePath = [themePath stringByAppendingPathComponent:imageName];
    
    UIImage *image = [UIImage imageWithContentsOfFile:filePath];

    return image;
}

- (UIColor *)getThemeColorWithColorName:(NSString *)colorName
{
    if (colorName.length == 0)
    {
        return nil;
    }
    
    NSDictionary *RGBDic = [_themeColorConfig objectForKey:colorName];
    
    CGFloat R = [RGBDic[@"R"] floatValue] / 255.0;
    CGFloat G = [RGBDic[@"G"] floatValue] / 255.0;
    CGFloat B = [RGBDic[@"B"] floatValue] / 255.0;

    CGFloat alpha = [RGBDic[@"alpha"] floatValue];
    
    if (RGBDic[@"alpha"] == nil)
    {
        alpha = 1;
    }
    
    UIColor *themeColor = [UIColor colorWithRed:R green:G blue:B alpha:alpha];
    
    return themeColor;
    
}

@end
