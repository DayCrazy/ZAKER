//
//  BaseSubviewController.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/25.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "BaseSubviewController.h"

@interface BaseSubviewController ()

@end

@implementation BaseSubviewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.hidesBottomBarWhenPushed = YES;
    }
    return self;
}

- (void)_createLeftBarButton
{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    [leftButton setImage:[UIImage imageNamed:@"back_jiantou"] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)leftButtonAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)_createSubview
{
    
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createLeftBarButton];
    
    [self _createSubview];
    
    self.view.backgroundColor = [UIColor whiteColor];
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
