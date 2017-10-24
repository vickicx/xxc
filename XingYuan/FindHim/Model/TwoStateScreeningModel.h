//
//  TwoStateScreeningModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/19.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"

@interface TwoStateScreeningModel : BaseModel
@property (nonatomic,copy) NSString *interestids; //兴趣爱好，格式：“1，2，3，4，5”
@property (nonatomic,copy) NSString *educational; // 个人学历
@property (nonatomic,copy) NSString *operatingpost; // 工作岗位
@property (nonatomic,copy) NSString *monthlyincome; // 月收入
@property (nonatomic,copy) NSString *maritalstatus; // 婚姻状态
@property (nonatomic,copy) NSString *children; // 子女情况
@property (nonatomic,copy) NSString *drink; // 是否喝酒
@property (nonatomic,copy) NSString *smoking; // 是否吸烟
@property (nonatomic,copy) NSString *housesstatus; // 购房情况
@property (nonatomic,copy) NSString *carstatus; // 购车情况
@property (nonatomic,copy) NSString *workandrest; // 生活作息
@end
