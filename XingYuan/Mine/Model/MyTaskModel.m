//
//  MyTaskModel.m
//  XingYuan
//
//  Created by YunKuai on 2017/11/8.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MyTaskModel.h"

@implementation MyTaskModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    if([key isEqual:@"id"]){
        self.Id = value;
    }
}
@end
