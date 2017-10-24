//
//  PhotoPreviewModel.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/23.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PictureModel.h"

@interface PhotoPreviewModel : BaseModel
@property (nonatomic,copy) NSString *nickname; //昵称
@property (nonatomic,copy) NSString *age; // 年龄
@property (nonatomic,copy) NSString *stature; // 身高
@property (nonatomic,copy) NSString *constellation; // 星座
@property (nonatomic,copy) NSString *work; // 工作
@property (nonatomic,copy) NSString *address; // 地区
@property (nonatomic,copy) NSString *sex; // 性别
@property (nonatomic,copy) NSString *summary; // 介绍
@property (nonatomic,copy) NSMutableArray *pictureModelArr; // 照片
@end
