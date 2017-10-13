//
//  JGProgressHUD+Show.h
//  XingYuan
//
//  Created by YunKuai on 2017/9/29.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <JGProgressHUD/JGProgressHUD.h>
#import "BaseModel.h"

@interface JGProgressHUD (Show)
//根据模型显示成功信息
+ (void)showSuccessWithModel:(BaseModel *)baseModel In:(UIView *)view;

//根据模型显示错误信息
+ (void)showErrorWithModel:(BaseModel *)baseModel In:(UIView *)view;

//根据模型自动判断显示成功还是显示错误
+ (void)showResultWithModel:(BaseModel *)baseModel In:(UIView *)view;

//显示错误信息
+ (void)showErrorWith:(NSString *)errorMsg In:(UIView *)view;

//显示正确信息
+ (void)showSuccessWith:(NSString *)successMsg In:(UIView *)view;

//显示状态（转圈圈）
+ (void)showStatusWith:(NSString *)msg In:(UIView *)view;

//隐藏
+ (void)dissmiss;
@end
