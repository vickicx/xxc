//
//  BundleSetting.h
//  XingYuan
//
//  Created by YunKuai on 2017/11/2.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BundleSetting : NSObject
@property (nonatomic,copy) NSString *memberid;
@property (nonatomic,copy) NSString *account;
@property (nonatomic,copy) NSString *password;
@property (nonatomic,copy) NSString *token;
@property (nonatomic,copy) NSString *accid;
@property (nonatomic,copy) NSString *acctoken;

+ (instancetype)shareInstance;
@end
