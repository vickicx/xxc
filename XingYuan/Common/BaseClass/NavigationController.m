//
//  NavigationController.m
//  XingYuan
//
//  Created by YunKuai on 2017/9/28.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "NavigationController.h"

@interface NavigationController ()

@end

@implementation NavigationController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.navigationBar setTranslucent:true];
//    UIFont *font = FONT_WITH_S(18);
//    NSDictionary *dic = @{NSFontAttributeName:font};
//    [self.navigationBar setTitleTextAttributes:dic];
    
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed = false;
    if (self.viewControllers.count > 0){
        //push时隐藏tabbar
        viewController.hidesBottomBarWhenPushed = true;

        //替换ViewController的导航栏返回按钮
//        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
//        [backBtn setImage:[UIImage imageNamed:@"back-拷贝-2"] forState:UIControlStateNormal];
//        backBtn.frame = CGRectMake(0, 0, 40, 20);
//        backBtn.contentEdgeInsets = UIEdgeInsetsMake(0, -10, 0, 20);
//        [backBtn sizeToFit];
//        [backBtn addTarget:self action:@selector(dealTapBack) forControlEvents:UIControlEventTouchUpInside];
//        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
        
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
        label.text = viewController.title;
        label.font = FONT_WITH_S(18);
        label.textAlignment = NSTextAlignmentCenter;
//        UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
//        UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:label1];
//        self.navigationItem.rightBarButtonItem = itme;
        viewController.navigationItem.titleView = label;
        
    }
    [super pushViewController:viewController animated:true];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)dealTapBack{
    [self popViewControllerAnimated:true];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
