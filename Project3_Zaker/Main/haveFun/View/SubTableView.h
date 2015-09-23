//
//  SubTableView.h
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/26.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SubTableView : UITableView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *dataArray;

@property (nonatomic,assign) NSInteger selectIndex;

@end
