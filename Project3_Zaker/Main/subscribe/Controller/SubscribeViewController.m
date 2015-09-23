//
//  SubscribeViewController.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/24.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "SubscribeViewController.h"
#import "DiscoverViewController.h"
#import "ThemeManager.h"
#import "MJRefresh.h"
#import "SubscribeCollectionView.h"
#import "SubscribeScrollViewModel.h"
#import "DataService.h"
#import "UIImageView+WebCache.h"
#import "SubscribeCollectionCellModel.h"

@interface SubscribeViewController ()

@end

@implementation SubscribeViewController
{
    UIImageView *_mainCover;
    
    UILabel *_refreshLabel;
    
    UIScrollView *_adScrollView;
    
    SubscribeCollectionView *_mainCollectionView;
    
    NSMutableArray *_subscribeScrollViewModelArray;
    
    NSMutableArray *_subscribeCollectionCellModelArray;
    
    NSMutableArray *_subscribeLocalDataArray;
}
#warning 没有实现
- (void)_createRightBarButton
{
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    [rightButton setImage:[UIImage imageNamed:@"subscribe_jiahao"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)rightButtonAction:(UIButton *)sender
{
    NSLog(@"订阅");
    
    DiscoverViewController *vc = [[DiscoverViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}
#warning 没有实现


#pragma mark - Actions

#pragma mark - CreateSubviews

- (void)_createSubviews
{
    [self _createCollectionView];
    
    [self _loadScrollViewData];
    
    [self _loadLocalData];
}

- (void)_loadScrollViewData
{
    _subscribeScrollViewModelArray = [[NSMutableArray alloc] init];
    
    NSDictionary *dic = @{
                          @"_appid" : @"iphone",
                          @"_bsize" : @"640_960",
                          @"_dev":@"iPhone%2C6.1.3",
                          @"_idfa" : @"456331B2-5024-4562-A9D9-7AAE99E9E71C",
                          @"_lat" : @"30.319618",
                          @"_lbs_city" : @"杭州",
                          @"_lbs_province" : @"浙江",
                          @"_lng" : @"120.336685",
                          @"_mac":@"0C%3A77%3A1A%3A53%3ACA%3A0F",
                          @"_net" : @"wifi",
                          @"_udid" : @"5E088182-3677-4F8F-8E31-342E876FD38E",
                          @"_v" : @"6.2.1",
                          @"_version" : @"6.23",
                          @"m" : @"1442118999"
                          };
    
    NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:dic];
    
    [DataService BaseUrl:SubscribeScrollViewUrl requestUrl:nil httpMethod:@"GET" params:params block:^(id result) {
        NSDictionary *rootDic = result;
        
        NSDictionary *dataDic = rootDic[@"data"];
        
        NSArray *listArray = dataDic[@"list"];
        
        for (NSDictionary *dic in listArray)
        {
            SubscribeScrollViewModel *model = [[SubscribeScrollViewModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            static NSInteger index = 0;
            
            [_subscribeScrollViewModelArray addObject:model];
            
            index++;
            
            if (index == [listArray count])
            {
                [self _createAdScrollView];
                
                index = 0;
            }
        }
    }];
}

- (void)_loadCollectionCellData
{
    _subscribeCollectionCellModelArray = [[NSMutableArray alloc] init];
    
    _subscribeLocalDataArray = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 25; i++)
    {
        NSDictionary *dic = @{
                              @"_appid" : @"iphone",
                              @"_bsize" : @"1536_2048",
                              @"app_id":[NSString stringWithFormat:@"%d",i],
                              @"_version" : @"6.21",
                              };
        
        NSMutableDictionary *params = [[NSMutableDictionary alloc] initWithDictionary:dic];
        
        [DataService BaseUrl:SubscribeCollectionCellUrl requestUrl:nil httpMethod:@"GET" params:params block:^(id result) {
            NSDictionary *rootDic = result;
            
            NSDictionary *dataDic = rootDic[@"data"];
            
            SubscribeCollectionCellModel *model = [[SubscribeCollectionCellModel alloc] init];
            
            if (dataDic != nil)
            {
                [_subscribeLocalDataArray addObject:dataDic];
            }
            
            [model setValuesForKeysWithDictionary:dataDic];
            
            if (model.pic != nil)
            {
                [_subscribeCollectionCellModelArray addObject:model];
            }
            
            [self _reloadData];
        }];
    }
}

- (void)_loadLocalData
{
    _subscribeCollectionCellModelArray = [[NSMutableArray alloc] init];
    
    NSFileManager *manager = [[NSFileManager alloc] init];
    
    NSString *homePath = NSHomeDirectory();
    
    NSString *docPath= [homePath stringByAppendingPathComponent:@"Documents"];
    
    NSString *subscribeCollectionLocalData = [docPath stringByAppendingPathComponent:@"subscribeCollectionLocalData.plist"];
    
    if ([manager fileExistsAtPath:subscribeCollectionLocalData])
    {
        _subscribeLocalDataArray = [NSMutableArray arrayWithContentsOfFile:subscribeCollectionLocalData];
        
        for (NSDictionary *dic in _subscribeLocalDataArray)
        {
            SubscribeCollectionCellModel *model = [[SubscribeCollectionCellModel alloc] init];
            
            [model setValuesForKeysWithDictionary:dic];
            
            if (model.pic != nil)
            {
                [_subscribeCollectionCellModelArray addObject:model];
            }
            
            [self _reloadData];
        }
        
    }
    else
    {
        NSLog(@"没有数据");
        
        [self _loadCollectionCellData];
    }
}

- (void)_saveToLocalPath
{
    NSString *homePath = NSHomeDirectory();
    
    NSString *docPath= [homePath stringByAppendingPathComponent:@"Documents"];
    
    NSString *subscribeCollectionLocalData = [docPath stringByAppendingPathComponent:@"subscribeCollectionLocalData.plist"];
    
    [_subscribeLocalDataArray writeToFile:subscribeCollectionLocalData atomically:YES];
}

- (void)_reloadData
{
    _mainCollectionView.dataArray = _subscribeCollectionCellModelArray;
    
    [_mainCollectionView reloadData];
    
    [self _saveToLocalPath];
}

- (void)_createCollectionView
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    
    layout.itemSize = CGSizeMake(KWidth / 3, KWidth / 3 + 10);
    
    layout.minimumInteritemSpacing = 0;
    
    layout.minimumLineSpacing = 0;
    
    layout.headerReferenceSize = CGSizeMake(KWidth, KHeight * 0.32);
    
    _mainCollectionView = [[SubscribeCollectionView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight - 49 - 64) collectionViewLayout:layout];
    
    [self.view addSubview:_mainCollectionView];
}

- (void)_createAdScrollView
{
    if (_adScrollView == nil)
    {
        _adScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight * 0.32)];
        _adScrollView.contentSize = CGSizeMake(KWidth * [_subscribeScrollViewModelArray count], KHeight * 0.32);
        
        for (int i = 0; i < [_subscribeScrollViewModelArray count]; i++)
        {
            SubscribeScrollViewModel *model = _subscribeScrollViewModelArray[i];
            
            UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(i * KWidth, 0, KWidth, KHeight * 0.32)];
            [imageView sd_setImageWithURL:[NSURL URLWithString:model.promotion_img]];
            
            [_adScrollView addSubview:imageView];
            
            UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(i * KWidth + 20, 175, 340, 30)];
            
            titleLabel.text = model.title;
            
            titleLabel.numberOfLines = 0;
            
            titleLabel.font = [UIFont systemFontOfSize:19];
            
            titleLabel.textColor = [UIColor whiteColor];
            
            [_adScrollView addSubview:titleLabel];
        }
        _adScrollView.pagingEnabled = YES;
        
        _adScrollView.showsHorizontalScrollIndicator = NO;
        
        [_mainCollectionView addSubview:_adScrollView];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"订阅";
    
//    [self _createRightBarButton];
    
    [self _createSubviews];
    
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
