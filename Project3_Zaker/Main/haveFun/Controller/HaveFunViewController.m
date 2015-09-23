//
//  HaveFunViewController.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/24.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "HaveFunViewController.h"
#import "ChooseCityViewController.h"
#import "SubTableView.h"
#import "ThemeManager.h"
#import "HaveFunModel.h"
#import "DataService.h"
#import "jsonAnalysis.h"

@interface HaveFunViewController ()

@end

@implementation HaveFunViewController
{
    UIScrollView *_navigationScrollView;
    UIScrollView *_mainScrollView;
    
    UIView *_indexView;
    
    CGFloat _currentContentOffset;
    
    NSMutableArray *_haveFunModelArray;
    
    SubTableView *_fancyTableView;
    
    SubTableView *_performTableView;
    
    SubTableView *_vocationTableView;
    
    SubTableView *_movieTableView;
    
    SubTableView *_activityTableView;
    
    MBProgressHUD *HUD;
}

- (void)_createRightBarButton
{
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 20)];
    
    UILabel *haveFunLabel = [[UILabel alloc] initWithFrame:CGRectMake(-8, -3, 25, 25)];
    
    UIImageView *haveFunImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 0, 20, 20)];
    
    haveFunImageView.image = [UIImage imageNamed:@"haveFun_dingwei"];
    
    haveFunLabel.font = [UIFont boldSystemFontOfSize:12];
    haveFunLabel.text = @"杭州";
    [haveFunLabel setTextColor:[UIColor whiteColor]];
    
    [rightButton addSubview:haveFunLabel];
    [rightButton addSubview:haveFunImageView];
    
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)rightButtonAction:(UIButton *)sender
{
    NSLog(@"玩乐");
    
    ChooseCityViewController *vc = [[ChooseCityViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - Actions

- (void)selectIndex:(UIButton *)sender
{
    if (self.selectedIndex != sender.tag)
    {
        [UIView animateWithDuration:.3 animations:^{
            _mainScrollView.contentOffset = CGPointMake(sender.tag * KWidth, 0);
            _indexView.frame = CGRectMake(sender.tag * KWidth / 5, 39, KWidth / 5, 1);
            self.selectedIndex = sender.tag;
            
            [self _loadData];
            
            [self _createSubScrollViews];

        }];
    }
}

#pragma mark - CreateSubviews

- (void)_createSubviews
{
    
    [self _createMainScrollView];
    
    [self _createSubScrollViews];
    
    [self _createNavigationScrollView];
    
}

- (void)_createNavigationScrollView
{
    _navigationScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 40)];
    
    NSArray *channelNames = @[@"精选",@"演艺",@"度假",@"电影",@"活动"];
    
    for (int i = 0; i < [channelNames count]; i++)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * KWidth / 5, 0, KWidth / 5, 40)];
        
        [button setTitle:channelNames[i] forState:UIControlStateNormal];

        [button setTitleColor:[[ThemeManager shareInstance] getThemeColorWithColorName:[[NSUserDefaults standardUserDefaults] objectForKey:kThemeName]] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        button.backgroundColor = [UIColor colorWithWhite:0.957 alpha:1.000];
        
        [button addTarget:self action:@selector(selectIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = i;
        
        [_navigationScrollView addSubview:button];
    }
    
    _indexView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, KWidth / 5, 1)];
    _indexView.backgroundColor = [[ThemeManager shareInstance] getThemeColorWithColorName:[[NSUserDefaults standardUserDefaults] objectForKey:kThemeName] ];
    
    [_navigationScrollView addSubview:_indexView];
    
    [self.view addSubview:_navigationScrollView];
}

- (void)_createMainScrollView
{
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
    
    _mainScrollView.contentSize = CGSizeMake(KWidth * 5, KHeight);
    
    _mainScrollView.pagingEnabled = YES;
    
    _mainScrollView.delegate = self;
    
    [self.view addSubview:_mainScrollView];
}

- (void)_createSubScrollViews
{
    if (self.selectedIndex == 0 && _fancyTableView == nil)
    {
        _fancyTableView = [[SubTableView alloc] initWithFrame:CGRectMake(self.selectedIndex * KWidth, 40, KWidth, KHeight - 49 - 64) style:UITableViewStylePlain];
        
        [self _addHUD];
        
        _fancyTableView.dataArray = _haveFunModelArray;
        
        _fancyTableView.selectIndex = self.selectedIndex;
        
        [_mainScrollView addSubview:_fancyTableView];
    }
    else if (self.selectedIndex == 1 && _performTableView == nil)
    {
        _performTableView = [[SubTableView alloc] initWithFrame:CGRectMake(self.selectedIndex * KWidth, 40, KWidth, KHeight - 49 - 64) style:UITableViewStylePlain];
        
        [self _addHUD];
        
        _performTableView.dataArray = _haveFunModelArray;
        
        _performTableView.selectIndex = self.selectedIndex;
        
        [_mainScrollView addSubview:_performTableView];
    }
    else if (self.selectedIndex == 2 && _vocationTableView == nil)
    {
        _vocationTableView = [[SubTableView alloc] initWithFrame:CGRectMake(self.selectedIndex * KWidth, 40, KWidth, KHeight - 49 - 64) style:UITableViewStylePlain];
        
        [self _addHUD];
        
        _vocationTableView.dataArray = _haveFunModelArray;

        _vocationTableView.selectIndex = self.selectedIndex;
        
        [_mainScrollView addSubview:_vocationTableView];
    }
    else if (self.selectedIndex == 3 && _movieTableView == nil)
    {
        _movieTableView = [[SubTableView alloc] initWithFrame:CGRectMake(self.selectedIndex * KWidth, 40, KWidth, KHeight - 49 - 64) style:UITableViewStylePlain];
        
        [self _addHUD];
        
        _movieTableView.dataArray = _haveFunModelArray;
        
        _movieTableView.selectIndex = self.selectedIndex;
        
        [_mainScrollView addSubview:_movieTableView];
    }
    else if (self.selectedIndex == 4 && _activityTableView == nil)
    {
        _activityTableView = [[SubTableView alloc] initWithFrame:CGRectMake(self.selectedIndex * KWidth, 40, KWidth, KHeight - 49 - 64) style:UITableViewStylePlain];
        
        [self _addHUD];
        
        _activityTableView.dataArray = _haveFunModelArray;
        
        _activityTableView.selectIndex = self.selectedIndex;
        
        [_mainScrollView addSubview:_activityTableView];
    }
    
}

#pragma mark - LoadData

- (void)_loadData
{
    if (self.selectedIndex == 0)
    {
        _haveFunModelArray = [[NSMutableArray alloc] init];
        
        NSDictionary *dic = @{
                              @"_appid":@"iphone",
                              @"_v":@"6.2",
                              @"_version":@"6.21",
                              @"c":@"activity_list",
                              @"category":@"10000",
                              @"city":@"杭州",
                              @"lat":@"30.319618",
                              @"lng":@"120.336686",
                              @"p":@"0",
                              @"size":@"20"
                              };
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
        
        [DataService BaseUrl:haveFunBaseUrl requestUrl:nil httpMethod:@"GET" params:params block:^(id result) {
            
            NSDictionary *rootDic = result;
            
            NSDictionary *dataDic = rootDic[@"data"];
            
            NSArray *dataArray = dataDic[@"weekends"];
            
            for (NSDictionary *dic in dataArray) {
                
                HaveFunModel *model = [[HaveFunModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [_haveFunModelArray addObject:model];
                
                [_fancyTableView reloadData];
            }
            
        }];
    }
    else if (self.selectedIndex == 1)
    {
        _haveFunModelArray = [[NSMutableArray alloc] init];
        
        NSDictionary *dic = @{
                              @"_appid":@"iphone",
                              @"_v":@"6.2",
                              @"_version":@"6.21",
                              @"c":@"activity_list",
                              @"category":@"1",
                              @"city":@"杭州",
                              @"lat":@"30.319618",
                              @"lng":@"120.336686",
                              @"p":@"0",
                              @"size":@"20"
                              };
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
        
        [DataService BaseUrl:haveFunBaseUrl requestUrl:nil httpMethod:@"GET" params:params block:^(id result) {
            
            NSDictionary *rootDic = result;
            
            NSDictionary *dataDic = rootDic[@"data"];
            
            NSArray *dataArray = dataDic[@"weekends"];
            
            for (NSDictionary *dic in dataArray) {
                
                HaveFunModel *model = [[HaveFunModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [_haveFunModelArray addObject:model];
                
                [_performTableView reloadData];
            }
            
        }];
    }
    else if (self.selectedIndex == 2)
    {
        _haveFunModelArray = [[NSMutableArray alloc] init];
        
        NSDictionary *dic = @{
                              @"_appid":@"iphone",
                              @"_v":@"6.2",
                              @"_version":@"6.21",
                              @"c":@"activity_list",
                              @"category":@"4",
                              @"city":@"杭州",
                              @"lat":@"30.319618",
                              @"lng":@"120.336686",
                              @"p":@"0",
                              @"size":@"20"
                              };
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
        
        [DataService BaseUrl:haveFunBaseUrl requestUrl:nil httpMethod:@"GET" params:params block:^(id result) {
            
            NSDictionary *rootDic = result;
            
            NSDictionary *dataDic = rootDic[@"data"];
            
            NSArray *dataArray = dataDic[@"weekends"];
            
            for (NSDictionary *dic in dataArray) {
                
                HaveFunModel *model = [[HaveFunModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [_haveFunModelArray addObject:model];
                
                [_vocationTableView reloadData];
            }
            
        }];
    }
    else if (self.selectedIndex == 3)
    {
        _haveFunModelArray = [[NSMutableArray alloc] init];
        
        NSDictionary *dic = @{
                              @"_appid":@"iphone",
                              @"_v":@"6.2.1",
                              @"_version":@"6.23",
                              @"c":@"movie_list",
                              @"city":@"杭州",
                              @"lat":@"30.319770",
                              @"lng":@"120.336867",
                              };
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
        
        [DataService BaseUrl:haveFunBaseUrl requestUrl:nil httpMethod:@"GET" params:params block:^(id result) {
            
            NSDictionary *rootDic = result;
            
            NSDictionary *dataDic = rootDic[@"data"];
            
            NSArray *dataArray = dataDic[@"weekends"];
            
            for (NSDictionary *dic in dataArray) {
                
                HaveFunModel *model = [[HaveFunModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [_haveFunModelArray addObject:model];
                
                [_movieTableView reloadData];
            }
            
        }];
    }
    else if (self.selectedIndex == 4)
    {
        _haveFunModelArray = [[NSMutableArray alloc] init];
        
        NSDictionary *dic = @{
                              @"_appid":@"iphone",
                              @"_v":@"6.2",
                              @"_version":@"6.21",
                              @"c":@"activity_list",
                              @"category":@"3",
                              @"city":@"杭州",
                              @"lat":@"30.319618",
                              @"lng":@"120.336686",
                              @"p":@"0",
                              @"size":@"20"
                              };
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
        
        [DataService BaseUrl:haveFunBaseUrl requestUrl:nil httpMethod:@"GET" params:params block:^(id result) {
            
            NSDictionary *rootDic = result;
            
            NSDictionary *dataDic = rootDic[@"data"];
            
            NSArray *dataArray = dataDic[@"weekends"];
            
            for (NSDictionary *dic in dataArray) {
                
                HaveFunModel *model = [[HaveFunModel alloc] init];
                
                [model setValuesForKeysWithDictionary:dic];
                
                [_haveFunModelArray addObject:model];
                
                [_activityTableView reloadData];
            }
            
        }];
    }

}

//- (void)_loadData
//{
//    _haveFunModelArray = [[NSMutableArray alloc] init];
//    
//    NSDictionary *rootDic = [jsonAnalysis initWithJsonFileName:@"wl.myzaker.com.json"];
//
//    NSDictionary *dataDic = rootDic[@"data"];
//
//    NSArray *dataArray = dataDic[@"weekends"];
//
//    for (NSDictionary *dic in dataArray) {
//
//        HaveFunModel *model = [[HaveFunModel alloc] init];
//
//        [model setValuesForKeysWithDictionary:dic];
//
//        [_haveFunModelArray addObject:model];
//
////        [_fancyTableView reloadData];
//    }
//    
////    _fancyTableView.dataArray = _haveFunModelArray;
//}

#pragma mark - Delegates

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentContentOffset = scrollView.contentOffset.x / 5;
    
    _indexView.frame = CGRectMake(_currentContentOffset, 39, KWidth / 5, 1);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.selectedIndex = scrollView.contentOffset.x / KWidth;
    
    [self _loadData];
    
    [self _createSubScrollViews];

}

- (void)themeChange:(NSNotification *)notification
{
    _indexView.backgroundColor = [[ThemeManager shareInstance] getThemeColorWithColorName:[[NSUserDefaults standardUserDefaults]objectForKey:kThemeName]];
    
    [self _createNavigationScrollView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"玩乐";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange:) name:kThemeDidChangeNotification object:nil];
    
    [self _loadData];
    
//    [self _createRightBarButton];
    
    [self _createSubviews];
    
    [self _addHUD];
}

- (void)_addHUD
{
    HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:HUD];
    
    // Set determinate mode
    HUD.mode = MBProgressHUDModeAnnularDeterminate;
    
    HUD.delegate = self;
    HUD.labelText = @"Loading";
    
    // myProgressTask uses the HUD instance to update progress
    [HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}

- (void)myProgressTask {
    // This just increases the progress indicator in a loop
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        HUD.progress = progress;
        usleep(10000);
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
