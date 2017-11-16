//
//  AppUntils.h
//  KWallet
//
//  Created by Min on 2016/12/16.
//  Copyright © 2016年 cdu.com. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AppUntils : NSObject

#pragma mark - 保存和读取UUID
+(void)saveUUIDToKeyChain;
+(NSString *)readUUIDFromKeyChain;
+(NSString *)getUUIDString;


@end
