//
//  NobodyLikeMeViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/18.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "NobodyLikeMeViewController.h"

@interface NobodyLikeMeViewController ()

@end

@implementation NobodyLikeMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"喜欢我的";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"喜欢我的";
    label.font = FONT_WITH_S(18);
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:label1];
    self.navigationItem.rightBarButtonItem = itme;
    self.navigationItem.titleView = label;
    // Do any additional setup after loading the view from its nib.
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
