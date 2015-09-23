//
//  FancyBaseTableViewCell.h
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/12.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FancyUserInfoView.h"

@interface FancyBaseTableViewCell : UITableViewCell

- (void)_createUserInfoView;

@property (nonatomic,strong) FancyUserInfoView *userInfoView;

@end
