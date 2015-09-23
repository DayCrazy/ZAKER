//
//  SubscribeDetailViewController.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/13.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "SubscribeDetailViewController.h"
#import "IssueTableView.h"
#import "IssueModel.h"

@interface SubscribeDetailViewController ()

@end

@implementation SubscribeDetailViewController
{
    IssueTableView *_detailTableView;
    
    NSMutableArray *_detailModelArray;
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = _block_title;
    
    [self _createSubviews];
 
    [self _loadData];
}

- (void)_createSubviews
{
    _detailTableView = [[IssueTableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    [self.view addSubview:_detailTableView];
}

- (void)_loadData
{
    _detailModelArray = [[NSMutableArray alloc] init];
    
    for (NSDictionary *dic in _dataArray)
    {
        IssueModel *model = [[IssueModel alloc] init];
        
        [model setValuesForKeysWithDictionary:dic];
        
        static NSInteger index = 0;
        
        [_detailModelArray addObject:model];
        
        index++;
        
        if (index == [_dataArray count])
        {
            _detailTableView.issueModelArray = _detailModelArray;
            
            index = 0;
            
            [_detailTableView reloadData];
        }
    }
}

- (void)setBlock_title:(NSString *)block_title
{
    if (block_title != nil)
    {
        _block_title = [block_title copy];
    }
}

- (void)setDataArray:(NSArray *)dataArray
{
    if (dataArray != nil)
    {
        _dataArray = dataArray;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
