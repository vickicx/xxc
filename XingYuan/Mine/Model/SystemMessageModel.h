//
//  SystemMessageModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/11/1.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"

@interface SystemMessageModel : BaseModel
@property (nonatomic,assign) NSInteger Id; //标识ID
@property (nonatomic,assign) NSInteger msgtype; //消息类型，枚举
@property (nonatomic,copy) NSString *title; //标题
@property (nonatomic,copy) NSString *content; //内容
@property (nonatomic,assign) BOOL isread; //是否阅读
@property (nonatomic,copy) NSString *time; //发布时间
@end
