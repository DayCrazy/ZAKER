//
//  IssueTableViewCellType2.h
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/11.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IssueModel.h"

@interface IssueTableViewCellType2 : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *issueTtileLabel;

@property (nonatomic,strong) IssueModel *model;

@end
