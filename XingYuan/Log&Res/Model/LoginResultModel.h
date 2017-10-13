//
//  LoginResultModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/9/28.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"

@interface LoginResultModel : BaseModel
//用户标识id
@property (nonatomic,assign) NSNumber*memberId;
//是否实名
@property (nonatomic,assign) NSNumber* isrealname;
//token
@property (nonatomic,assign) NSNumber* token;
//是否绑定系统登录账号
@property (nonatomic,assign) BOOL isbindingloginname;
//性别
@property (nonatomic,copy) NSNumber *sex;
//基础信息
@property (nonatomic,copy) NSString *baseInfo;

//IM账号
@property (nonatomic,assign) NSString* imaccid;
//IM Token
@property (nonatomic,assign) NSString* imtoken;
@end
