//
//  IssueTableViewCellType1.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/10.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "IssueTableViewCellType1.h"
#import "ImageModel.h"
#import "UIImageView+WebCache.h"

@implementation IssueTableViewCellType1

- (void)awakeFromNib {
    
}

- (void)setModel:(IssueModel *)model
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
    
    self.issueTitleLabel.text = _model.title;
    
    ImageModel *imageModel1 = [[ImageModel alloc] init];
    
    [imageModel1 setValuesForKeysWithDictionary:_model.images[0]];
    
    [self.issueImageVIew1 sd_setImageWithURL:[NSURL URLWithString:imageModel1.url]];
    
    ImageModel *imageModel2 = [[ImageModel alloc] init];
    
    [imageModel2 setValuesForKeysWithDictionary:_model.images[1]];
    
    [self.issueImageView2 sd_setImageWithURL:[NSURL URLWithString:imageModel2.url]];
    
    ImageModel *imageModel3 = [[ImageModel alloc] init];
    
    [imageModel3 setValuesForKeysWithDictionary:_model.images[2]];
    
    [self.issueImageView3 sd_setImageWithURL:[NSURL URLWithString:imageModel3.url]];


}

@end
