//
//  BaseNavigationController.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/24.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "BaseNavigationController.h"
#import "ThemeManager.h"

@interface BaseNavigationController ()

@end

@implementation BaseNavigationController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(loadImage) name:kThemeDidChangeNotification object:nil];
    }
    return  self;
}

- (void)loadImage
{
    ThemeManager *manager = [ThemeManager shareInstance];

    UIColor *titleColor = [UIColor whiteColor];
    
    NSDictionary *attributes = @{
                                 NSForegroundColorAttributeName:titleColor
                                 };
    
    [self.navigationBar setTitleTextAttributes:attributes];
    
    self.navigationBar.barTintColor = [manager getThemeColorWithColorName:[[NSUserDefaults standardUserDefaults] objectForKey:kThemeName]];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}


- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.navigationBar.translucent = NO;
    
    self.navigationBar.tintColor = [UIColor whiteColor];
    
//    消除navigationBar 下方边线
    [[UINavigationBar appearance] setBackgroundImage:[[UIImage alloc] init] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
    [[UINavigationBar appearance] setShadowImage:[[UIImage alloc] init]];
    
    [self loadImage];
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
