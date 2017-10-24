//
//  Helper.m
//  XingYuan
//
//  Created by YunKuai on 2017/9/28.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "Helper.h"
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

/**
 显示一个警告框
 
 @param message 警告信息
 @param completion 点击确定后的操作
 */
+ (void)showAlertControllerWithMessage:(NSString *)message completion:(void(^)(void))completion{
    UIAlertController *alertVC = [UIAlertController alertControllerWithTitle:@"警告" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *actionOK = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alertVC addAction:actionOK];
    [[[UIApplication sharedApplication] keyWindow].rootViewController presentViewController:alertVC animated:YES completion:completion];
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

+ (UIFont *)adaptiveFontWithPlusFont:(int)plusFont{
    if(SCREEN_WIDTH == 375){
        return [UIFont systemFontOfSize:(375.0/414)*plusFont];
    }
    if (SCREEN_WIDTH == 320){
        return [UIFont systemFontOfSize:(320.0/414)*plusFont];
    }
    return [UIFont systemFontOfSize:plusFont];
}
@end
