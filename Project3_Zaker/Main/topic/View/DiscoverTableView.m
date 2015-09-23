//
//  DiscoverTableView.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/12.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "DiscoverTableView.h"
#import "DiscoverTableViewCell.h"
#import "DiscoverExternViewController.h"

#define ReuseId @"DiscoverTableViewCell"

@implementation DiscoverTableView

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
    if (dataArray != nil)
    {
        _dataArray = dataArray;
    }
}

- (void)_createSubviews
{
    self.dataSource = self;
    self.delegate = self;
    
    UINib *nib = [UINib nibWithNibName:@"DiscoverTableViewCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:ReuseId];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverExternViewController *vc = [[DiscoverExternViewController alloc] init];
    
    vc.model = _dataArray[indexPath.row];
    
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseId forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    
    return cell;
}


@end
