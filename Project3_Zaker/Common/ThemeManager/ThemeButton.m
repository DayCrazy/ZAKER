//
//  ThemeButton.m
//  Project2 weibo
//
//  Created by 黄珂耀 on 15/8/21.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "ThemeButton.h"
#import "ThemeManager.h"

@implementation ThemeButton

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeDidChangeAction:) name:kThemeDidChangeNotification object:nil];
    }
    return  self;
}

- (void)themeDidChangeAction:(NSNotification *)notification
{
    [self loadImage];
}

- (void)setNormalImageName:(NSString *)normalImageName
{
    if (![_normalImageName isEqualToString:normalImageName])
    {
        _normalImageName = [normalImageName copy];
        [self loadImage];
    }
}

- (void)setHighLightedImageName:(NSString *)highLightedImageName
{
    if (![_highLightedImageName isEqualToString:highLightedImageName]) {
        _highLightedImageName = [highLightedImageName copy];
        [self loadImage];
    }
}

- (void)setNormalBgImageName:(NSString *)normalBgImageName
{
    if (![_normalBgImageName isEqualToString:normalBgImageName]) {
        _normalBgImageName = [normalBgImageName copy];
        [self loadImage];
    }
}

- (void)setHighLightedBgImageName:(NSString *)highLightedBgImageName
{
    if (![_highLightedBgImageName isEqualToString:highLightedBgImageName]) {
        _highLightedBgImageName = [highLightedBgImageName copy];
        [self loadImage];
    }
}

- (void)loadImage
{
    ThemeManager *themeManager = [ThemeManager shareInstance];
    
    UIImage *normalImage = [themeManager getThemeImageWithImageName:_normalImageName];
    
    UIImage *highLightedImage = [themeManager getThemeImageWithImageName:_highLightedImageName];
    
    UIImage *normalBgImage = [themeManager getThemeImageWithImageName:_normalBgImageName];
    
    UIImage *hightLightedBgImage = [themeManager getThemeImageWithImageName:_highLightedBgImageName];
    
    if (_normalImageName != nil)
    {
        [self setImage:normalImage forState:UIControlStateNormal];
    }
    if (_highLightedImageName != nil)
    {
        [self setImage:highLightedImage forState:UIControlStateHighlighted];
    }
    if (_normalBgImageName != nil)
    {
        [self setBackgroundImage:normalBgImage forState:UIControlStateNormal];
    }
    if (_highLightedBgImageName != nil)
    {
        [self setBackgroundImage:hightLightedBgImage forState:UIControlStateHighlighted];
    }
    
}

@end
