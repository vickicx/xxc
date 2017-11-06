//
//  BundleSetting.m
//  XingYuan
//
//  Created by YunKuai on 2017/11/2.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BundleSetting.h"

@implementation BundleSetting
+ (instancetype)shareInstance
{
    static id instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[[self class] alloc] init];
    });
    return instance;
}
- (void)setMemberid:(NSString *)memberid{
    [[NSUserDefaults standardUserDefaults] setValue:memberid forKey:@"memberid"];
}

- (NSString *)memberid{
    return [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"memberid"]];
}

- (void)setAccount:(NSString *)account{
    [[NSUserDefaults standardUserDefaults] setValue:account forKey:@"account"];
}

- (NSString *)account{
    return [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"account"]];
}

- (void)setPassword:(NSString *)password{
    [[NSUserDefaults standardUserDefaults] setValue:password forKey:@"password"];
}

- (NSString *)password{
    return [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"password"]];
}

- (void)setToken:(NSString *)token{
    [[NSUserDefaults standardUserDefaults] setValue:token forKey:@"token"];
}

- (NSString *)token{
    return [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"token"]];
}

- (void)setAccid:(NSString *)accid{
    [[NSUserDefaults standardUserDefaults] setValue:accid forKey:@"accid"];
}

- (NSString *)accid{
    return [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"accid"]];
}

- (void)setAcctoken:(NSString *)acctoken{
    [[NSUserDefaults standardUserDefaults] setValue:acctoken forKey:@"acctoken"];
}

- (NSString *)acctoken{
    return [NSString stringWithFormat:@"%@",[[NSUserDefaults standardUserDefaults] objectForKey:@"acctoken"]];
}
@end
