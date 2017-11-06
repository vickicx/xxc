//
//  TwoStateScreeningModel.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/19.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "TwoStateScreeningModel.h"

@implementation TwoStateScreeningModel
- (NSArray *)propertyDescriptions{
    NSMutableArray *propertyDescriptions = [NSMutableArray new];
    
    if(self.interestnames != nil && [self.interestnames length] != 0){
        [propertyDescriptions addObject:self.interestnames];
    }
    if(self.educational != nil && [self.educational length] != 0){
        [propertyDescriptions addObject:self.educational];
    }
    if(self.operatingpost != nil && [self.operatingpost length] != 0){
        [propertyDescriptions addObject:self.operatingpost];
    }
    if(self.monthlyincome != nil && [self.monthlyincome length] != 0){
        [propertyDescriptions addObject:self.monthlyincome];
    }
    if(self.maritalstatus != nil && [self.maritalstatus length] != 0){
        [propertyDescriptions addObject:self.maritalstatus];
    }
    if(self.children != nil && [self.children length] != 0){
        [propertyDescriptions addObject:self.children];
    }
    if(self.drink != nil && [self.drink length] != 0){
        [propertyDescriptions addObject:self.drink];
    }
    if(self.smoking != nil && [self.smoking length] != 0){
        [propertyDescriptions addObject:self.smoking];
    }
    if(self.housesstatus != nil && [self.housesstatus length] != 0){
        [propertyDescriptions addObject:self.housesstatus];
    }
    if(self.carstatus != nil && [self.carstatus length] != 0){
        [propertyDescriptions addObject:self.carstatus];
    }
    if(self.workandrest != nil && [self.workandrest length] != 0){
        [propertyDescriptions addObject:self.workandrest];
    }
    return propertyDescriptions;
}
@end
