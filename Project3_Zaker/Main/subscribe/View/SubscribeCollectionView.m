//
//  SubscribeCollectionView.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/13.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "SubscribeCollectionView.h"
#import "SubscribeCollectionViewCell.h"
#import "SubscribeDetailViewController.h"

@implementation SubscribeCollectionView

#define ReuseId @"SubscribeCell"

- (instancetype)initWithFrame:(CGRect)frame collectionViewLayout:(UICollectionViewLayout *)layout
{
    self = [super initWithFrame:frame collectionViewLayout:layout];
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
        [self setNeedsLayout];
    }
}

- (void)_createSubviews
{
    self.backgroundColor = [UIColor colorWithWhite:0.946 alpha:1.000];
    
    self.delegate = self;
    self.dataSource = self;
    
    UINib *nib = [UINib nibWithNibName:@"SubscribeCollectionViewCell" bundle:nil];
    [self registerNib:nib forCellWithReuseIdentifier:ReuseId];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return [_dataArray count];
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubscribeCollectionCellModel *model = _dataArray[indexPath.row];
    
    SubscribeDetailViewController *vc = [[SubscribeDetailViewController alloc] init];
    
    vc.dataArray = model.articles;
    
    vc.block_title = model.block_title;
    
    [self.viewController.navigationController pushViewController:vc animated:YES];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    SubscribeCollectionViewCell *cell =  [collectionView dequeueReusableCellWithReuseIdentifier:ReuseId forIndexPath:indexPath];
    
    cell.model = _dataArray[indexPath.row];
    
    return cell;
}

@end
