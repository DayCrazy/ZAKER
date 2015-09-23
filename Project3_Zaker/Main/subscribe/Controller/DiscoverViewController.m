//
//  DiscoverViewController.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/25.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "DiscoverViewController.h"

@interface DiscoverViewController ()

@end

@implementation DiscoverViewController

- (void)_createRightBarButton
{
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    [rightButton setImage:[UIImage imageNamed:@"discover_fangdajing"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)rightButtonAction:(UIButton *)sender
{
    NSLog(@"订阅");
    
    DiscoverViewController *vc = [[DiscoverViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"发现";
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
