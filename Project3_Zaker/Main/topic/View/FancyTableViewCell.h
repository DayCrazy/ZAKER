//
//  FancyTableViewCell.h
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/12.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "FancyBaseTableViewCell.h"
#import "TopicFancyModel.h"

@interface FancyTableViewCell : FancyBaseTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UIImageView *contentImageView;

@property (nonatomic,strong) TopicFancyModel *model;

@end
