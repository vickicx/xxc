//
//  FindHimMainModel.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/24.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "FindHimMainModel.h"
#import "PictureModel.h"

@implementation FindHimMainModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if([key isEqualToString:@"id"]){
        self.nid = value;
    }
    if([key isEqualToString:@"picture"]){
        self.picture = [NSMutableArray new];
        NSMutableArray *arr = [NSMutableArray arrayWithArray:value];
        for (NSDictionary *dic in arr) {
            PictureModel *pic = [[PictureModel alloc] initWithDictionary:dic];
            [self.picture addObject:pic];
        }
    }
}
@end
