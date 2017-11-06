//
//  FourStageScreeningModel.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/20.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "FourStageScreeningModel.h"

@implementation FourStageScreeningModel
- (NSArray *)propertyDescriptions{
    NSMutableArray *propertyDescriptions = [NSMutableArray new];
    
    if(self.hometown != nil && [self.hometown length] != 0){
        [propertyDescriptions addObject:self.hometown];
    }
    if(self.householdregister != nil && [self.householdregister length] != 0){
        [propertyDescriptions addObject:self.householdregister];
    }
    if(self.nation != nil && [self.nation length] != 0){
        [propertyDescriptions addObject:self.nation];
    }
    if(self.sx != nil && [self.sx length] != 0){
        [propertyDescriptions addObject:self.sx];
    }
    if(self.familyranking != nil && [self.familyranking length] != 0){
        [propertyDescriptions addObject:self.familyranking];
    }
    if(self.parentstatus != nil && [self.parentstatus length] != 0){
        [propertyDescriptions addObject:self.parentstatus];
    }
    if(self.fatherwork != nil && [self.fatherwork length] != 0){
        [propertyDescriptions addObject:self.fatherwork];
    }
    if(self.motherwork != nil && [self.motherwork length] != 0){
        [propertyDescriptions addObject:self.motherwork];
    }
    if(self.parenteconomic != nil && [self.parenteconomic length] != 0){
        [propertyDescriptions addObject:self.parenteconomic];
    }
    if(self.parentmedicalinsurance != nil && [self.parentmedicalinsurance length] != 0){
        [propertyDescriptions addObject:self.parentmedicalinsurance];
    }
    return propertyDescriptions;
}
@end
