//
//  OneStageScreeningModel.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/19.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "OneStageScreeningModel.h"

@implementation OneStageScreeningModel

- (NSArray *)propertyDescriptions{
    NSMutableArray *propertyDescriptions = [NSMutableArray new];
    
    if(self.nickname != nil && [self.nickname length] != 0){
        [propertyDescriptions addObject:self.nickname];
    }
    if(self.stature != nil && [self.stature length] != 0){
        [propertyDescriptions addObject:self.stature];
    }
    if(self.address != nil && [self.address length] != 0){
        [propertyDescriptions addObject:self.address];
    }
    if(self.constellation != nil && [self.constellation length] != 0){
        [propertyDescriptions addObject:self.constellation];
    }
    if(self.physique != nil && [self.physique length] != 0){
        [propertyDescriptions addObject:self.physique];
    }
    if(self.facialfeatures != nil && [self.facialfeatures length] != 0){
        [propertyDescriptions addObject:self.facialfeatures];
    }
    if(self.birthday != nil && [self.birthday length] != 0){
        [propertyDescriptions addObject:self.birthday];
    }
    if(self.age != nil && [self.age length] != 0){
        [propertyDescriptions addObject:self.age];
    }
    return propertyDescriptions;
}
@end
