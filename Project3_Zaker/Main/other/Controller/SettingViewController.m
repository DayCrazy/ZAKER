//
//  SettingViewController.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/27.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "SettingViewController.h"
#import "ThemeManager.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.title = @"更多设置";
    
    UIButton *red = [[UIButton alloc] initWithFrame:CGRectMake(100, 200, 135, 30)];
    red.backgroundColor = [UIColor redColor];
    red.tag = 100;
    [red addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *blue = [[UIButton alloc] initWithFrame:CGRectMake(100, 250, 135, 30)];
    blue.backgroundColor = [UIColor colorWithRed:0.263 green:1.000 blue:0.925 alpha:1.000];
    blue.tag = 101;
    [blue addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *pink = [[UIButton alloc] initWithFrame:CGRectMake(100, 300, 135, 30)];
    pink.backgroundColor = [UIColor colorWithRed:0.766 green:0.449 blue:0.672 alpha:1.000];
    pink.tag = 102;
    [pink addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:red];
    [self.view addSubview:blue];
    [self.view addSubview:pink];
}

- (void)buttonAction:(UIButton *)sender
{
    if (sender.tag == 100)
    {
        [[ThemeManager shareInstance] setThemeName:@"red"];
    }
    else if (sender.tag == 101)
    {
        [[ThemeManager shareInstance] setThemeName:@"blue"];
    }
    else if (sender.tag == 102)
    {
        [[ThemeManager shareInstance] setThemeName:@"pink"];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
