//
//  TopicViewController.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/24.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "TopicViewController.h"
#import "ThemeManager.h"
#import "FancyTableView.h"
#import "DiscoverTableView.h"
#import "ConcernView.h"
#import "DataService.h"
#import "TopicFancyModel.h"
#import "TopicDiscoverModel.h"
#import "TopicFancyModel.h"
#import "MJRefresh.h"
#import "TopicDiscoverModel.h"
#import "MBProgressHUD.h"

@interface TopicViewController () <MBProgressHUDDelegate>

@end

@implementation TopicViewController
{
    UIScrollView *_mainScrollView;
    
    UIView *_navigationView;
    
    UIView *_indexView;
    
    FancyTableView *_fancyTableView;
    
    DiscoverTableView *_discoverTableView;
    
    ConcernView *_concernView;
    
    NSMutableArray *_fancyModelArray;
    
    NSMutableArray *_discoverModelArray;
    
    CGFloat _currentContentOffset;
    
    NSMutableArray *_fancyLocalDataArray;
    
    NSMutableArray *_discoverLocalDataArray;
    
    NSArray *_listArray1;
    
    NSArray *_listArray2;
    
    MBProgressHUD *_HUD;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"话题";
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange:) name:kThemeDidChangeNotification object:nil];
        
    [self _createSubviews];

}

- (void)_addHUD
{
    _HUD = [[MBProgressHUD alloc] initWithView:self.navigationController.view];
    [self.navigationController.view addSubview:_HUD];
    
    // Set determinate mode
    _HUD.mode = MBProgressHUDModeAnnularDeterminate;
    
    _HUD.delegate = self;
    _HUD.labelText = @"Loading";
    
    // myProgressTask uses the HUD instance to update progress
    [_HUD showWhileExecuting:@selector(myProgressTask) onTarget:self withObject:nil animated:YES];
}

- (void)myProgressTask {
    // This just increases the progress indicator in a loop
    float progress = 0.0f;
    while (progress < 1.0f) {
        progress += 0.01f;
        _HUD.progress = progress;
        usleep(50000);
    }
}

- (void)_createSubviews
{
    [self _createMainScrollView];
    
    [self _createNavigationView];
    
    [self _createLoginView];
}

- (void)_createMainScrollView
{
    _mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight)];
    
    _mainScrollView.contentSize = CGSizeMake(KWidth * 3, KHeight);
    
    _mainScrollView.pagingEnabled = YES;
    
    _mainScrollView.delegate = self;
    
    [self.view addSubview:_mainScrollView];
}

- (void)_createNavigationView
{
    _navigationView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KWidth, 40)];
    
    NSArray *channelNames = @[@"关注",@"精选",@"发现"];
    
    for (int i = 0; i < [channelNames count]; i++)
    {
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(i * KWidth / 3, 0, KWidth / 3, 40)];
        
        [button setTitle:channelNames[i] forState:UIControlStateNormal];
        
        [button setTitleColor:[[ThemeManager shareInstance] getThemeColorWithColorName:[[NSUserDefaults standardUserDefaults] objectForKey:kThemeName]] forState:UIControlStateNormal];
        
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        button.backgroundColor = [UIColor colorWithWhite:0.957 alpha:1.000];
        
        [button addTarget:self action:@selector(selectIndex:) forControlEvents:UIControlEventTouchUpInside];
        
        button.tag = i;
        
        [_navigationView addSubview:button];
    }
    
    _indexView = [[UIView alloc] initWithFrame:CGRectMake(0, 39, KWidth / 3, 1)];
    _indexView.backgroundColor = [[ThemeManager shareInstance] getThemeColorWithColorName:[[NSUserDefaults standardUserDefaults] objectForKey:kThemeName]];
    
    [_navigationView addSubview:_indexView];
    
    [self.view addSubview:_navigationView];
}

- (void)selectIndex:(UIButton *)sender
{
    if (self.selectedIndex != sender.tag)
    {
        [UIView animateWithDuration:.3 animations:^{
            _mainScrollView.contentOffset = CGPointMake(sender.tag * KWidth, 0);
            _indexView.frame = CGRectMake(sender.tag * KWidth / 3, 39, KWidth / 3, 1);
            self.selectedIndex = sender.tag;
            
            [self _loadLocalData];
            
            [self _createSubScrollViews];
        }];
    }
}

- (void)_loadLocalData
{
    if (self.selectedIndex == 1)
    {
        _fancyModelArray = [[NSMutableArray alloc] init];
        
        NSFileManager *manager = [[NSFileManager alloc] init];
        
        NSString *homePath = NSHomeDirectory();
        
        NSString *docPath= [homePath stringByAppendingPathComponent:@"Documents"];
        
        NSString *fancyLocalData = [docPath stringByAppendingPathComponent:@"TopicFancyLocalData.plist"];
        
        if ([manager fileExistsAtPath:fancyLocalData])
        {
            _fancyLocalDataArray = [NSMutableArray arrayWithContentsOfFile:fancyLocalData];
        }
        else
        {
            NSLog(@"没有数据");
            
            [self _loadNewData];
            
            [self _addHUD];
        }
        
        static int index = 0;
        
        for (NSDictionary *dic in _fancyLocalDataArray)
        {
            
            TopicFancyModel *model = [[TopicFancyModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [_fancyModelArray addObject:model];
            
            index++;
            
            if (index == [_fancyLocalDataArray count])
            {
                _fancyTableView.dataArray = _fancyModelArray;
                
                [_fancyTableView reloadData];
                
                index = 0;
            }
        }
        
        [self _endRefresh];
    }
    else if (self.selectedIndex == 2)
    {
        _discoverModelArray = [[NSMutableArray alloc] init];
        
        NSFileManager *manager = [[NSFileManager alloc] init];
        
        NSString *homePath = NSHomeDirectory();
        
        NSString *docPath= [homePath stringByAppendingPathComponent:@"Documents"];
        
        NSString *discoverLocalData = [docPath stringByAppendingPathComponent:@"TopicDiscoverLocalData.plist"];
        
        if ([manager fileExistsAtPath:discoverLocalData])
        {
            _discoverLocalDataArray = [NSMutableArray arrayWithContentsOfFile:discoverLocalData];
        }
        else
        {
            NSLog(@"没有数据");

            [self _loadNewData];
            
            [self _addHUD];
        }
        
        static int index = 0;
        
        for (NSDictionary *dic in _discoverLocalDataArray)
        {
            
            TopicDiscoverModel *model = [[TopicDiscoverModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            [_discoverModelArray addObject:model];
            
            index++;
            
            if (index == [_discoverLocalDataArray count])
            {
                _discoverTableView.dataArray = _discoverModelArray;
                
                [_discoverTableView reloadData];
                
                index = 0;
            }
        }
        
        [self _endRefresh];
    }
}

- (void)_loadNewData
{
    if (self.selectedIndex == 1)
    {
        _fancyModelArray = [[NSMutableArray alloc] init];
        
        NSFileManager *manager = [[NSFileManager alloc] init];
        
        NSString *homePath = NSHomeDirectory();
        
        NSString *docPath= [homePath stringByAppendingPathComponent:@"Documents"];
        
        NSString *fancyLocalData = [docPath stringByAppendingPathComponent:@"TopicFancyLocalData.plist"];
        
        if ([manager fileExistsAtPath:fancyLocalData])
        {
            _fancyLocalDataArray = [NSMutableArray arrayWithContentsOfFile:fancyLocalData];
        }
        else
        {
            _fancyLocalDataArray = [[NSMutableArray alloc] init];
        }
        
        NSDictionary *dic = @{
                              @"_appid":@"iphone",
                              @"_bsize":@"640_960",
                              @"_dev":@"iPhone%2C6.1.3",
                              @"_v":@"6.2.1",
                              @"_version":@"6.23",
                              @"_idfa":@"456331B2-5024-4562-A9D9-7AAE99E9E71C",
                              @"_lbs_city":@"%E6%9D%AD%E5%B7%9E&",
                              @"_lbs_province":@"%E6%B5%99%E6%B1%9F&",
                              @"lat":@"30.316975",
                              @"lng":@"120.338364",
                              @"_mac":@"0C%3A77%3A1A%3A53%3ACA%3A0F",
                              @"_net":@"wifi",
                              @"_udid":@"5E088182-3677-4F8F-8E31-342E876FD38E",
                              };
        
        NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
        
        [DataService BaseUrl:TopicFancyUrl requestUrl:nil httpMethod:@"GET" params:params block:^(id result) {
            
            NSDictionary *rootDic = result;
            
            NSDictionary *dataDic = rootDic[@"data"];
            
            NSArray *postsArray = dataDic[@"posts"];
            
            if ([postsArray count] > [_fancyLocalDataArray count])
            {
                [_fancyLocalDataArray addObjectsFromArray:postsArray];
                
                [self _saveToLocalPath];
                
                [self _loadLocalData];
            }
            else if ([postsArray count] > 0)
            {
                _fancyLocalDataArray = [[NSMutableArray alloc] initWithArray:postsArray];
                
                [self _saveToLocalPath];
                
                [self _loadLocalData];
            }
            else
            {
                [self _endRefresh];
                
                return;
            }
        }];
    }
    else if (self.selectedIndex == 2)
    {
        _discoverModelArray = [[NSMutableArray alloc] init];
        
        NSFileManager *manager = [[NSFileManager alloc] init];
        
        NSString *homePath = NSHomeDirectory();
        
        NSString *docPath= [homePath stringByAppendingPathComponent:@"Documents"];
        
        NSString *discoverLocalData = [docPath stringByAppendingPathComponent:@"TopicDiscoverLocalData.plist"];
        
        if ([manager fileExistsAtPath:discoverLocalData])
        {
            _discoverLocalDataArray = [NSMutableArray arrayWithContentsOfFile:discoverLocalData];
        }
        else
        {
            _discoverLocalDataArray = [[NSMutableArray alloc] init];
        }
        
        NSDictionary *dic1 = @{
                              @"_appid":@"iphone",
                              @"_bsize":@"640_960",
                              @"_dev":@"iPhone%2C6.1.3",
                              @"_v":@"6.2.1",
                              @"_version":@"6.23",
                              @"_idfa":@"456331B2-5024-4562-A9D9-7AAE99E9E71C",
                              @"_lbs_city":@"%E6%9D%AD%E5%B7%9E&",
                              @"_lbs_province":@"%E6%B5%99%E6%B1%9F&",
                              @"lat":@"30.316975",
                              @"lng":@"120.338364",
                              @"_mac":@"0C%3A77%3A1A%3A53%3ACA%3A0F",
                              @"_net":@"wifi",
                              @"_udid":@"5E088182-3677-4F8F-8E31-342E876FD38E",
                              @"except_subscribe":@"N"
                              };
        
        NSMutableDictionary *params1 = [NSMutableDictionary dictionaryWithDictionary:dic1];
        
        [DataService BaseUrl:TopicDiscoverUrl requestUrl:nil httpMethod:@"GET" params:params1 block:^(id result) {
            
            NSDictionary *rootDic = result;
            
            NSDictionary *dataDic = rootDic[@"data"];
            
            _listArray1 = dataDic[@"list"];
        }];
        
        NSDictionary *dic2 = @{
                              @"_appid":@"iphone",
                              @"_bsize":@"640_960",
                              @"_dev":@"iPhone%2C6.1.3",
                              @"_v":@"6.2.1",
                              @"_version":@"6.23",
                              @"_idfa":@"456331B2-5024-4562-A9D9-7AAE99E9E71C",
                              @"_lbs_city":@"%E6%9D%AD%E5%B7%9E&",
                              @"_lbs_province":@"%E6%B5%99%E6%B1%9F&",
                              @"lat":@"30.316975",
                              @"lng":@"120.338364",
                              @"_mac":@"0C%3A77%3A1A%3A53%3ACA%3A0F",
                              @"_net":@"wifi",
                              @"_udid":@"5E088182-3677-4F8F-8E31-342E876FD38E",
                              @"except_recommend":@"Y",
                              @"act":@"more_discussion"
                              };
        
        NSMutableDictionary *params2 = [NSMutableDictionary dictionaryWithDictionary:dic2];
        
        [DataService BaseUrl:TopicDiscoverUrl requestUrl:nil httpMethod:@"GET" params:params2 block:^(id result)
         {
             NSDictionary *rootDic = result;
             
             NSDictionary *dataDic = rootDic[@"data"];
             
             _listArray2 = dataDic[@"list"];
             
             [_discoverModelArray addObjectsFromArray:_listArray1];
             
             [_discoverModelArray addObjectsFromArray:_listArray2];
             
             if ([_discoverModelArray count] > [_discoverLocalDataArray count])
             {
                 _discoverLocalDataArray = [[NSMutableArray alloc] initWithArray:_discoverModelArray];
                 
                 [self _saveToLocalPath];
                 
                 [self _loadLocalData];
             }
             else
             {
                 [self _endRefresh];
                 
                 return;
             }
             
         }];
    }
    

}

- (void)_saveToLocalPath
{
    if (self.selectedIndex == 1)
    {
        NSString *homePath = NSHomeDirectory();
        
        NSString *docPath= [homePath stringByAppendingPathComponent:@"Documents"];
        
        NSString *fancyLocalData = [docPath stringByAppendingPathComponent:@"TopicFancyLocalData.plist"];
        
        [_fancyLocalDataArray writeToFile:fancyLocalData atomically:YES];
    }
    else if (self.selectedIndex == 2)
    {
        NSString *homePath = NSHomeDirectory();
        
        NSString *docPath= [homePath stringByAppendingPathComponent:@"Documents"];
        
        NSString *discoverLocalData = [docPath stringByAppendingPathComponent:@"TopicDiscoverLocalData.plist"];
        
        [_discoverLocalDataArray writeToFile:discoverLocalData atomically:YES];
    }
}

- (void)_createLoginView
{
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSArray *detailArrays = [bundle loadNibNamed:@"ConcernView" owner:self options:nil];
    
    _concernView = [detailArrays lastObject];
    
    _concernView.frame = self.view.bounds;
    
    [_mainScrollView addSubview:_concernView];
}

- (void)_createSubScrollViews
{
    if (self.selectedIndex == 1)
    {
        _fancyTableView = [[FancyTableView alloc] initWithFrame:CGRectMake(self.selectedIndex * KWidth, 40, KWidth, KHeight - 49 - 64 - 40) style:UITableViewStyleGrouped];
        
        _fancyTableView.dataArray = _fancyModelArray;
        
        _fancyTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewData)];
        
        [_mainScrollView addSubview:_fancyTableView];
    }
    else if (self.selectedIndex == 2)
    {
        _discoverTableView = [[DiscoverTableView alloc] initWithFrame:CGRectMake(self.selectedIndex * KWidth, 40, KWidth, KHeight - 49 - 64 - 40) style:UITableViewStylePlain];
        
        _discoverTableView.dataArray = _discoverModelArray;
        
        _discoverTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewData)];
        
        [_mainScrollView addSubview:_discoverTableView];
    }
}

- (void)_endRefresh
{
    if (self.selectedIndex == 1)
    {
        [_fancyTableView.header endRefreshing];
    }
    else if (self.selectedIndex == 2)
    {
        [_discoverTableView.header endRefreshing];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    _currentContentOffset = scrollView.contentOffset.x / 3;
    
    _indexView.frame = CGRectMake(_currentContentOffset, 39, KWidth / 3, 1);
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    self.selectedIndex = scrollView.contentOffset.x / KWidth;
    
    [self _loadLocalData];
    
    [self _createSubScrollViews];
}

- (void)themeChange:(NSNotification *)notification
{
    _indexView.backgroundColor = [[ThemeManager shareInstance] getThemeColorWithColorName:[[NSUserDefaults standardUserDefaults]objectForKey:kThemeName]];
    
    [self _createNavigationView];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
