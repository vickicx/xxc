//
//  FindHimMainModel.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/24.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"

@interface FindHimMainModel : BaseModel
@property (nonatomic,copy) NSString *Nickname;
@property (nonatomic,copy) NSString *Sex;
@property (nonatomic,copy) NSString *Age;
@property (nonatomic,copy) NSString *Stature; //身高
@property (nonatomic,copy) NSString *Constellation;  //星座
@property (nonatomic,copy) NSString *Work;
@property (nonatomic,copy) NSString *Summary;
@property (nonatomic,copy) NSString *Address;
@property (nonatomic,copy) NSString *Distance; //距离 km
@property (nonatomic,copy) NSString *Matchvalue;  // 匹配值
@property (nonatomic,copy) NSString *nid;
@property (nonatomic,copy) NSMutableArray *picture;
@end
