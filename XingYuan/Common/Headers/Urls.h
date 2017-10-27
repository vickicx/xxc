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

// MARK: - 注册（已对接）
#define REGISTER @"/mobileapi/register"
// MARK: - 登录【账号】（已对接）
#define LOGIN @"/mobileapi/login"
// MARK: - 第三方账号登录（已对接）
#define THIRDLOGIN @"/mobileapi/thirdpartylogin"
// MARK: - 获取短信验证码（已对接）
#define HYZX @"/mobileapi/sendsmscode"
// MARK: - 账号与三方账号绑定（已对接）
#define BundThirdAccount @"/mobileapi/bindthirdparty"
// MARK: - 7.5 注册/登录网易云IM账户（已对接）
#define LoginRegistNIM @"/im/IMRegister"

// MARK: - 设置用户性别（已对接）
#define SetMemberSex @"/MobileAPI/SetMemberSex"

// MARK: - 设置用户基本资料（已对接）
#define SetMemberInfo @"/mobileapi/SetMemberInfo"

// MARK: - 提交意见（已对接）
#define SubmitFeedBack @"/mobileapi/SubmitFeedBack"

// MARK: - 拉黑(已对接)
#define Defriend @"/mobileapi/defriend"

// MARK: - 选择兴趣（已对接）
#define Setinterest @"/mobileapi/setinterest"

// MARK: - 用户兴趣（已对接）
#define Memberinterest @"/mobileapi/memberinterest"

// MARK: - 一级匹配（已对接）
#define Matchingone @"/mobileapi/matchingone"

// MARK: - 展示一级匹配（已对接）
#define Showmatchingone @"/mobileapi/showmatchingone"

// MARK: - 二级匹配（已对接）
#define Matchingtwo @"/mobileapi/matchingtwo"

// MARK: - 展示二级匹配（已对接）
#define Showmatchingtwo @"/mobileapi/showmatchingtwo"

// MARK: - 展示三级匹配（已对接）
#define ShowmatchingThree @"/mobileapi/showmatchingThree"

// MARK: - 四级匹配（已对接）
#define MatchingFour @"/mobileapi/matchingFour"

// MARK: - 展示四级匹配（已对接）
#define ShowmatchingFour @"/mobileapi/showmatchingFour"

// MARK: - 五级匹配（已对接）
#define Matchingfive @"/mobileapi/matchingfive"

// MARK: - 展示五级匹配（已对接）
#define Showmatchingfive @"/mobileapi/showmatchingfive"

// MARK: - 设置择偶要求（该接口报销）
#define SetMateSelectionRequire @"/mobileapi/SetMateSelectionRequire"

// MARK: - 用户消息
#define MemberInformation @"/mobileapi/MemberInformation"

// MARK: - 阅读消息
#define ReadInformation @"/mobileapi/ReadInformation"

// MARK: - 我的个人介绍 （部分已对接）
#define MyArtistIntroduction @"/mobileapi/MyArtistIntroduction"

// MARK: - 设置个人介绍 （已对接）
#define SetArtistIntroduction @"/mobileapi/SetArtistIntroduction"

// MARK: - 上传证明文件【购房、购车】(已对接)
#define UploadCertifyFile @"/mobileapi/UploadCertifyFile"

// MARK: - 相册预览 （已对接）
#define PhotoAlbumPreview @"/mobileapi/PhotoAlbumPreview"

// MARK: - 我的 （已对接）
#define AboutMe @"/MobileApi/HLAboutMe"

// MARK: - 用户主页 （已对接）
#define MemberFirstPage @"/MobileApi/MemberFirstPage"

// MARK: - 我的相册【展示】
#define Myphotoalbum @"/mobileapi/myphotoalbum"

// MARK: - 相册删除照片
#define Deletememberpicturewall @"/mobileapi/deletememberpicturewall"

// MARK: - 相册上传照片
#define Uploadmemberpicturewall @"/mobileapi/uploadmemberpicturewall"

// MARK: - 相册排序照片
#define Setphotoalbumsort @"/mobileapi/setphotoalbumsort"


// MARK: - 我的资料（已对接）
#define MyInfo @"/mobileapi/myinfo"

// MARK: - 首页(已对接)
#define KnowTAFirstPage @"/mobileapi/KnowTAFirstPage"

// MARK: - 上传头像(已对接)
#define UploadHeadImg @"/mobileapi/UploadHeadImg"

// MARK: - 忘记密码（已对接）
#define ResetMemeberPassword @"/mobileapi/resetmemberpassword"

// MARK: - 修改密码（已对接）
#define UpdateMemeberPassword @"/mobileapi/updatememberpwd"

// MARK: - 关注用户
#define FollowMemeber @"/mobileapi/followmember"

// MARK: - 用户匹配
#define MemberMatch @"/mobileapi/MemberMatch"

// MARK: - 择偶一级匹配
#define ShowMateSelectionMatchingOne @"/mobileapi/ShowMateSelectionMatchingOne"

// MARK: - 择偶二级匹配
#define ShowMateSelectionMatchingTwo @"/mobileapi/ShowMateSelectionMatchingTwo"

// MARK: - 择偶三级匹配
#define ShowMateSelectionMatchingThree @"/mobileapi/ShowMateSelectionMatchingThree"

// MARK: - 择偶四级匹配
#define ShowMateSelectionMatchingFour @"/mobileapi/ShowMateSelectionMatchingFour"

// MARK: - 择偶五级匹配
#define ShowMateSelectionMatchingFive @"/mobileapi/ShowMateSelectionMatchingFive"

// MARK: - 设置择偶一级匹配
#define SetMateSelectionMatchingOne @"/mobileapi/SetMateSelectionMatchingOne"

// MARK: - 设置择偶二级匹配
#define SetMateSelectionMatchingTwo @"/mobileapi/SetMateSelectionMatchingTwo"

// MARK: - 设置择偶三级匹配
#define SetMateSelectionMatchingThree @"/mobileapi/SetMateSelectionMatchingThree"

// MARK: - 设置择偶四级匹配
#define SetMateSelectionMatchingFour @"/mobileapi/SetMateSelectionMatchingFour"

// MARK: - 设置择偶五级匹配
#define SetMateSelectionMatchingFive @"/mobileapi/SetMateSelectionMatchingFive"

// MARK: - 匹配信息
#define MateSelectionRequire @"/mobileapi/MateSelectionRequire"


// MARK: - 绑定手机号
#define Setmembermobilephone @"/mobileapi/setmembermobilephone"
#endif /* UrlManager_pch */
