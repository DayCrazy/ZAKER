//
//  SubscribeCollectionViewCell.h
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/13.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SubscribeCollectionCellModel.h"

@interface SubscribeCollectionViewCell : UICollectionViewCell

@property (nonatomic,strong) SubscribeCollectionCellModel *model;
@property (weak, nonatomic) IBOutlet UIImageView *blockImageView;
@property (weak, nonatomic) IBOutlet UILabel *blockNameLabel;

@end
