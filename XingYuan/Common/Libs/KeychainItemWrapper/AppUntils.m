//
//  AppUntils.m
//  KWallet
//
//  Created by Min on 2016/12/16.
//  Copyright © 2016年 cdu.com. All rights reserved.
//

#import "AppUntils.h"
#import  <Security/Security.h>
#import "KeychainItemWrapper.h"

#define APP_UUID_ACCOUNT_IDENTFIER  @"identfier"
#define SERVICE_VENDOR  @"zhongshangtong"

@implementation AppUntils

#pragma mark - 保存和读取UUID
+(void)saveUUIDToKeyChain{
    KeychainItemWrapper *keychainItem = [[KeychainItemWrapper alloc] initWithAccount:APP_UUID_ACCOUNT_IDENTFIER service:SERVICE_VENDOR accessGroup:nil];
    NSString *string = [keychainItem objectForKey: (__bridge id)kSecAttrGeneric];
    if([string isEqualToString:@""] || !string){
        [keychainItem setObject:[self getUUIDString] forKey:(__bridge id)kSecAttrGeneric];
    }
}

+(NSString *)readUUIDFromKeyChain{
    KeychainItemWrapper *keychainItemm = [[KeychainItemWrapper alloc] initWithAccount:APP_UUID_ACCOUNT_IDENTFIER service:SERVICE_VENDOR accessGroup:nil];
    NSString *UUID = [keychainItemm objectForKey: (__bridge id)kSecAttrGeneric];
    return UUID;
}

+ (NSString *)getUUIDString
{
    CFUUIDRef uuidRef = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef strRef = CFUUIDCreateString(kCFAllocatorDefault , uuidRef);
    NSString *uuidString = [(__bridge NSString*)strRef stringByReplacingOccurrencesOfString:@"-" withString:@""];
    CFRelease(strRef);
    CFRelease(uuidRef);
    return uuidString;
}

@end
