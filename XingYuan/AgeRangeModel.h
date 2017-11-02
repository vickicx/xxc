//
//  AgeRangeModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/11/1.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AgeRangeModel : NSObject
@property (nonatomic,assign) NSInteger littleAge;   //左侧较小年龄
@property (nonatomic,strong) NSArray *biggeraAges;     //左侧较小年龄对应的右侧较大年龄选项
@end
