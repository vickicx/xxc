//
//  GeneralSettingsViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/17.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "GeneralSettingsViewController.h"
#import "SettingOneTableViewCell.h"
#import "SettingTwoTableViewCell.h"
#import "FeedBackViewController.h"
#import "AccountProtectionViewController.h"
#import "ModifyPasswordController.h"
#import "ChangePhoneNumberViewController.h"
#import "LoginRegisterController.h"

@interface GeneralSettingsViewController ()<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,strong) UITableView *tableView;
@property (nonatomic,strong) UIButton *logoutButton;
@property (nonatomic,copy) NSArray *titleArr;
@end

@implementation GeneralSettingsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通用设置";
    self.titleArr = @[@"账户保护", @"更换手机号", @"修改密码", @"清空缓存", @"关于星缘", @"意见反馈", @"网络诊断"];
    [self createTableView];
    // Do any additional setup after loading the view.
}

//创建TableView
-(void)createTableView{
    if (!_tableView) {
        _tableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, kWIDTH, kHEIGHT-64*FitHeight - 49*FitHeight) style:UITableViewStylePlain];
        _tableView.backgroundColor=[UIColor clearColor];
        _tableView.showsVerticalScrollIndicator=NO;
        _tableView.dataSource=self;
        _tableView.delegate=self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _tableView.scrollEnabled = NO;
        _tableView.tableFooterView = [[UIView alloc] init];
        [_tableView registerNib:[UINib nibWithNibName:@"SettingOneTableViewCell" bundle:nil] forCellReuseIdentifier:@"SettingOneTableViewCell"];
         [_tableView registerNib:[UINib nibWithNibName:@"SettingTwoTableViewCell" bundle:nil] forCellReuseIdentifier:@"SettingTwoTableViewCell"];
        
        [self.view addSubview:_tableView];
    }
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 429*FitHeight, kWIDTH, 290*FitHeight)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:view];
    
    self.logoutButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.logoutButton.frame = CGRectMake(12*FitWidth,450*FitHeight,kWIDTH - 24*FitWidth, 48*FitHeight);
    self.logoutButton.layer.cornerRadius = 10.0f;
    [self.logoutButton setTitle:@"退出登录" forState:UIControlStateNormal];
    [self.logoutButton addTarget:self action:@selector(signOut) forControlEvents:UIControlEventTouchUpInside];
    self.logoutButton.titleLabel.font = FONT_WITH_S(18);
    self.logoutButton.tintColor = [UIColor whiteColor];
    self.logoutButton.backgroundColor = RGBColor(240, 53, 90, 1);
    
    [self.view addSubview:self.logoutButton];
   
}

- (void)signOut{
    //成功后直接进入主界面？
    [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:nil];
    LoginRegisterController *loginRegisterController = [[LoginRegisterController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginRegisterController];
    [[UIApplication sharedApplication] keyWindow].rootViewController = nav;
}

#pragma mark ---- UITableViewDelegate ----

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}
//显示每组的头部

-(UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 10*FitHeight)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}

//显示每组的尾部

-(UIView*)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kWIDTH, 15*FitHeight)];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    return view;
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 10*FitHeight;
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForFooterInSection:(NSInteger)section {
    return 15*FitHeight;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 45*FitHeight;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return 3;
    }
        return 4;
    
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SettingOneTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SettingOneTableViewCell"];

    SettingTwoTableViewCell *cell1 = [tableView dequeueReusableCellWithIdentifier:@"SettingTwoTableViewCell"];
    if (indexPath.section == 0) {
        cell.title.text = self.titleArr[indexPath.row];
        if(indexPath.row == 2){
            cell1.title.text = self.titleArr[indexPath.row];
            cell1.text.text = @"当前密码风险较高";
            return cell1;
        }
    }else if (indexPath.section == 1){
        cell.title.text = self.titleArr[indexPath.row + 3];
        if (indexPath.row == 0) {
            cell1.title.text = self.titleArr[indexPath.row + 3];
            //获取完整路径
            NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
            path = [path stringByAppendingPathComponent:@"Caches"];
            NSString *text = [NSString stringWithFormat:@"%.2fM",[self folderSizeAtPath:path]];
            cell1.text.text = text;
            [cell1.text setTextColor:RGBColor(32, 33, 34, 1)];
            return cell1;
        }
    }
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //cell被点击恢复
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            AccountProtectionViewController *AccountVC = [[AccountProtectionViewController alloc] init];
            [self.navigationController pushViewController:AccountVC animated:YES];
            
        }else if (indexPath.row == 1) {
            //更换手机号
            ChangePhoneNumberViewController *changeVC = [[ChangePhoneNumberViewController alloc] init];
            [self.navigationController pushViewController:changeVC animated:YES];
        }else if (indexPath.row == 2) {
            //修改密码
            ModifyPasswordController *modefyVC = [[ModifyPasswordController alloc] init];
            [self.navigationController pushViewController:modefyVC animated:YES];
        }
        
    }else if (indexPath.section == 1) {
        if (indexPath.row == 0) {
            [self ClearDidPress:indexPath];
            
        }else if (indexPath.row == 2) {
            FeedBackViewController *feedBackVC = [[FeedBackViewController alloc] init];
            [self.navigationController pushViewController:feedBackVC animated:YES];
        }
        
    }
    
}

#pragma mark - 清理缓存

-(void)ClearDidPress:(NSIndexPath *) indexPath {
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"清理缓存" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self cleanAction];
        [self.tableView reloadData];
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:nil]];
    [self presentViewController:alert animated:YES completion:nil];
    
}

#pragma mark - 清空
-(void)cleanAction
{
    //获取完整路径
    NSString *path = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES).lastObject;
    path = [path stringByAppendingPathComponent:@"Caches"];
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        NSArray *fileNameAarray = [manager subpathsAtPath:path];
        for (NSString *fileName in fileNameAarray) {
            //拼接绝对路径
            NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
            
            //通过文件管理者删除文件
            [manager removeItemAtPath:absolutePath error:nil];
        }
    }
}

#pragma mark - 计算单个文件大小的方法
-(long long)fileSizeAtPath:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:path]) {
        return [[manager attributesOfItemAtPath:path error:nil]fileSize];
    }
    return 0;
}

#pragma mark - 计算一个文件夹的大小
-(float)folderSizeAtPath:(NSString *)path
{
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:path]) {
        return 0;
    }
    //根据路径获取文件夹里面元素集合
    //获取集合类型的枚举类型
    NSEnumerator *enumeratot = [[manager subpathsAtPath:path] objectEnumerator];
    //每次遍历得到的文件名
    //文件夹的大小
    NSString *fileName = [NSString string];
    float folderSize = 0;
    while ((fileName = [enumeratot nextObject])!= nil) {
        NSString *absolutePath = [path stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:absolutePath];
    }
    return folderSize/(1024*1024.0);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
