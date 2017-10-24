//
//  HobbiesModel.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/20.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "HobbiesModel.h"


@implementation HobbiesModel
- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqual:@"data"]){
        NSMutableArray *superModels = [[NSMutableArray alloc] init];
        NSArray *arr = value;
        for(int i=0;i<arr.count;i++){
            SuperHobbyModel *superHobbyModel = [SuperHobbyModel new];
            [superHobbyModel setValuesForKeysWithDictionary:arr[i]];
            [superModels addObject:superHobbyModel];
        }
        self.data = superModels;
    }
}
@end
