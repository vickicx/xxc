//
//  Helper.m
//  XingYuan
//
//  Created by YunKuai on 2017/9/28.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "Helper.h"
#import "NTESLoginManager.h"
#import "NTESService.h"
#import "LoginRegisterController.h"
#import "TabBarController.h"

@interface Helper ()

@property (nonatomic,retain) NSTimer *timer;
@property (nonatomic,assign) int time;

@end

@implementation Helper
+ (instancetype)shareInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}

+ (NSDictionary *)parametersWith:(NSDictionary *)dict{
    NSMutableDictionary *body = [[NSMutableDictionary alloc] initWithDictionary:dict];
    //为参数体添加公共参数
    if ([body valueForKey:@"memberid"] == nil){
        [body setValue:[Helper memberId] forKey:@"memberid"];
    }
    [body setValue:@"devicecode" forKey:@"devicecode"];
    //将参数体转为Json字符串
    NSString *dataString = [body mj_JSONString];
    //重新包装参数体
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:dataString forKey:@"data"];
    return parameters;
}

//存储memberId
+ (void)saveMemberId:(NSNumber *)memberId{
    [[NSUserDefaults standardUserDefaults] setValue:memberId forKey:@"memberId"];
}

//获取memberId
+ (NSNumber *)memberId{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"memberId"];
}

//存储账号
+ (void)saveAccount:(NSString *)account{
    [[NSUserDefaults standardUserDefaults] setValue:account forKey:@"account"];
}

//获取账号
+ (NSString *)account{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"account"];
}

//存储密码
+ (void)savePassword:(NSString *)password{
     [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"password"];
}

//获取密码
+ (NSString *)password{
    return [[NSUserDefaults standardUserDefaults] valueForKey:@"password"];
}

//获取时间戳
+ (NSString *)timeStamp{
    NSDate *datenow =[NSDate date];//现在时间
    NSTimeZone *zone = [NSTimeZone systemTimeZone];
    NSInteger interval = [zone secondsFromGMTForDate:datenow];
    NSDate *localeDate = [datenow  dateByAddingTimeInterval: interval];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localeDate timeIntervalSince1970]];

    return timeSp;
}

//获取100-999整随机数
+ (NSNumber *)randomnumber{
    NSNumber *value = [[NSNumber alloc] initWithInt:arc4random()%999];
    if (value < @100){value = @100;}
    return value;
}

//获取签名
+ (NSString *)sign{
    //暂未做
    return @"";
}

//获取验证码按钮倒计时
- (void)makeBtnCannotBeHandleWith:(UIButton *)button{
    [button setUserInteractionEnabled:false];
    self.time = 10;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
        [button setTitle:[NSString stringWithFormat:@"%d秒后再试",self.time] forState:UIControlStateNormal];
        self.time -= 1;
        if (self.time == 0){
            [button setUserInteractionEnabled:true];
            [button setTitle:@"获取验证码" forState:UIControlStateNormal];
            [self.timer invalidate];
            self.timer = nil;
        }
    }];
}

//进入主界面
+ (void)setupMainViewController{
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    keyWindow.rootViewController = [[TabBarController alloc] init];
}

//退出登录
+ (void)logOut{
    [[NTESLoginManager sharedManager] setCurrentLoginData:nil];
    [[NTESServiceManager sharedManager] destory];
    
    UIWindow *keyWindow = [[UIApplication sharedApplication] keyWindow];
    [keyWindow.rootViewController dismissViewControllerAnimated:true completion:nil];
    LoginRegisterController *loginRegisterController = [[LoginRegisterController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginRegisterController];
    keyWindow.rootViewController = nav;
}

/**
 显示一个警告框
 
 @param message 警告信息
 @param completion 点击确定后的操作
 */
+ (void)showAlertControllerWithMessage:(NSString *)message completion:(void(^)(void))completion{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"警告" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if(completion != nil){
            completion();
        }
    }];
    [alertVC addAction:actionOK];
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertVC animated:YES completion:nil];
}

+ (void)showAlertControllerTitle:(NSString *)title Message:(NSString *)message completion:(void(^)(void))completion{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:title message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        if(completion != nil){
            completion();
        }
    }];
    [alertVC addAction:actionOK];
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertVC animated:YES completion:nil];
}

/**
 从storyboard中获取一个Controller

 @param storyBoardName storyboard名字
 @param identifier Controller的Id
 @return Controller
 */
+ (UIViewController *)getViewControllerFromStoryBoard:(NSString *)storyBoardName identifier:(NSString *)identifier{
    return [[UIStoryboard storyboardWithName:storyBoardName bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:identifier];
}

//设备            屏幕尺寸        分辨率（pt）	Reader	分辨率（px）	渲染后         PPI
//iPhone 3GS        3.5吋        320x480     @1x     320x480                     163
//iPhone 4/4s       3.5吋        320x480     @2x     640x960                     330
//iPhone 5/5s/5c	4.0吋        320x568     @2x     640x1136                    326
//iPhone 6          4.7吋        375x667     @2x     750x1334                    326
//iPhone 6Plus      5.5吋        414x736     @3x     1242x2208	1080x1920        401
//iPhone 6s         4.7吋        375x667     @2x     750x1334		326
//iPhone 6sPlus     5.5吋        414x736     @3x     1242x2208	1080x1920        401
//iPhone 7          4.7吋        375x667     @2x     750x1334		326
//iPhone 7Plus      5.5吋        414x736     @3x     1242x2208	1080x1920        401
//iPhone 8          5.5吋        414x736     @3x     1242x2208	1080x1920        401

//
/**
 当设计图给的以plus系列（屏幕宽度414如，6plus、6splus、7plus）为标准时的字体大小

 @param plusFont 设计图给的字体大小
 @return 适配字体
 */
+ (UIFont *)adaptiveFontWithPlusFont:(int)plusFont{
    if(SCREEN_WIDTH == 375){
        return [UIFont systemFontOfSize:(375.0/414)*plusFont];
    }
    if (SCREEN_WIDTH == 320){
        return [UIFont systemFontOfSize:(320.0/414)*plusFont];
    }
    return [UIFont systemFontOfSize:plusFont];
}


/**
 当设计图给的以S系列（屏幕宽度375如，6、6s、7）为标准时的字体大小

 @param sFont 设计图给的字体大小
 @return 适配字体
 */
+ (UIFont *)adaptiveFontWithSFont:(int)sFont{
    if(SCREEN_WIDTH == 414){
        return [UIFont systemFontOfSize:(414.0/375.0)*sFont];
    }
    if(SCREEN_WIDTH == 320){
        return [UIFont systemFontOfSize:(320.0/375.0)*sFont];
    }
    return [UIFont systemFontOfSize:sFont];
}
@end
