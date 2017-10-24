//
//  ThreeStageScreeningModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/19.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"

@interface ThreeStageScreeningModel : BaseModel
@property (nonatomic,copy) NSString *phoneauthentication; //手机认证
@property (nonatomic,copy) NSString *realnameauthentication; // 实名认证
@property (nonatomic,copy) NSString *zmxyauthentication; // 芝麻认证
@property (nonatomic,copy) NSString *buyhouseauthentication; // 购房认证
@property (nonatomic,copy) NSString *buycarauthentication; // 购车认证
@end
