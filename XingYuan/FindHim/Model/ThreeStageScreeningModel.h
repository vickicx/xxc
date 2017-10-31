//
//  ThreeStageScreeningModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/19.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"

@interface ThreeStageScreeningModel : BaseModel
@property (nonatomic,assign) BOOL phoneauthentication; //手机认证
@property (nonatomic,assign) BOOL realnameauthentication; // 实名认证
@property (nonatomic,assign) BOOL zmxyauthentication; // 芝麻认证
@property (nonatomic,assign) BOOL buyhouseauthentication; // 购房认证
@property (nonatomic,assign) BOOL buycarauthentication; // 购车认证

@property (nonatomic,assign) int buycarcertifyaudit; // 购车认证审核
@property (nonatomic,assign) int buyhousecertifyaudit; // 购房认证审核

@end
