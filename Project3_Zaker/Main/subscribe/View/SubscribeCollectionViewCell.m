//
//  SubscribeCollectionViewCell.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/13.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "SubscribeCollectionViewCell.h"
#import "UIImageView+WebCache.h"

@implementation SubscribeCollectionViewCell

- (void)awakeFromNib {

    self.backgroundColor = [UIColor colorWithWhite:0.967 alpha:1.000];
    
    self.layer.borderColor=[UIColor colorWithWhite:0.945 alpha:1.000].CGColor;
    self.layer.borderWidth=0.3;
}

- (void)setModel:(SubscribeCollectionCellModel *)model
{
    if (model != nil)
    {
        _model = model;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [_blockImageView sd_setImageWithURL:[NSURL URLWithString:_model.pic]];
    
    _blockNameLabel.text = _model.block_title;
}

@end
