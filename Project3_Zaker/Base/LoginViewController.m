//
//  LoginViewController.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/12.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController
{
    UIScrollView *_loginScrollView;
    
    UIPageControl *_pageControl;
}

- (IBAction)closeAction:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)loginForSinaAction:(id)sender {
}
- (IBAction)loginForTencentAction:(id)sender {
}
- (IBAction)loginForZakerAction:(id)sender {
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self _createSubviews];
}

- (void)_createSubviews
{
    _loginScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 20, KWidth, 400)];
    
    _loginScrollView.contentSize = CGSizeMake(KWidth * 3, 400);
    
    NSArray *imageNames = @[
                            @"FeaturesGallery-1@3x",
                            @"FeaturesGallery-2@3x",
                            @"FeaturesGallery-3@3x"
                            ];
    
    for (int i = 0; i < [imageNames count]; i++)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * KWidth, 0, KWidth, 400)];
        [imageView setImage:[UIImage imageNamed:imageNames[i]]];
        
        imageView.contentMode = UIViewContentModeScaleAspectFit;
        
        [_loginScrollView addSubview:imageView];
    }
    _loginScrollView.pagingEnabled = YES;
    
    _loginScrollView.showsHorizontalScrollIndicator = NO;
    
    _loginScrollView.delegate = self;
    
    [self.view addSubview:_loginScrollView];
    
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake((KWidth - 60) / 2, 420, 60, 40)];
    
    _pageControl.pageIndicatorTintColor = [UIColor colorWithWhite:0.879 alpha:1.000];
    
    _pageControl.currentPageIndicatorTintColor = [UIColor grayColor];
    
    _pageControl.numberOfPages = 3;
    
    _pageControl.userInteractionEnabled = NO;
    
    [_pageControl addTarget:self action:@selector(pageControlAction) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_pageControl];
    
}

- (void)pageControlAction
{
    _loginScrollView.contentOffset = CGPointMake(_pageControl.currentPage * KWidth, 0);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    _pageControl.currentPage = _loginScrollView.contentOffset.x / KWidth;
}

- (BOOL)prefersStatusBarHidden
{
//     [[UIApplication sharedApplication] setStatusBarHidden:YES withAnimation:UIStatusBarAnimationFade];
    return YES;
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
