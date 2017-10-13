//
//  NTESLoginResultModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/10.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"

@interface NTESLoginResultModel : BaseModel
//IM账号
@property (nonatomic,assign) NSString* accid;
//IM Token
@property (nonatomic,assign) NSString* token;
@end
