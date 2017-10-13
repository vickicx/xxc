//
//  BundlePhoneNumForThirdLoginController.h
//  XingYuan
//
//  Created by YunKuai on 2017/9/28.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseViewController.h"

@interface BundlePhoneNumForThirdLoginController : BaseViewController
@property (copy,nonatomic) NSString *openId;
@property (assign,nonatomic) ThirdPartyLoginType type;
@property (nonatomic) NSNumber *memberId;
@end
