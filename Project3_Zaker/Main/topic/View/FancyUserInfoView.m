//
//  FancyUserInfoView.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/12.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "FancyUserInfoView.h"
#import "UIImageView+WebCache.h"

@implementation FancyUserInfoView
{
    UIImageView *_userImageView;
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        [self _createSubviews];
    }
    return self;
}

- (void)setModel:(TopicFancyModel *)model
{
    if (model != nil)
    {
        _model = model;
        [self setNeedsLayout];
    }
}

- (void)_createSubviews
{
    _userImageView = [[UIImageView alloc] initWithFrame:CGRectZero];
    
    [self addSubview:_userImageView];
}

- (void)layoutSubviews
{
    _userNameLabel.text = _model.name;
    
    if (_model.discussion_title != nil)
    {
        _tagLabel.text = [NSString stringWithFormat:@"#%@",_model.discussion_title];

    }
    
    _userImageView.frame = CGRectMake(15, 15, 40, 40);
    
    [_userImageView sd_setImageWithURL:[NSURL URLWithString:_model.icon]];
    
    _userImageView.layer.cornerRadius = 20;
    
    _userImageView.layer.masksToBounds = YES;
}

@end
