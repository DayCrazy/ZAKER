//
//  TabBarButton.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/24.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "TabBarButton.h"
#import "ThemeManager.h"

@implementation TabBarButton


- (id)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName andTitle:(NSString *)title andColorName:(NSString *)colorName
{
    self = [super initWithFrame:frame];
    if (self)
    {
        
        _imageView = [[ThemeImageView alloc] initWithFrame:CGRectZero];
        [_imageView setImageName:imageName];
        
        [self addSubview:_imageView];
        
        _label = [[ThemeLabel alloc] initWithFrame:CGRectZero];
        _label.text = title;
        _label.textAlignment = NSTextAlignmentCenter;
        _label.font = [UIFont systemFontOfSize:11];
        _label.textColor = [[ThemeManager shareInstance] getThemeColorWithColorName:colorName];
        
        [self addSubview:_label];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    _imageView.frame = CGRectMake((KWidth / 4 - 25) / 2, 5, 25, 25);
    _label.frame = CGRectMake(0, CGRectGetMaxY(_imageView.frame), KWidth / 4, 20);
}



@end
