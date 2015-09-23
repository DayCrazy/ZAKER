//
//  IssueViewController.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/24.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "IssueViewController.h"
#import "ReadViewController.h"
#import "IssueModel.h"
#import "ImageModel.h"
#import "DataService.h"
#import "IssueTableView.h"
#import "MJRefresh.h"

#define LocalPathData @"IssueLocalData"

@interface IssueViewController ()

@end

@implementation IssueViewController
{
    IssueTableView *_issueTableView;
    
    NSMutableArray *_issueModelArray;
    
    NSMutableArray *_localPathDataArray;
    
    MBProgressHUD *_HUD;
}

- (void)_createRightBarButton
{
    UIButton *rightButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    [rightButton setImage:[UIImage imageNamed:@"issue_biaoqian"] forState:UIControlStateNormal];
    
    [rightButton addTarget:self action:@selector(rightButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightButton];
}

- (void)rightButtonAction:(UIButton *)sender
{
    NSLog(@"热点");
    
    ReadViewController *vc = [[ReadViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - LoadData

- (void)_loadNewData
{
    _issueModelArray = [[NSMutableArray alloc] init];

    NSFileManager *manager = [[NSFileManager alloc] init];
    
    NSString *homePath = NSHomeDirectory();
    
    NSString *docPath= [homePath stringByAppendingPathComponent:@"Documents"];
    
    NSString *issueLocalData = [docPath stringByAppendingPathComponent:@"issueLocalData.plist"];
    
    if ([manager fileExistsAtPath:issueLocalData])
    {
        _localPathDataArray = [NSMutableArray arrayWithContentsOfFile:issueLocalData];
    }
    else
    {
        _localPathDataArray = [[NSMutableArray alloc] init];
    }
    
    NSDictionary *dic = @{
                          @"_appid" : @"iphone",
                          @"_bsize" : @"640_960",
                          @"_idfa" : @"456331B2-5024-4562-A9D9-7AAE99E9E71C",
                          @"_lat" : @"30.319618",
                          @"_lbs_city" : @"杭州",
                          @"_lbs_province" : @"浙江",
                          @"_lng" : @"120.336685",
                          @"_net" : @"wifi",
                          @"_udid" : @"5E088182-3677-4F8F-8E31-342E876FD38E",
                          @"_uid" : @"",
                          @"_utoken" : @"",
                          @"_v" : @"",
                          @"_version" : @"6.21",
                          @"act" : @"pre",
                          @"last_time" : @"1439467535",
                          @"rank" : @"13093"
                          };
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithDictionary:dic];
    
    [DataService BaseUrl:issueBaseUrl requestUrl:nil httpMethod:@"GET" params:params block:^(id result) {
        
        NSDictionary *rootDic = result;
        
        NSDictionary *dataDic = rootDic[@"data"];
        
        NSArray *dataArray = dataDic[@"articles"];
        
        if ([dataArray count] > 0)
        {
            [_localPathDataArray addObjectsFromArray:dataArray];
            
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

- (void)_loadLocalData
{
    _issueModelArray = [[NSMutableArray alloc] init];
    
    NSFileManager *manager = [[NSFileManager alloc] init];
    
    NSString *homePath = NSHomeDirectory();
    
    NSString *docPath= [homePath stringByAppendingPathComponent:@"Documents"];
    
    NSString *issueLocalData = [docPath stringByAppendingPathComponent:@"issueLocalData.plist"];
    
    if ([manager fileExistsAtPath:issueLocalData])
    {
        _localPathDataArray = [NSMutableArray arrayWithContentsOfFile:issueLocalData];
    }
    else
    {
        NSLog(@"没有数据");
        
        [self _loadNewData];
        
        [self _addHUD];
    }
    
    static int index = 0;
    
    for (NSDictionary *dic in _localPathDataArray) {
        
        IssueModel *model = [[IssueModel alloc] init];
        
        [model setValuesForKeysWithDictionary:dic];
        
        [_issueModelArray addObject:model];
        
        index++;
        
        if (index == [_localPathDataArray count])
        {
            for (int i = 0; i < [_issueModelArray count] / 2.0; i++)
            {
                
                [_issueModelArray exchangeObjectAtIndex:i withObjectAtIndex:[_issueModelArray count] - 1 - i];
                
            }
            _issueTableView.issueModelArray = _issueModelArray;
            
            [_issueTableView reloadData];
            
            index = 0;
        }
    }
    
    [self _endRefresh];
}

- (void)_saveToLocalPath
{
    NSString *homePath = NSHomeDirectory();

    NSString *docPath= [homePath stringByAppendingPathComponent:@"Documents"];

    NSString *issueLocalData = [docPath stringByAppendingPathComponent:@"issueLocalData.plist"];
    
    [_localPathDataArray writeToFile:issueLocalData atomically:YES];
}

#pragma mark - CreateSubviews

- (void)_createSubviews
{
    [self _createTableView];
    
    _issueTableView.header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(_loadNewData)];
}

- (void)_endRefresh
{
    [_issueTableView.header endRefreshing];
}

- (void)_hudAction
{
    sleep(3);
}

- (void)_createTableView
{
    _issueTableView = [[IssueTableView alloc] initWithFrame:CGRectMake(0, 0, KWidth, KHeight - 64 - 49) style:UITableViewStyleGrouped];
    
    [self.view addSubview:_issueTableView];
}


- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"热点";
    
//    [self _createRightBarButton];
    
    [self _createSubviews];
    
    [self _loadLocalData];
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
