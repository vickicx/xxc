//
//  NSDictionary+ScreeningValues.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/27.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "NSDictionary+ScreeningValues.h"

@implementation NSDictionary (ScreeningValues)

- (NSArray *)allScreeningValues{
    NSMutableArray *values = [[NSMutableArray alloc] init];
    NSArray *keys = [self allKeys];
    for(int i=0;i<keys.count;i++){
        NSString *key = keys[i];
        if([key isEqual:@"code"] || [key isEqual:@"msg"]){continue;}
        [values addObject:[self valueForKey:key]];
    }
    return values;
}
@end
