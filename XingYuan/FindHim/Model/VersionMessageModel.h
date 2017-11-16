//
//  VersionMessageModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/11/9.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"

@interface VersionMessageModel : BaseModel
@property (nonatomic,copy) NSString *desc; //描述
@property (nonatomic,assign) NSInteger identity; //版本标识
@property (nonatomic,assign) BOOL ismustupdate; //是否强制更新
@property (nonatomic,copy) NSString *versionname; //版本名称
@property (nonatomic,copy) NSString *versionnumber; //版本号
@property (nonatomic,copy) NSString *versionurl; //版本更新文件下载地址

@end
