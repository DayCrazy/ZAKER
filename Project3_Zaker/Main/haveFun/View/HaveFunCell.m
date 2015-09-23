//
//  HaveFunCell.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/27.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "HaveFunCell.h"
#import "UIImageView+WebCache.h"

@implementation HaveFunCell
{
    UIImageView *_labelBgImageView;
    
    UILabel * _titlelabel;
    
    UILabel * _pos_strLabel;
    
    UIImage *_labelBgImage;
    
    UILabel *_labelBgText;
    
    NSString *_labelString;
}

- (void)awakeFromNib {
    
}

- (void)setModel:(HaveFunModel *)model
{
    if (model != nil)
    {
        _model = model;
        
        for(UIView *view in self.contentView.subviews) {
            [view removeFromSuperview];
        }
        
        [self setNeedsLayout];
        
    }
}

- (void)setNeedsLayout
{
    [super setNeedsLayout];
    
    if (self.selectIndex % 2 == 0)
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(62.5, 80, 250, 250)];
        
        [self.contentView addSubview:imageView];
        
        [imageView sd_setImageWithURL:[NSURL URLWithString:_model.url]];
        
        imageView.layer.masksToBounds = YES;
        
        imageView.layer.cornerRadius = 250 / 2;
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(47, 335, 280, 76)];
        
        _titlelabel.text = _model.title;
        
        _titlelabel.textAlignment = NSTextAlignmentCenter;
        
        _titlelabel.numberOfLines = 0;
        
        _titlelabel.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_titlelabel];
        
        _pos_strLabel = [[UILabel alloc] initWithFrame:CGRectMake(37, 390, 300, 21)];
        
        _pos_strLabel.text = _model.pos_str;
        
        _pos_strLabel.textAlignment = NSTextAlignmentCenter;
        
        _pos_strLabel.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:_pos_strLabel];
        
        _pos_strLabel.textColor = [UIColor colorWithWhite:0.670 alpha:1.000];
        
        if (self.selectIndex == 0)
        {
            _labelString = [NSString stringWithFormat:@"%@ %@",_model.time_str,_model.category_name];
        }
        else
        {
            _labelString = [NSString stringWithFormat:@"%@",_model.time_str];
        }
        
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        
        CGSize size = [_labelString boundingRectWithSize:CGSizeMake(100, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        _labelBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake((KWidth - size.width) / 2, 415, size.width, size.height)];
        
        _labelBgImage = [UIImage imageNamed:@"FlexibleRectangle-Black@3x"];
        
        _labelBgImage = [_labelBgImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        
        _labelBgImageView.image = _labelBgImage;
        
        _labelBgText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _labelBgImageView.frame.size.width, _labelBgImageView.frame.size.height)];
        
        _labelBgText.text = _labelString;
        
        [_labelBgImageView addSubview:_labelBgText];
        
        _labelBgText.textColor = [UIColor whiteColor];
        _labelBgText.font = [UIFont systemFontOfSize:8];
        _labelBgText.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_labelBgImageView];
    }
    else
    {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 375, 490)];
        
        [self.contentView addSubview:imageView];
        
         [imageView sd_setImageWithURL:[NSURL URLWithString:_model.url]];
        
        imageView.contentMode = UIViewContentModeScaleAspectFill;
        
        _titlelabel = [[UILabel alloc] initWithFrame:CGRectMake(47, 335, 280, 76)];
        
        _titlelabel.text = _model.title;
        
        _titlelabel.textColor = [UIColor whiteColor];
        
        _titlelabel.textAlignment = NSTextAlignmentCenter;
        
        _titlelabel.numberOfLines = 0;
        
        _titlelabel.font = [UIFont systemFontOfSize:16];
        
        [self.contentView addSubview:_titlelabel];
        
        _pos_strLabel = [[UILabel alloc] initWithFrame:CGRectMake(37, 390, 300, 21)];
        
        _pos_strLabel.text = _model.pos_str;
        
        _pos_strLabel.textAlignment = NSTextAlignmentCenter;
        
        _pos_strLabel.font = [UIFont systemFontOfSize:12];
        
        [self.contentView addSubview:_pos_strLabel];
        
        _pos_strLabel.textColor = [UIColor whiteColor];
        
        _labelString = [NSString stringWithFormat:@"%@",_model.time_str];
        
        NSDictionary *dic = @{NSFontAttributeName:[UIFont systemFontOfSize:13]};
        
        CGSize size = [_labelString boundingRectWithSize:CGSizeMake(100, 30) options:NSStringDrawingUsesLineFragmentOrigin attributes:dic context:nil].size;
        
        _labelBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake((KWidth - size.width) / 2, 415, size.width, size.height)];
        
        _labelBgImage = [UIImage imageNamed:@"FlexibleRectangle-White@3x"];
        
        _labelBgImage = [_labelBgImage stretchableImageWithLeftCapWidth:10 topCapHeight:10];
        
        _labelBgImageView.image = _labelBgImage;
        
        _labelBgText = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, _labelBgImageView.frame.size.width, _labelBgImageView.frame.size.height)];
        
        _labelBgText.text = _labelString;
        
        [_labelBgImageView addSubview:_labelBgText];
        
        _labelBgText.textColor = [UIColor blackColor];
        _labelBgText.font = [UIFont systemFontOfSize:8];
        _labelBgText.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_labelBgImageView];
        
    }

}

@end
