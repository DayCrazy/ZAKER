//
//  HaveFunCell.h
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/27.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HaveFunModel.h"

@interface HaveFunCell : UITableViewCell

@property (nonatomic,strong) HaveFunModel *model;

@property (nonatomic,assign) NSInteger selectIndex;

@end
