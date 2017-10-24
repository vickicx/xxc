//
//  NTESConfig.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/9.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "NTESConfig.h"

@interface NTESConfig ()

@end

@implementation NTESConfig
+ (instancetype)sharedConfig
{
    static NTESConfig *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[NTESConfig alloc] init];
    });
    return instance;
}

- (instancetype)init
{
    if (self = [super init])
    {
        _appKey = @"7555490e7e45db5ccfbd516be5415fad";
        _apiURL = @"https://app.netease.im/api";
        _apnsCername = @"apsDevelopment";
        _pkCername = @"pushkitDevelopment";
        
        _redPacketConfig = [[NTESRedPacketConfig alloc] init];
    }
    return self;
}

- (NSString *)apiURL
{
    NSAssert([[NIMSDK sharedSDK] isUsingDemoAppKey], @"只有 demo appKey 才能够使用这个API接口");
    return _apiURL;
}

- (void)registerConfig:(NSDictionary *)config
{
    if (config[@"red_packet_online"])
    {
        _redPacketConfig.useOnlineEnv = [config[@"red_packet_online"] boolValue];
    }
}


@end



@implementation NTESRedPacketConfig

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        _useOnlineEnv = YES;
        _aliPaySchemeUrl = @"alipay052969";
        _weChatSchemeUrl = @"wx2a5538052969956e";
    }
    return self;
}

@end
