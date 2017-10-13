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

//获取时间戳
+ (NSString *)timeStamp;

//获取100-999整随机数
+ (NSNumber *)randomnumber;

//获取签名
+ (NSString *)sign;

//使获取验证码button在一段时间内不可操作
- (void)makeBtnCannotBeHandleWith:(UIButton *)button;
@end
