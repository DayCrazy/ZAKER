//
//  MyAccountTableViewController.m
//  Project3_Zaker
//
//  Created by 黄珂耀 on 15/8/27.
//  Copyright (c) 2015年 黄珂耀. All rights reserved.
//

#import "MyAccountTableViewController.h"
#import "MyAccountCell.h"
#import "ThemeManager.h"
#import "SettingViewController.h"
#import "LoginViewController.h"
#import "LoginViewController.h"

#define ReuseID @"myAccountCell"

@interface MyAccountTableViewController ()

@end

@implementation MyAccountTableViewController
{
    UIView *_accountView;
    
    UIButton *_accountButton;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:kThemeDidChangeNotification object:nil];
}

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        self.title = @"我的";
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(themeChange:) name:kThemeDidChangeNotification object:nil];
        
        self.hidesBottomBarWhenPushed = YES;
        
        [self _createSubviews];
        
        [self _createLeftBarButton];
    }
    return self;
}

- (void)themeChange:(NSNotification *)notification
{
    _accountView.backgroundColor = [[ThemeManager shareInstance] getThemeColorWithColorName:[[NSUserDefaults standardUserDefaults]objectForKey:kThemeName]];
}

- (void)_createLeftBarButton
{
    UIButton *leftButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 20, 20)];
    
    [leftButton setImage:[UIImage imageNamed:@"back_jiantou"] forState:UIControlStateNormal];
    
    [leftButton addTarget:self action:@selector(leftButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:leftButton];
}

- (void)leftButtonAction:(UIButton *)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}


- (void)_createSubviews
{
    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStyleGrouped];
    
    self.tableView.backgroundColor = [UIColor colorWithWhite:0.965 alpha:1.000];
    
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[MyAccountCell class] forCellReuseIdentifier:ReuseID];
    
    _accountView = [[UIView alloc] initWithFrame:CGRectMake(0, -300, KWidth, 464)];
    
    _accountView.backgroundColor = [[ThemeManager shareInstance] getThemeColorWithColorName:[[NSUserDefaults standardUserDefaults]objectForKey:kThemeName]];
    
    [self.tableView addSubview:_accountView];
    
    [self _createAccountButton];
}

- (void)_createAccountButton
{
    _accountButton = [[UIButton alloc] initWithFrame:CGRectMake((KWidth - 130) / 2, 350, 130, 80)];
    
    UIImageView *accountBgImageView = [[UIImageView alloc] initWithFrame:CGRectMake(35, 0, 60, 60)];
    
    [accountBgImageView setImage:[UIImage imageNamed:@"account_yuan"]];
    
    UIImageView *accountImageView = [[UIImageView alloc] initWithFrame:CGRectMake(47.5, 20, 35, 35)];
    
    [accountImageView setImage:[UIImage imageNamed:@"account_touxiang"]];
    
    UILabel *loginLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 60, 130, 20)];
    
    loginLabel.text = @"登陆ZAKER体验更多功能";
    
    loginLabel.textColor = [UIColor whiteColor];
    
    loginLabel.font = [UIFont systemFontOfSize:10];
    
    loginLabel.textAlignment = NSTextAlignmentCenter;
    
    [_accountButton addSubview:accountBgImageView];
    
    [_accountButton addSubview:accountImageView];
    
    [_accountButton addSubview:loginLabel];
    
    [_accountButton addTarget:self action:@selector(accountButtonAction) forControlEvents:UIControlEventTouchUpInside];
    
    [_accountView addSubview:_accountButton];
    
}

- (void)accountButtonAction
{
    LoginViewController *vc = [[LoginViewController alloc] initWithNibName:@"LoginViewController" bundle:nil];
    
    [self.navigationController presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    // Return the number of sections.
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    // Return the number of rows in the section.
    if (section == 0)
    {
        return 10;
    }
    else if (section == 1)
    {
        return 4;
    }
    else
    {
        return 2;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0.1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {

    MyAccountCell *cell = [tableView dequeueReusableCellWithIdentifier:ReuseID forIndexPath:indexPath];
    
    if (indexPath.section == 0)
    {
        if (indexPath.row == 3)
        {
            cell.cellLabel.text = @"好友分享";
        }
        else if (indexPath.row == 4)
        {
            cell.cellLabel.text = @"我的消息";
        }
        else if (indexPath.row == 5)
        {
            cell.cellLabel.text = @"话题通知";
        }
        else if (indexPath.row == 6)
        {
            cell.cellLabel.text = @"我的玩乐";
        }
        else if (indexPath.row == 7)
        {
            cell.cellLabel.text = @"推送资讯";
        }
        else if (indexPath.row == 8)
        {
            cell.cellLabel.text = @"积分活动";
        }
        else if (indexPath.row == 9)
        {
            cell.cellLabel.text = @"我的收藏";
        }
    }
    else if (indexPath.section == 1)
    {
        if (indexPath.row == 0)
        {
            cell.cellLabel.text = @"离线阅读";
        }
        else if (indexPath.row == 1)
        {
            cell.cellLabel.text = @"清除缓存";
        }
        else if (indexPath.row == 2)
        {
            cell.cellLabel.text = @"夜间模式";
        }
        else if (indexPath.row == 3)
        {
            cell.cellLabel.text = @"更多设置";
        }
    }
    else if (indexPath.section == 2)
    {
        if (indexPath.row == 0)
        {
            cell.cellLabel.text = @"意见反馈";
        }
        else if (indexPath.row == 1)
        {
            cell.cellLabel.text = @"关于 ZAKER v6.2.1";
        }
    }
    
    if ((indexPath.section == 1 && (indexPath.row == 1 || indexPath.row == 2)) || (indexPath.section == 0 && indexPath.row == 3))
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    cell.backgroundColor = [UIColor whiteColor];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 1 && indexPath.row == 3)
    {
        SettingViewController *vc = [[SettingViewController alloc] init];
        
        [self.navigationController pushViewController:vc animated:YES];
    }
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
