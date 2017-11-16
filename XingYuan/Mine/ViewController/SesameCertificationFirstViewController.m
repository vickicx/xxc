//
//  SesameCertificationFirstViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/16.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "SesameCertificationFirstViewController.h"
#import "SesameCertificationSecondViewController.h"

@interface SesameCertificationFirstViewController ()
@end
@implementation SesameCertificationFirstViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"芝麻认证";


    self.verificationCodeButton.titleLabel.font = FONT_WITH_S(14)
    [self.verificationCodeButton setTitleColor:APP_THEME_COLOR forState:UIControlStateNormal];
    self.verificationCodeButton.layer.borderWidth = 1;
    self.verificationCodeButton.layer.borderColor = APP_THEME_COLOR.CGColor;
    
    [self createView];
}


- (void)createView {
    self.label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.submitButton addTarget:self action:@selector(submitButtonDidSelect:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)submitButtonDidSelect:(UIButton *)button {
    SesameCertificationSecondViewController *secondVC = [[SesameCertificationSecondViewController alloc] init];
    [self.navigationController pushViewController:secondVC animated:YES];
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
