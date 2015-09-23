//
//  FancyUserInfoView.h
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/12.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TopicFancyModel.h"

@interface FancyUserInfoView : UIView
@property (weak, nonatomic) IBOutlet UILabel *userNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *tagLabel;

@property (nonatomic,strong) TopicFancyModel *model;

@end
