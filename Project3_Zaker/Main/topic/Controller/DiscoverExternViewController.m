//
//  DiscoverExternViewController.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/13.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "DiscoverExternViewController.h"
#import "FancyTableView.h"
#import "TopicFancyModel.h"
#import "MJRefresh.h"
#import "DataService.h"

@interface DiscoverExternViewController ()

@end

@implementation DiscoverExternViewController
{
    FancyTableView *_discoverExternTableView;
    
    NSMutableArray *_discoverExternModelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = _model.title;
    
    [self _loadData];
}

- (void)_createSubviews
{
    _discoverExternTableView = [[FancyTableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight - 64) style:UITableViewStyleGrouped];
    
    _discoverExternTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadData)];
    
    _discoverExternTableView.dataArray = _discoverExternModelArray;
    
    [self.view addSubview:_discoverExternTableView];
}

- (void)_endRefresh
{
    [_discoverExternTableView.header endRefreshing];
}


- (void)_loadData
{
    _discoverExternModelArray = [[NSMutableArray alloc] init];
    
    [DataService BaseUrl:_model.api_url requestUrl:nil httpMethod:@"GET" params:nil block:^(id result) {
        
        NSDictionary *rootDic = result;
        
        NSDictionary *dataDic = rootDic[@"data"];
        
        NSArray *postsArray = dataDic[@"posts"];
        
        static int index = 0;
    
        for (NSDictionary *dic in postsArray)
        {
    
            TopicFancyModel *model = [[TopicFancyModel alloc] init];
    
            [model setValuesForKeysWithDictionary:dic];
    
            [_discoverExternModelArray addObject:model];
    
            index++;
    
            if (index == [postsArray count])
            {
                
                [self _createSubviews];

                _discoverExternTableView.dataArray = _discoverExternModelArray;
    
                [_discoverExternTableView reloadData];
                
                index = 0;
                
                [self _endRefresh];

            }
            
        }
    }];
}


- (void)setModel:(TopicDiscoverModel *)model
{
    if (model != nil)
    {
//        for (UIView *view in self.view.subviews)
//        {
//            [view removeFromSuperview];
//        }
        _model = model;
    }
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
