//
//  SuperHobbyModel.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/20.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "SuperHobbyModel.h"

@implementation SuperHobbyModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if([key isEqualToString:@"id"]){
        self.Id = value;
    }
}

- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"child"]){
        NSMutableArray *childModels = [[NSMutableArray alloc] init];
        NSArray *arr = value;
        for(int i=0;i<arr.count;i++){
            ChildHobbyModel *childHobbyModel = [ChildHobbyModel new];
            [childHobbyModel setValuesForKeysWithDictionary:arr[i]];
            [childModels addObject:childHobbyModel];
        }
        self.child = childModels;
    }
}
@end
