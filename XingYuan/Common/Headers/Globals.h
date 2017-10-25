//
//  Globals.h
//  XingYuan
//
//  Created by YunKuai on 2017/9/29.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#ifndef Globals_h
#define Globals_h

static JGProgressHUD *hud;

#pragma 相关枚举
//收藏类型
typedef NS_ENUM(NSUInteger, CollectType) {
    collect = 1,
    cancelCollect = 2
};

//短信类型
typedef NS_ENUM(NSUInteger, MsgType) {
    //注册
    MsgTyperegister = 1,
    //登录
    MsgTypelogin = 2,
    //修改登录密码
    MsgTypeupdateLoginPwd = 3,
    //重置登录密码
    MsgTyperesetLoginPwd = 4,
    //实名认证
    MsgTypecertification = 5,
    //绑定手机
    MsgTypebundPhone = 6,
    //三方账号绑定用户登录账号
    MsgTypethirdAccountBundLoginAccount = 7
};

//三方登录类型
typedef NS_ENUM(NSUInteger, ThirdPartyLoginType) {
    //微信
    ThirdPartyLoginTypewechat = 1,
    //QQ
    ThirdPartyLoginTypeqq = 2,
    //微博
    ThirdPartyLoginTypeweibo = 3
};

////取消/关注圈子
//enum HandleCircleType:Int{
//    //关注
//case follow = 1
//    //取关
//case cancleFollow = 2
//}
//
////取消/关注用户
//enum HandleMemberType:Int{
//    //关注
//case follow = 1
//    //取关
//case cancleFollow = 2
//}
//
////任务类型
//enum TaskType:Int{
//    //注册
//case register = 1
//    //登录
//case login = 2
//    //编辑个人资料
//case editPersonalProfile = 3
//    //实名认证
//case certification = 4
//    //浏览圈子
//case glanceCircle = 5
//    //查看圈子详情
//case checkCircleDetail = 6
//    //浏览帖子
//case glancePost = 7
//    //查看帖子详情
//case checkPostDetail = 8
//    //浏览回帖
//case glanceBackPost = 9
//    //发布视频
//case publishVideo = 10
//    //发布心情
//case publishMood = 11
//    //发布图片
//case publishPicture = 12
//    //发布帖子
//case publishPost = 13
//    //回复帖子
//case replayPost = 14
//    //二次回帖
//case twiceReplayPost = 15
//}
//

#endif /* Globals_h */
