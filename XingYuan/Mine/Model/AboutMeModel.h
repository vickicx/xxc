//
//  AboutMeModel.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/20.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AboutMeModel : BaseModel
@property (nonatomic,copy) NSString *nickname; //昵称
@property (nonatomic,copy) NSString *age; // 年龄
@property (nonatomic,copy) NSString *stature; // 身高
@property (nonatomic,copy) NSString *constellation; // 星座
@property (nonatomic,copy) NSString *education; // 学历
@property (nonatomic,copy) NSString *address; // 地区
@property (nonatomic,copy) NSString *sex; // 性别
@property (nonatomic,copy) NSString *authenticationschedule; // 我的认证完成进度
@property (nonatomic,copy) NSString *memberinfoschedule; // 我的资料完成进度
@property (nonatomic,assign) BOOL online; // 是否在线

@end
