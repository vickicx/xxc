//
//  MemberModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/30.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"

@interface MemberModel : BaseModel
@property (nonatomic,assign) int Id;    //没得用
@property (nonatomic,assign) int followmemberid;    //我关注的用户的ID
@property (nonatomic,copy) NSString *headimg;   //用户头像
@property (nonatomic,copy) NSString *nickname;  //用户昵称
@property (nonatomic,copy) NSString *nowaddress;    //现住址
@property (nonatomic,assign) int level; //  没得用
@property (nonatomic,assign) int sex;   //  性别
@property (nonatomic,copy) NSString *stature;   //身高
@property (nonatomic,copy) NSString *hl_summary;    //个人简介
@property (nonatomic,copy) NSString *hl_age;    //年龄
@property (nonatomic,copy) NSString *hl_constellation;  //星座
@property (nonatomic,copy) NSString *hl_operatingpost;  //行业

@property (nonatomic,copy) NSString *imaccid;  //IM账号

@end
