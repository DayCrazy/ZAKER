//
//  IssueTableViewCellType1.h
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/9/10.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IssueModel.h"

@interface IssueTableViewCellType1 : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *issueImageVIew1;
@property (weak, nonatomic) IBOutlet UIImageView *issueImageView2;
@property (weak, nonatomic) IBOutlet UIImageView *issueImageView3;
@property (weak, nonatomic) IBOutlet UILabel *issueTitleLabel;

@property (nonatomic,strong) IssueModel *model;

@end
