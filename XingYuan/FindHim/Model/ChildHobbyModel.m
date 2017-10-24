//
//  ChildHobbyModel.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/20.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ChildHobbyModel.h"

@implementation ChildHobbyModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if([key isEqualToString:@"id"]){
        self.Id = value;
    }
}
@end
