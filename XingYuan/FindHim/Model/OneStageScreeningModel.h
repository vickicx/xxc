//
//  OneStageScreeningModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/19.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"

@interface OneStageScreeningModel : BaseModel
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *stature;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *constellation;
@property (nonatomic,copy) NSString *physique;
@property (nonatomic,copy) NSString *facialfeatures;

@property (nonatomic,copy) NSString *birthday;
@property (nonatomic,copy) NSString *age;
@end
