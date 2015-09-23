//
//  FancyTableView.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/12.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "FancyTableView.h"
#import "FancyTableViewCell.h"
#import "TopicFancyModel.h"
#import "WebViewController.h"
#import "FancyTableViewCell2.h"
#import "FancyTableViewCell3.h"
#import "FancyTableViewCell4.h"

@implementation FancyTableView

#define ReuseId1 @"fancyTableViewCellType1"

#define ReuseId2 @"fancyTableViewCellType2"

#define ReuseId3 @"fancyTableViewCellType3"

#define ReuseId4 @"fancyTableViewCellType4"


- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style
{
    self = [super initWithFrame:frame style:style];
    if (self)
    {
        [self _createSubviews];
    }
    return self;
}

- (void)_createSubviews
{
    self.dataSource = self;
    self.delegate = self;
    
    UINib *nib1 = [UINib nibWithNibName:@"FancyTableViewCell" bundle:nil];
    [self registerNib:nib1 forCellReuseIdentifier:ReuseId1];
    
    UINib *nib2 = [UINib nibWithNibName:@"FancyTableViewCell2" bundle:nil];
    [self registerNib:nib2 forCellReuseIdentifier:ReuseId2];

    UINib *nib3 = [UINib nibWithNibName:@"FancyTableViewCell3" bundle:nil];
    [self registerNib:nib3 forCellReuseIdentifier:ReuseId3];
    
    UINib *nib4 = [UINib nibWithNibName:@"FancyTableViewCell4" bundle:nil];
    [self registerNib:nib4 forCellReuseIdentifier:ReuseId4];
}

- (void)setDataArray:(NSArray *)dataArray
{
    if (dataArray != nil)
    {
        _dataArray = dataArray;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}

#pragma mark - Delegates

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [_dataArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicFancyModel *model = _dataArray[indexPath.section];
    
    if ([model.images count] == 0)
    {
        return 154;
    }
    else if ([model.images count] == 2)
    {
        return 283;
    }
    else if ([model.images count] == 1 || [model.images count] > 3)
    {
        return 340;
    }
    else if ([model.images count] == 3)
    {
        return 250;
    }
    
    return 340;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0.1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicFancyModel *model = _dataArray[indexPath.section];
    
    WebViewController *webVc = [[WebViewController alloc] init];
    
    webVc.webUrl = model.weburl;
    
    [self.viewController.navigationController pushViewController:webVc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TopicFancyModel *model = _dataArray[indexPath.section];
    
    if ([model.images count] == 0)
    {
        FancyTableViewCell3 *cell = [tableView dequeueReusableCellWithIdentifier:ReuseId3 forIndexPath:indexPath];
        
        if (cell != nil)
        {
            cell.model = model;
            
        }
        
        return cell;
    }
    else if ([model.images count] == 1 || [model.images count] > 3)
    {
        FancyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseId1 forIndexPath:indexPath];
        
        if (cell != nil)
        {
            cell.model = model;
            
        }
        return cell;
    }
    else if ([model.images count] == 3)
    {
        FancyTableViewCell2 *cell = [tableView dequeueReusableCellWithIdentifier:ReuseId2 forIndexPath:indexPath];
        
        if (cell != nil)
        {
            cell.model = model;
            
        }
        return cell;
    }
    else if ([model.images count] == 2)
    {
        FancyTableViewCell4 *cell = [tableView dequeueReusableCellWithIdentifier:ReuseId4 forIndexPath:indexPath];
        
        if (cell != nil)
        {
            cell.model = model;
            
        }
        return cell;
    }
    FancyTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseId1 forIndexPath:indexPath];
    
    if (cell != nil)
    {
        cell.model = model;
        
    }
    return cell;
    
}


@end
