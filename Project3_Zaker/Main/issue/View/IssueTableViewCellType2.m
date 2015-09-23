//
//  IssueTableViewCellType2.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/11.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "IssueTableViewCellType2.h"

@implementation IssueTableViewCellType2

- (void)awakeFromNib {
    // Initialization code
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
    
    self.issueTtileLabel.text = _model.title;
    
}

@end
