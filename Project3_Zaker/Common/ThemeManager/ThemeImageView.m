//
//  ThemeImageView.m
//  Project2 weibo
//
//  Created by 黄珂耀 on 15/8/21.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "ThemeImageView.h"
#import "ThemeManager.h"

@implementation ThemeImageView

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

- (void)setImageName:(NSString *)imageName
{
    if (![_imageName isEqualToString:imageName])
    {
        _imageName = [imageName copy];
        [self loadImage];
    }
}

- (void)loadImage
{
    ThemeManager *themeManager = [ThemeManager shareInstance];
    
    UIImage *image = [themeManager getThemeImageWithImageName:_imageName];
    
    image = [image stretchableImageWithLeftCapWidth:self.leftCapWidth topCapHeight:self.topCapWidth];
    
    self.image = image;
}


@end
