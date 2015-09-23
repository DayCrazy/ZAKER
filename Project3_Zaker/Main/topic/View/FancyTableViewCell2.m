//
//  FancyTableViewCell2.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/12.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "FancyTableViewCell2.h"
#import "ImageModel.h"
#import "UIImageView+WebCache.h"

@implementation FancyTableViewCell2

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(TopicFancyModel *)model
{
    if (model != nil)
    {
        for(UIView *view in self.contentView.subviews)
        {
            if ([view isKindOfClass:[FancyUserInfoView class]])
            {
                [view removeFromSuperview];
            }
        }
        
        _model = model;
        [self setNeedsLayout];
    }
}

- (void)layoutSubviews
{

    [super layoutSubviews];
    
    [self _createUserInfoView];
    
    self.userInfoView.model = _model;
    
    self.contentLabel.text = _model.content;
    
    if ([_model.images count] > 0)
    {
        ImageModel * imageModel1 = [[ImageModel alloc] init];
        [imageModel1 setValuesForKeysWithDictionary:_model.images[0]];
        
        [self.contentImageView1 sd_setImageWithURL:[NSURL URLWithString:imageModel1.url]];
        
        ImageModel * imageModel2 = [[ImageModel alloc] init];
        [imageModel2 setValuesForKeysWithDictionary:_model.images[1]];
        
        [self.contentImageView2 sd_setImageWithURL:[NSURL URLWithString:imageModel2.url]];
        
        ImageModel * imageModel3 = [[ImageModel alloc] init];
        [imageModel3 setValuesForKeysWithDictionary:_model.images[2]];
        
        [self.contentImageView3 sd_setImageWithURL:[NSURL URLWithString:imageModel3.url]];
    }
}

@end
