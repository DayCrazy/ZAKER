//
//  FancyBaseTableViewCell.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/12.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "FancyBaseTableViewCell.h"

@implementation FancyBaseTableViewCell

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self)
    {
        self.backgroundColor = [UIColor colorWithWhite:0.957 alpha:1.000];
    }
    return self;
}

- (void)_createUserInfoView
{
    NSBundle *bundle = [NSBundle mainBundle];
    
    NSArray *detailArrays = [bundle loadNibNamed:@"FancyUserInfoView" owner:self options:nil];
    
    _userInfoView = [detailArrays lastObject];
    
    _userInfoView.frame = CGRectMake(0, 0, KWidth, 60);
    
    [self.contentView addSubview:_userInfoView];
}

@end
