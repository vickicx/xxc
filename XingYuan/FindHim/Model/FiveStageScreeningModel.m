//
//  FiveStageScreeningModel.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/20.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "FiveStageScreeningModel.h"

@implementation FiveStageScreeningModel
//@property (nonatomic,copy) NSString *getmarriedtime; //想何时结婚
//@property (nonatomic,copy) NSString *datingpattern; // 偏爱约会方式
//@property (nonatomic,copy) NSString *hopeotherlike; // 希望对方看中
//@property (nonatomic,copy) NSString *weddingform; // 希望婚礼形式
//@property (nonatomic,copy) NSString *livingwithbothparents; // 愿与对方父母住否
//@property (nonatomic,copy) NSString *wanthavechildren; // 是否想要孩子
//@property (nonatomic,copy) NSString *cookingskill; // 厨艺
//@property (nonatomic,copy) NSString *householdduties; // 家务分工
- (NSArray *)propertyDescriptions{
    NSMutableArray *propertyDescriptions = [NSMutableArray new];
    
    if(self.getmarriedtime != nil && [self.getmarriedtime length] != 0){
        [propertyDescriptions addObject:self.getmarriedtime];
    }
    if(self.datingpattern != nil && [self.datingpattern length] != 0){
        [propertyDescriptions addObject:self.datingpattern];
    }
    if(self.hopeotherlike != nil && [self.hopeotherlike length] != 0){
        [propertyDescriptions addObject:self.hopeotherlike];
    }
    if(self.weddingform != nil && [self.weddingform length] != 0){
        [propertyDescriptions addObject:self.weddingform];
    }
    if(self.livingwithbothparents != nil && [self.livingwithbothparents length] != 0){
        [propertyDescriptions addObject:self.livingwithbothparents];
    }
    if(self.wanthavechildren != nil && [self.wanthavechildren length] != 0){
        [propertyDescriptions addObject:self.wanthavechildren];
    }
    if(self.cookingskill != nil && [self.cookingskill length] != 0){
        [propertyDescriptions addObject:self.cookingskill];
    }
    if(self.householdduties != nil && [self.householdduties length] != 0){
        [propertyDescriptions addObject:self.householdduties];
    }
    return propertyDescriptions;
}
@end
