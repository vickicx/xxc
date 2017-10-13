//
//  NTESConfig.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/9.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <Foundation/Foundation.h>


//此处 apiURL 为网易云信 Demo 应用服务器地址，更换 appkey 后，请更新为应用自己的服务器接口地址，并提供相关接口服
@class NTESRedPacketConfig;

@interface NTESConfig : NSObject
+ (instancetype)sharedConfig;

@property (nonatomic,copy)    NSString    *appKey;
@property (nonatomic,copy)    NSString    *apiURL;
@property (nonatomic,copy)    NSString    *apnsCername;
@property (nonatomic,copy)    NSString    *pkCername;
@property (nonatomic,strong)  NTESRedPacketConfig *redPacketConfig;

- (void)registerConfig:(NSDictionary *)config;
@end



@interface NTESRedPacketConfig : NSObject

@property (nonatomic,assign)  BOOL  useOnlineEnv;

@property (nonatomic,strong)  NSString *aliPaySchemeUrl;

@property (nonatomic,strong)  NSString *weChatSchemeUrl;

@end
