//
//  UrlManager.pch
//  XingYuan
//
//  Created by 陈曦 on 2017/9/27.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#ifndef UrlManager_pch
#define UrlManager_pch


#define HOSTURL @"http://120.78.128.50"
#define Url(string) [NSString stringWithFormat:@"%@%@", HOSTURL, string]

// MARK: - 接口
// MARK: - 注册
#define REGISTER @"/mobileapi/register"
// MARK: - 登录【账号】
#define LOGIN @"/mobileapi/login"
// MARK: - 第三方账号登录
#define THIRDLOGIN @"/mobileapi/thirdpartylogin"
// MARK: - 获取短信验证码
#define HYZX @"/mobileapi/sendsmscode"
// MARK: - 账号与三方账号绑定
#define BundThirdAccount @"/mobileapi/bindthirdparty"
// MARK: - 7.5 注册/登录网易云IM账户
#define LoginRegistNIM @"/im/IMRegister"

// MARK: - 设置用户性别
#define SetMemberSex @"/MobileAPI/SetMemberSex"


// Include any system framework and library headers here that should be included in all compilation units.
// You will also need to set the Prefix Header build setting of one or more of your targets to reference this file.

#endif /* UrlManager_pch */
