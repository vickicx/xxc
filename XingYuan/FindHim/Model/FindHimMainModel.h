//
//  FindHimMainModel.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/24.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"

@interface FindHimMainModel : BaseModel
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *sex;
@property (nonatomic,copy) NSString *age;
@property (nonatomic,copy) NSString *stature; //身高
@property (nonatomic,copy) NSString *constellation;  //星座
@property (nonatomic,copy) NSString *work;
@property (nonatomic,copy) NSString *summary;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSString *distance; //距离 km
@property (nonatomic,copy) NSString *matchvalue;  // 匹配值
@property (nonatomic,copy) NSString *nid;
@property (nonatomic,strong) NSMutableArray *pictureArr;
@end
