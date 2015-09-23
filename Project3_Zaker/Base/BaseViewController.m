//
//  BaseViewController.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/24.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "BaseViewController.h"
#import "MyAccountTableViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)_createLeftBarButton
{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 24, 24)];
    
    [leftButton setImage:[UIImage imageNamed:@"my_account"] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)leftButtonAction:(UIButton *)sender
{
    NSLog(@"个人中心");
    
    MyAccountTableViewController *vc = [[MyAccountTableViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self _createLeftBarButton];
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
