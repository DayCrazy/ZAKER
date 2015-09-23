//
//  IssueTableView.h
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/31.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IssueModel.h"
#import "IssueTableViewCell.h"

@interface IssueTableView : UITableView <UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSArray *issueModelArray;

@end
