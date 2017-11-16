//
//  Helper.h
//  XingYuan
//
//  Created by YunKuai on 2017/9/28.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <math.h>
@interface Helper : NSObject
//获取单例
+ (instancetype)shareInstance;

//对基本参数字典进行处理（如添加字段、整体加密等等）
+ (NSDictionary *)parametersWith:(NSDictionary *)dict;

//存储memberId
+ (void)saveMemberId:(NSNumber *)memberId;

//获取memberId
+ (NSNumber *)memberId;

//存储账号
+ (void)saveAccount:(NSString *)account;

//获取账号
+ (NSString *)account;

//存储密码
+ (void)savePassword:(NSString *)password;

//获取密码
+ (NSString *)password;

//检测密码格式是否正确
+ (BOOL)isValidPassword:(NSString *)password;

//检测手机号码格式是否正确
+ (BOOL)isValidPhoneNum:(NSString *)phoneNum;

//返回randomnumber、timestamp、sign三个参数
+ (NSDictionary *)fixedParameters;

//使获取验证码button在一段时间内不可操作
- (void)makeBtnCannotBeHandleWith:(UIButton *)button;

//进入主界面
+ (void)setupMainViewController;

//退出登录
+ (void)logOut;

/**
 显示一个警告框

 @param message 警告信息
 @param completion 点击确定后的操作
 */
+ (void)showAlertControllerWithMessage:(NSString *)message completion:(void(^)(void))completion;


/**
 显示一个操作提示框


 */
+ (void)showAlertControllerTitle:(NSString *)title Message:(NSString *)message completion:(void(^)(void))completion;

/**
 从storyboard中获取一个Controller
 
 @param storyBoardName storyboard名字
 @param identifier Controller的Id
 @return Controller
 */
+ (UIViewController *)getViewControllerFromStoryBoard:(NSString *)storyBoardName identifier:(NSString *)identifier;


/**
 当设计图给的以plus系列（屏幕宽度414如，6plus、6splus、7plus）为标准时的字体大小
 
 @param plusFont 设计图给的字体大小
 @return 适配字体
 */
+ (UIFont *)adaptiveFontWithPlusFont:(int)plusFont;


/**
 当设计图给的以S系列（屏幕宽度375如，6、6s、7）为标准时的字体大小
 
 @param sFont 设计图给的字体大小
 @return 适配字体
 */
+ (UIFont *)adaptiveFontWithSFont:(int)sFont;


@end
