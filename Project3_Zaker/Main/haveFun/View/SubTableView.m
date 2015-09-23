//
//  SubTableView.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/26.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "SubTableView.h"
#import "HaveFunCell.h"
#import "WebViewController.h"

#define ReuseID @"haveFunCell"

@implementation SubTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self _createSubviews];
    }
    return self;
}

- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
}

- (void)_createSubviews
{
    self.delegate = self;
    self.dataSource = self;
    
    
    
    UINib *nib = [UINib nibWithNibName:@"HaveFunCell" bundle:nil];
    
    [self registerNib:nib forCellReuseIdentifier:ReuseID];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 500;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    HaveFunModel *model = _dataArray[indexPath.row];
    
    WebViewController *vc = [[WebViewController alloc] init];
    
    vc.webUrl = model.webUrl;
    
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    HaveFunCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseID forIndexPath:indexPath];
    
    cell.selectIndex = self.selectIndex;
    
    cell.model = _dataArray[indexPath.row];
    
    return cell;
}

@end
