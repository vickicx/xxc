//
//  FinishCertificationViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/16.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "FinishCertificationViewController.h"
#import "MyAttestationViewController.h"

@interface FinishCertificationViewController ()

@end

@implementation FinishCertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //替换ViewController的导航栏返回按钮
            UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
            [backBtn setImage:[UIImage imageNamed:@"back-拷贝-2"] forState:UIControlStateNormal];
            backBtn.frame = CGRectMake(0, 0, 40, 20);
            backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 20);
            [backBtn sizeToFit];
            [backBtn addTarget:self action:@selector(dealTapBack) forControlEvents:UIControlEventTouchUpInside];
            self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    // Do any additional setup after loading the view from its nib.
}

- (void)dealTapBack{
    MyAttestationViewController *VC = [MyAttestationViewController new];
    [self.navigationController popToViewController:VC animated:YES];
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
