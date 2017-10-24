//
//  MyMateRequireModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/23.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"

@interface MyMateRequireModel : BaseModel
//年龄
@property (nonatomic,copy) NSString *age;
//身高
@property (nonatomic,copy) NSString *stature;
//月收入
@property (nonatomic,copy) NSString *monthlyincome;
//学历
@property (nonatomic,copy) NSString *educational;
//婚姻状态
@property (nonatomic,copy) NSString *maritalstatus;
//体型
@property (nonatomic,copy) NSString *physique;
//工作地区
@property (nonatomic,copy) NSString *nowaddress;
//是否想要孩子
@property (nonatomic,copy) NSString *wanthavechildren;
//是否抽烟
@property (nonatomic,copy) NSString *smoking;
//是否喝酒
@property (nonatomic,copy) NSString *drink;
//购房情况
@property (nonatomic,copy) NSString *housesstatus;
//购车情况
@property (nonatomic,copy) NSString *carstatus;

@end
