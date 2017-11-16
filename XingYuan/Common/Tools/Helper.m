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
#import "AppUntils.h"
#import <CommonCrypto/CommonDigest.h>
#import "NSString+Encryption.h"

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
    
    NSString *deviceCode = [AppUntils readUUIDFromKeyChain];
    if(deviceCode == nil){
        [AppUntils saveUUIDToKeyChain];
        deviceCode = [AppUntils readUUIDFromKeyChain];
    }
    [body setValue:deviceCode forKey:@"devicecode"];
    
    NSDictionary *fixedParameters = [Helper fixedParameters];
    [body setValue:[fixedParameters valueForKey:@"randomnumber"] forKey:@"randomnumber"];
    [body setValue:[fixedParameters valueForKey:@"timestamp"] forKey:@"timestamp"];
    [body setValue:[fixedParameters valueForKey:@"sign"] forKey:@"sign"];
    
    //将参数体转为Json字符串
    NSString *dataString = [body mj_JSONString];
    
    //对dataString进行加密
    NSString *encryptKey =@"helloQX7";
    NSString *encryptString = [dataString desEncryptWithKey:encryptKey];
    
    //重新包装参数体
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:encryptString forKey:@"data"];
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

//检测密码格式是否正确
+ (BOOL)isValidPassword:(NSString *)password{
    NSString *passWordRegex = @"^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,18}$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:password];
}

//检测手机号码格式是否正确
+ (BOOL)isValidPhoneNum:(NSString *)phoneNum{
    //手机号以13， 15，18开头，八个 \d 数字字符
    NSString *phoneRegex = @"^1(3|4|5|7|8)\\d{9}$";
    NSPredicate *phoneTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",phoneRegex];
    return [phoneTest evaluateWithObject:phoneNum];
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

//返回randomnumber、timestamp、sign三个参数
+ (NSDictionary *)fixedParameters{
    NSMutableDictionary *dic = [NSMutableDictionary new];
    NSNumber *randomnumber = [Helper randomnumber];
    NSString *timeStamp = [Helper timeStamp];
    NSString *signdValidateKey = @"x2017y^_=+hello+_world";
    NSString *sign = [Helper md5DigestWithString:[NSString stringWithFormat:@"%@%@%@",timeStamp,randomnumber,signdValidateKey]];
    
    [dic setValue:randomnumber forKey:@"randomnumber"];
    [dic setValue:timeStamp forKey:@"timestamp"];
    [dic setValue:sign forKey:@"sign"];
    return dic;
}

//返回md5加密字符串
+(NSString *)md5DigestWithString:(NSString*)input{
    const char* str = [input UTF8String];
    unsigned char result[16];
    CC_MD5(str, (uint32_t)strlen(str), result);
    NSMutableString *ret = [NSMutableString stringWithCapacity:16 * 2];
    for(int i = 0; i<16; i++) {
        [ret appendFormat:@"%02x",(unsigned int)(result[i])];
    }
    return ret;
}

//获取验证码按钮倒计时
- (void)makeBtnCannotBeHandleWith:(UIButton *)button{
    [button setUserInteractionEnabled:false];
    [button setTitleColor:RGBColor(190, 195, 199, 1) forState:UIControlStateNormal];
    button.layer.borderColor = RGBColor(190, 195, 199, 1).CGColor;
    self.time = 10;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:true block:^(NSTimer * _Nonnull timer) {
        [button setTitle:[NSString stringWithFormat:@"%d秒后再试",self.time] forState:UIControlStateNormal];
        self.time -= 1;
        if (self.time == 0){
            [button setUserInteractionEnabled:true];
            [button setTitleColor:APP_THEME_COLOR forState:UIControlStateNormal];
            button.layer.borderColor = APP_THEME_COLOR.CGColor;
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
