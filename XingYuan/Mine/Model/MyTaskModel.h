//
//  MyTaskModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/11/8.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"

@interface MyTaskModel : BaseModel
@property (nonatomic,assign) NSNumber *Id; //用户任务标识ID
@property (nonatomic,assign) NSNumber *finishcount; //当前完成次数
@property (nonatomic,assign) BOOL isfinish; //是否完成任务
@property (nonatomic,assign) BOOL isfinishaward; //是否领取奖励
@property (nonatomic,assign) BOOL isvalid; //
@property (nonatomic,copy) NSString *taskname; //任务名称
@property (nonatomic,assign) NSNumber *taskneedfinishcount; //任务需要完成次数
@property (nonatomic,assign) NSNumber *taskexperience; //任务奖励经验
@property (nonatomic,assign) NSNumber *taskidealmoney; //任务奖励虚拟币
@property (nonatomic,assign) NSNumber *tasktype; //任务类型，枚举
@property (nonatomic,assign) BOOL isnewhandletask; //是否新手任务

@end
