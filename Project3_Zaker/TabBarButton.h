//
//  TabBarButton.h
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/24.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ThemeImageView.h"
#import "ThemeLabel.h"

@interface TabBarButton : UIControl

@property (nonatomic,strong) ThemeImageView *imageView;

@property (nonatomic,strong) ThemeLabel *label;

- (id)initWithFrame:(CGRect)frame andImageName:(NSString *)imageName andTitle:(NSString *)title andColorName:(NSString *)colorName;

@end
