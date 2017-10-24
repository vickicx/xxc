//
//  FourStageScreeningModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/20.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"

@interface FourStageScreeningModel : BaseModel
@property (nonatomic,copy) NSString *hometown; //家乡
@property (nonatomic,copy) NSString *householdregister; // 户口
@property (nonatomic,copy) NSString *nation; // 民族
@property (nonatomic,copy) NSString *sx; // 属相
@property (nonatomic,copy) NSString *familyranking; // 家庭排行
@property (nonatomic,copy) NSString *parentstatus; // 父母情况
@property (nonatomic,copy) NSString *fatherwork; // 父亲工作
@property (nonatomic,copy) NSString *motherwork; // 母亲工作
@property (nonatomic,copy) NSString *parenteconomic; // 父母经济
@property (nonatomic,copy) NSString *parentmedicalinsurance; // 父母医保
@end
