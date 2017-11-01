//
//  MemberModel.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/30.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MemberModel.h"

@implementation MemberModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqual:@"id"]){
        self.Id = key;
    }
}
@end
