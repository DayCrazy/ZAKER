//
//  MainTabBarController.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/24.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "MainTabBarController.h"
#import "BaseNavigationController.h"
#import "TabBarButton.h"
#import "ThemeImageView.h"
#import "ThemeManager.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController
{
    NSMutableArray *_viewControllers;
    
    UIImageView *_tabBarView;

}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange:) name:kThemeDidChangeNotification object:nil];
    
    self.selectedIndex = 0;
    
    self.tabBar.translucent = NO;

    [self _createViewControllers];
    
    [self _createTabBarView];
}

- (void)themeChange:(NSNotification *)notification
{
    [self _createTabBarView];
}

- (void)_createViewControllers
{
    NSArray *storyBoardNames = @[
                                 @"Subscribe",
                                 @"Issue",
                                 @"HaveFun",
                                 @"Topic"
                                 ];
    
    _viewControllers = [[NSMutableArray alloc] initWithCapacity:4];
    
    for (NSString *name in storyBoardNames)
    {
        UIStoryboard *storyBoard = [UIStoryboard storyboardWithName:name bundle:nil];
        
        BaseNavigationController *nav = [storyBoard instantiateInitialViewController];
        
        [_viewControllers addObject:nav];
    }
    
    self.viewControllers = _viewControllers;
}

- (void)_createTabBarView
{
    for (UIView *view in self.tabBar.subviews)
    {
        Class clas = NSClassFromString(@"UITabBarButton");
        if ([view isKindOfClass:clas])
        {
            [view removeFromSuperview];
        }
    }
    
    _tabBarView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 49)];
    
    _tabBarView.backgroundColor = [UIColor colorWithWhite:0.961 alpha:1.000];
    
    [self.tabBar addSubview:_tabBarView];

    NSArray *tabBarButtonNormalNames = @[
                                         @"subscribeNormal",
                                         @"issueNormal",
                                         @"haveFunNormal",
                                         @"topicNormal"
                                         ];
    
    NSArray *tabBarButtonHighLightedNames = @[
                                         @"subscribeHighLighted",
                                         @"issueHighLighted",
                                         @"haveFunHighLighted",
                                         @"topicHighLighted"
                                         ];


    NSArray *tabBarNames = @[
                             @"订阅",
                             @"热点",
                             @"玩乐",
                             @"话题"
                             ];
    
    CGFloat itemWidth = KWidth / 4.0;
    
    for (int i = 0; i < [tabBarButtonNormalNames count]; i++)
    {
        CGRect frame = CGRectMake(i * itemWidth, 0, itemWidth, 49);
        
        TabBarButton *button = [[TabBarButton alloc] initWithFrame:frame andImageName:tabBarButtonHighLightedNames[i] andTitle:tabBarNames[i] andColorName:[[NSUserDefaults standardUserDefaults] objectForKey:kThemeName]];
        
        button.tag = i;
        
        [button addTarget:self action:@selector(selectTabBar:) forControlEvents:UIControlEventTouchUpInside];
        
        [self.tabBar addSubview:button];
        
    }
    
}

- (void)selectTabBar:(TabBarButton *)sender
{
    self.selectedIndex = sender.tag;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
