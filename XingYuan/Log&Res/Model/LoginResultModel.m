
//
//  LoginResultModel.m
//  XingYuan
//
//  Created by YunKuai on 2017/9/28.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "LoginResultModel.h"

@implementation LoginResultModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if ([key  isEqual: @"id"]){
        self.memberId = value;
    }
}
@end
