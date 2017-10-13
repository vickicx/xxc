//
//  BaseViewController.m
//  Installment Pai
//
//  Created by 卢佳威 on 16/7/19.
//  Copyright © 2016年 卢佳威. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
//    // 创建一个高20的假状态栏
//    UIView *statusBarView = [[UIView alloc] initWithFrame:CGRectMake(0, -20, self.view.bounds.size.width, 20)];
//    statusBarView.backgroundColor = [UIColor whiteColor];
//    [self.navigationController.navigationBar addSubview:statusBarView];
//    
//    /** 导航栏背景 */
//    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"圆角矩形-1---Assistor"] forBarPosition:UIBarPositionAny barMetrics:UIBarMetricsDefault];
//    [self.navigationController.navigationBar setShadowImage:[[UIImage alloc] init]];
    
//        * 设置导航栏标题颜色
    //        * 设置导航栏标题颜色
//    [self.navigationController.navigationBar setTitleTextAttributes:
//     
//     @{NSFontAttributeName:CHINESE_SYSTEM(16),NSForegroundColorAttributeName:MainColor}];
//    
//    [self.navigationController.navigationBar setTintColor:MainColor];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
