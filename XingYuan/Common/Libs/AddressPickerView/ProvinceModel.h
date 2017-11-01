//
//  ProvinceModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/31.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CityModel.h"

@interface ProvinceModel : NSObject
@property (nonatomic,strong) NSArray *city;
@property (nonatomic,copy) NSString *name;
@end
