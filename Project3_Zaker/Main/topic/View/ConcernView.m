//
//  ConcernView.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/12.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "ConcernView.h"
#import "LoginViewController.h"

@implementation ConcernView

- (IBAction)loginAction:(id)sender {
    
    LoginViewController *vc = [[LoginViewController alloc] init];
    
    [self.viewController presentViewController:vc animated:YES completion:nil];
    
}

@end
