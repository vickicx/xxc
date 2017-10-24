//
//  CertificationViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/16.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "CertificationViewController.h"
#import "FinishCertificationViewController.h"


@interface CertificationViewController ()

@end

@implementation CertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"实名认证";
    [self createView];
    // Do any additional setup after loading the view from its nib.
}

- (void)createView {
    self.label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.label.textColor = RGBColor(184, 186, 189, 1);
    
    self.name.textColor = RGBColor(43, 48, 52, 1);
    self.line.backgroundColor = self.line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.button.backgroundColor = RGBColor(240, 53, 99, 1);
    self.button.layer.cornerRadius = 10.0f;
    [self.button addTarget:self action:@selector(buttonDidSelect:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonDidSelect:(UIButton *)button {
    FinishCertificationViewController *finishVC = [[FinishCertificationViewController alloc] init];
    [self.navigationController pushViewController:finishVC animated:YES];
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
