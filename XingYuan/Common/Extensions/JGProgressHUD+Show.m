//
//  JGProgressHUD+Show.m
//  XingYuan
//
//  Created by YunKuai on 2017/9/29.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "JGProgressHUD+Show.h"

@implementation JGProgressHUD (Show)
+ (void)showSuccessWithModel:(BaseModel *)baseModel In:(UIView *)view{
    if ([baseModel.code  isEqual: @1]){
        [JGProgressHUD showSuccessWith:baseModel.msg In:view];
        return;
    }
    [JGProgressHUD dissmiss];
}

+ (void)showErrorWithModel:(BaseModel *)baseModel In:(UIView *)view{
    if (![baseModel.code  isEqual: @1]){
        [JGProgressHUD showErrorWith:baseModel.msg In:view];
        return;
    }
    [JGProgressHUD dissmiss];
}

+ (void)showResultWithModel:(BaseModel *)baseModel In:(UIView *)view{
    if ([baseModel.code  isEqual: @1]){
        [JGProgressHUD showSuccessWith:baseModel.msg In:view];
        return;
    }else{
        [JGProgressHUD showErrorWith:baseModel.msg In:view];
        return;
    }
}

+ (void)showErrorWith:(NSString *)errorMsg In:(UIView *)view{
    [JGProgressHUD dissmiss];
    JGProgressHUDErrorIndicatorView *indicateorView = [[JGProgressHUDErrorIndicatorView alloc] initWithImage:[UIImage imageNamed:@""]];
    [JGProgressHUD showWith:errorMsg IndicatorView:indicateorView In:view];
}

+ (void)showSuccessWith:(NSString *)successMsg In:(UIView *)view{
    [JGProgressHUD dissmiss];
    JGProgressHUDSuccessIndicatorView *indicateorView = [[JGProgressHUDSuccessIndicatorView alloc] initWithImage:[UIImage imageNamed:@""]];
    [JGProgressHUD showWith:successMsg IndicatorView:indicateorView In:view];
}

+ (void)showStatusWith:(NSString *)msg In:(UIView *)view{
    [JGProgressHUD dissmiss];
    hud = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleLight];
    hud.textLabel.text = msg;
    [hud showInView:view];
    //[hud dismissAfterDelay:1.5];
}

+ (void)showWith:(NSString *)msg IndicatorView:(JGProgressHUDIndicatorView *)indicatorView In:(UIView *)view{
    hud = [[JGProgressHUD alloc] initWithStyle:JGProgressHUDStyleLight];
    hud.textLabel.text = msg;
    [hud setIndicatorView:indicatorView];
    [hud showInView:view];
    [hud dismissAfterDelay:1.5];
}

+ (void)dissmiss{
    [hud dismiss];
}
@end
