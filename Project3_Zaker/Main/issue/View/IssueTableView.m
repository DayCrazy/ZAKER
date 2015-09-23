//
//  IssueTableView.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/31.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "IssueTableView.h"
#import "IssueTableViewCellType1.h"
#import "IssueTableViewCellType2.h"
#import "WebViewController.h"

#define ReuseId @"IssueReuseCell"
#define Type1 @"IssueTableViewCellType1"
#define Type2 @"IssueTableViewCellType2"

@implementation IssueTableView

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
    
    UINib *nib = [UINib nibWithNibName:@"IssueTableViewCell" bundle:nil];
    [self registerNib:nib forCellReuseIdentifier:ReuseId];
    
    UINib *nib2 = [UINib nibWithNibName:@"IssueTableViewCellType1" bundle:nil];
    [self registerNib:nib2 forCellReuseIdentifier:Type1];
    
    UINib *nib3 = [UINib nibWithNibName:@"IssueTableViewCellType2" bundle:nil];
    [self registerNib:nib3 forCellReuseIdentifier:Type2];
}

- (void)setIssueModelArray:(NSArray *)issueModelArray
{
    if (issueModelArray != nil)
    {
        _issueModelArray = issueModelArray;
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
    return [_issueModelArray count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IssueModel *model = _issueModelArray[indexPath.section];
    
    if (model.imageUrl == nil)
    {
        if ([model.images count] == 0)
        {
            return 64;
        }
        else if ([model.images count] == 1)
        {
            return 265;
        }
        else if ([model.images count] >= 3)
        {
            return 199;
        }
    }
    else if (model.imageUrl.length > 0)
    {
        return 265;
    }
    else if (model.imageUrl.length == 0)
    {
        return 64;
    }
    return 265;
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
    IssueModel *model = _issueModelArray[indexPath.section];
    
    WebViewController *webVc = [[WebViewController alloc] init];
    
    webVc.webUrl = model.weburl;
    
    [self.viewController.navigationController pushViewController:webVc animated:YES];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    IssueModel *model = _issueModelArray[indexPath.section];
    
    if (model.imageUrl.length == 0)
    {
        
        if ([model.images count] == 0)
        {
            IssueTableViewCellType2 *cell = [tableView dequeueReusableCellWithIdentifier:Type2 forIndexPath:indexPath];
            
            if (cell != nil)
            {
                cell.model = model;
                
            }
            
            return cell;
        }
        else if ([model.images count] == 1)
        {
            IssueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseId forIndexPath:indexPath];
            
            if (cell != nil)
            {
                cell.model = model;
                
            }
            return cell;
        }
        else if ([model.images count] >= 3)
        {
            IssueTableViewCellType1 *cell = [tableView dequeueReusableCellWithIdentifier:Type1 forIndexPath:indexPath];
            
            if (cell != nil)
            {
                cell.model = model;
                
            }
            return cell;
        }

    }
    else if (model.imageUrl.length > 0)
    {
        IssueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseId forIndexPath:indexPath];
        
        if (cell != nil)
        {
            cell.model = model;
        }
        return cell;
    }
    
    IssueTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseId forIndexPath:indexPath];
    
    if (cell != nil)
    {
        cell.model = model;
        
    }
    return cell;
}


@end
