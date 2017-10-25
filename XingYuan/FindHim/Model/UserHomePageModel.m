//
//  UserHomePageModel.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/25.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "UserHomePageModel.h"

@implementation UserHomePageModel

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    [super setValue:value forUndefinedKey:key];
    if([key isEqualToString:@"matchinglevelone"]){
        self.matchingLevelOne = [[OneStageScreeningModel alloc] initWithDictionary:value];
    }else if([key isEqualToString:@"matchingleveltwo"]){
        self.matchingLevelTwo = [[TwoStateScreeningModel alloc] initWithDictionary:value];
    }else if([key isEqualToString:@"matchinglevelthree"]){
        self.matchingLevelThree = [[ThreeStageScreeningModel alloc] initWithDictionary:value];
    }else if([key isEqualToString:@"matchinglevelfour"]){
        self.matchingLevelFour = [[FourStageScreeningModel alloc] initWithDictionary:value];
    }else if([key isEqualToString:@"matchinglevelfive"]){
        self.matchingLevelFive = [[FiveStageScreeningModel alloc] initWithDictionary:value];
    }
    
    if([key isEqualToString:@"picture"]){
        NSMutableArray *arr = [NSMutableArray new];
        for (NSDictionary *dic in value) {
            PictureModel *pic = [[PictureModel alloc] initWithDictionary:dic];
            [arr addObject:pic];
        }
        self.picArr = [NSMutableArray arrayWithArray:arr];
    }
}
@end
