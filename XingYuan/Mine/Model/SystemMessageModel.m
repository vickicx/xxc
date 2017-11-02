//
//  SystemMessageModel.m
//  XingYuan
//
//  Created by YunKuai on 2017/11/1.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "SystemMessageModel.h"

@implementation SystemMessageModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqual:@"id"]){
        self.Id = value;
    }
}
@end
