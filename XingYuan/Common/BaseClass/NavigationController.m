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
    UIFont *font = FONT_WITH_S(18);
    NSDictionary *dic = @{NSFontAttributeName:font};
    self.navigationBar.titleTextAttributes =dic;
}

- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated{
    viewController.hidesBottomBarWhenPushed = false;
    if (self.viewControllers.count > 0){
        //push时隐藏tabbar
        viewController.hidesBottomBarWhenPushed = true;
        //替换ViewController的导航栏返回按钮
        UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        backBtn.contentMode = UIViewContentModeLeft;
        [backBtn setImage:[UIImage imageNamed:@"back-拷贝-2"] forState:UIControlStateNormal];
        backBtn.frame = CGRectMake(0, 0, 40, 20);
        [backBtn sizeToFit];
        [backBtn addTarget:self action:@selector(dealTapBack) forControlEvents:UIControlEventTouchUpInside];
        viewController.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    }
    [super pushViewController:viewController animated:true];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

- (void)dealTapBack{
    [self popViewControllerAnimated:true];
}

//// MARK: - 返回一个渐变色图片
//func getNavBackImg()->UIImage{
//    let layer = CAGradientLayer()
//    let frame = CGRect.init(x: 0, y: 0, width: SCREEN_WIDTH, height: 64)
//    layer.frame = frame
//    layer.colors = [RGBA(r: 17, g: 60, b: 142, a: 1).cgColor, RGBA(r: 72, g: 156, b: 222, a: 1).cgColor]
//    layer.locations = [0.0, 1]
//    layer.startPoint = CGPoint.init(x: 0, y: 0)
//    layer.endPoint = CGPoint.init(x: 1, y: 1)
//    
//    let viewForImg = UIView.init(frame: frame)
//    viewForImg.layer.addSublayer(layer)
//    
//    UIGraphicsBeginImageContextWithOptions(frame.size, false, 1)
//    viewForImg.layer.render(in: UIGraphicsGetCurrentContext()!)
//    let img = UIGraphicsGetImageFromCurrentImageContext()
//    UIGraphicsEndImageContext()
//    return img!
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
