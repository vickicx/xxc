//
//  PictureModel.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/23.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PictureModel : BaseModel

@property (nonatomic,copy) NSString *ids; //照片标示ID
@property (nonatomic,copy) NSString *pic; // 照片地址
@property (nonatomic,copy) NSString *sort; // 排序

@end
