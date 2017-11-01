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
/***********************婚恋接口************************/

// MARK: - 1.1拉黑(已对接)
#define Defriend @"/mobileapi/defriend"

// MARK: - 1.2选择兴趣（已对接）
#define Setinterest @"/mobileapi/setinterest"

// MARK: - 1.3用户兴趣（已对接）
#define Memberinterest @"/mobileapi/memberinterest"

// MARK: - 1.4一级匹配（已对接）
#define Matchingone @"/mobileapi/matchingone"

// MARK: - 1.5展示一级匹配（已对接）
#define Showmatchingone @"/mobileapi/showmatchingone"

// MARK: - 1.6二级匹配（已对接）
#define Matchingtwo @"/mobileapi/matchingtwo"

// MARK: - 1.7展示二级匹配（已对接）
#define Showmatchingtwo @"/mobileapi/showmatchingtwo"

// MARK: - 1.8展示三级匹配（已对接）
#define ShowmatchingThree @"/mobileapi/showmatchingThree"

// MARK: - 1.9四级匹配（已对接）
#define MatchingFour @"/mobileapi/matchingFour"

// MARK: - 2.0展示四级匹配（已对接）
#define ShowmatchingFour @"/mobileapi/showmatchingFour"

// MARK: - 2.1五级匹配（已对接）
#define Matchingfive @"/mobileapi/matchingfive"

// MARK: - 2.2展示五级匹配（已对接）
#define Showmatchingfive @"/mobileapi/showmatchingfive"

// 2.3、2.4接口报废

// MARK: - 2.5设置用户基本资料（已对接）
#define SetMemberInfo @"/mobileapi/SetMemberInfo"

// MARK: - 2.6设置用户性别（已对接）
#define SetMemberSex @"/MobileAPI/SetMemberSex"

// MARK: - 2.7用户消息
#define MemberInformation @"/mobileapi/MemberInformation"

// MARK: - 2.8阅读消息
#define ReadInformation @"/mobileapi/ReadInformation"

// MARK: - 2.9提交意见（已对接）
#define SubmitFeedBack @"/mobileapi/SubmitFeedBack"

// MARK: - 3.0我的个人介绍 （部分已对接）
#define MyArtistIntroduction @"/mobileapi/MyArtistIntroduction"

// MARK: - 3.1设置个人介绍 （已对接）
#define SetArtistIntroduction @"/mobileapi/SetArtistIntroduction"

// MARK: - 3.2上传证明文件【购房、购车】(已对接)
#define UploadCertifyFile @"/mobileapi/UploadCertifyFile"

// MARK: - 3.3相册预览 （已对接）
#define PhotoAlbumPreview @"/mobileapi/PhotoAlbumPreview"

// MARK: - 3.4 IM好友列表
#define IMFriend @"/IM/IMFriend"

// MARK: - 3.5我的 （已对接）
#define AboutMe @"/MobileApi/HLAboutMe"

// MARK: - 3.6用户主页 （已对接）
#define MemberFirstPage @"/MobileApi/MemberFirstPage"

// MARK: - 3.7我的相册【展示】（已对接）
#define Myphotoalbum @"/mobileapi/myphotoalbum"

// MARK: - 3.8相册排序照片
#define Setphotoalbumsort @"/mobileapi/setphotoalbumsort"

// MARK: - 3.9我的资料（已对接）
#define MyInfo @"/mobileapi/myinfo"

// MARK: - 4.0首页(已对接)
#define KnowTAFirstPage @"/mobileapi/KnowTAFirstPage"

// MARK: - 4.1用户匹配HTML
//# warning - 接口

// MARK: - 4.2用户匹配（前端的接口）
#define MemberMatch @"/mobileapi/MemberMatch"

// MARK: - 4.3展示择偶一级匹配(已对接)
#define ShowMateSelectionMatchingOne @"/mobileapi/ShowMateSelectionMatchingOne"

// MARK: - 4.4展示择偶二级匹配(已对接)
#define ShowMateSelectionMatchingTwo @"/mobileapi/ShowMateSelectionMatchingTwo"

// MARK: - 4.5展示择偶三级匹配(已对接)
#define ShowMateSelectionMatchingThree @"/mobileapi/ShowMateSelectionMatchingThree"

// MARK: - 4.6展示择偶四级匹配(已对接)
#define ShowMateSelectionMatchingFour @"/mobileapi/ShowMateSelectionMatchingFour"

// MARK: - 4.7展示择偶五级匹配(已对接)
#define ShowMateSelectionMatchingFive @"/mobileapi/ShowMateSelectionMatchingFive"

// MARK: - 4.8设置择偶一级匹配(已对接)
#define SetMateSelectionMatchingOne @"/mobileapi/SetMateSelectionMatchingOne"

// MARK: - 4.9设置择偶二级匹配(已对接)
#define SetMateSelectionMatchingTwo @"/mobileapi/SetMateSelectionMatchingTwo"

// MARK: - 5.0设置择偶三级匹配(已对接)
#define SetMateSelectionMatchingThree @"/mobileapi/SetMateSelectionMatchingThree"

// MARK: - 5.1设置择偶四级匹配(已对接)
#define SetMateSelectionMatchingFour @"/mobileapi/SetMateSelectionMatchingFour"

// MARK: - 5.2设置择偶五级匹配(已对接)
#define SetMateSelectionMatchingFive @"/mobileapi/SetMateSelectionMatchingFive"

// MARK: - 5.3上传头像(已对接)
#define UploadHeadImg @"/mobileapi/UploadHeadImg"

// MARK: - 5.4匹配信息(已对接)
#define MateSelectionRequire @"/mobileapi/MateSelectionRequire"

// MARK: - 5.5 展示兴趣(已对接)
#define Interestbyids @"/mobileapi/interestbyids"

// MARK: - 5.6 版本管理
#define Versionmanage @"/mobileapi/versionmanage"

/***********************赛尔空间接口************************/

// MARK: - 1.1注册（已对接）
#define REGISTER @"/mobileapi/register"

// MARK: - 1.2登录【账号】（已对接）
#define LOGIN @"/mobileapi/login"

// MARK: - 1.4第三方账号登录（已对接）
#define THIRDLOGIN @"/mobileapi/thirdpartylogin"

// MARK: - 1.9获取短信验证码（已对接）
#define HYZX @"/mobileapi/sendsmscode"

// MARK: - 2.5我关注的人（已对接）
#define Myfollowmember @"/mobileapi/myfollowmember"

// MARK: - 2.6关注用户（已对接）
#define FollowMemeber @"/mobileapi/followmember"

// MARK: - 3.8关注我的人（已对接）
#define Myfollower @"/mobileapi/myfollower"

// MARK: - 3.9修改密码（已对接）
#define UpdateMemeberPassword @"/mobileapi/updatememberpwd"

// MARK: - 4.0忘记密码（已对接）
#define ResetMemeberPassword @"/mobileapi/resetmemberpassword"

// MARK: - 4.1绑定手机号(已对接)
#define Setmembermobilephone @"/mobileapi/setmembermobilephone"

// MARK: - 4.2账号与三方账号绑定（已对接）
#define BundThirdAccount @"/mobileapi/bindthirdparty"

// MARK: - 5.7相册上传照片（已对接）
#define Uploadmemberpicturewall @"/mobileapi/uploadmemberpicturewall"

// MARK: - 5.8相册删除照片（已对接）
#define Deletememberpicturewall @"/mobileapi/deletememberpicturewall"

// MARK: - 7.5 注册/登录网易云IM账户（已对接）
#define LoginRegistNIM @"/im/IMRegister"

#endif /* UrlManager_pch */
