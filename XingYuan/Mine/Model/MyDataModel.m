//
//  MyDataModel.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/23.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "MyDataModel.h"

@implementation MyDataModel
- (void)setValue:(id)value forKey:(NSString *)key{
    [super setValue:value forKey:key];
    if([key isEqualToString:@"matching"]){
        NSDictionary *dic = value;
        OneStageScreeningModel *oneStageScreeningModel = [OneStageScreeningModel new];
        [oneStageScreeningModel setValuesForKeysWithDictionary:[dic valueForKey:@"matchinglevelone"]];
        self.matchinglevelone = oneStageScreeningModel;
        
        TwoStateScreeningModel *twoStateScreeningModel = [TwoStateScreeningModel new];
        [twoStateScreeningModel setValuesForKeysWithDictionary:[dic valueForKey:@"matchingleveltwo"]];
        self.matchingleveltwo = twoStateScreeningModel;
        
        ThreeStageScreeningModel *threeStageScreeningModel = [ThreeStageScreeningModel new];
        [threeStageScreeningModel setValuesForKeysWithDictionary:[dic valueForKey:@"matchinglevelthree"]];
        self.matchinglevelthree = threeStageScreeningModel;
        
        FourStageScreeningModel *fourStageScreeningModel = [FourStageScreeningModel new];
        [fourStageScreeningModel setValuesForKeysWithDictionary:[dic valueForKey:@"matchinglevelfour"]];
        self.matchinglevelfour = fourStageScreeningModel;
        
        FiveStageScreeningModel *fiveStageScreeningModel = [FiveStageScreeningModel new];
        [fiveStageScreeningModel setValuesForKeysWithDictionary:[dic valueForKey:@"matchinglevelfive"]];
        self.matchinglevelfive = fiveStageScreeningModel;
    }
    if([key isEqualToString:@"mateselectionone"]){
        OneStageScreeningModel *oneStageScreeningModel = [OneStageScreeningModel new];
        [oneStageScreeningModel setValuesForKeysWithDictionary:value];
        self.matchinglevelone = oneStageScreeningModel;
    }
    if([key isEqualToString:@"mateselectiontwo"]){
        TwoStateScreeningModel *twoStateScreeningModel = [TwoStateScreeningModel new];
        [twoStateScreeningModel setValuesForKeysWithDictionary:value];
        self.matchingleveltwo = twoStateScreeningModel;
    }
    if([key isEqualToString:@"mateselectionthree"]){
        ThreeStageScreeningModel *threeStageScreeningModel = [ThreeStageScreeningModel new];
        [threeStageScreeningModel setValuesForKeysWithDictionary:value];
        self.matchinglevelthree = threeStageScreeningModel;
    }
    if([key isEqualToString:@"mateselectionfour"]){
        FourStageScreeningModel *fourStageScreeningModel = [FourStageScreeningModel new];
        [fourStageScreeningModel setValuesForKeysWithDictionary:value];
        self.matchinglevelfour = fourStageScreeningModel;
    }
    if([key isEqualToString:@"mateselectionfive"]){
        FiveStageScreeningModel *fiveStageScreeningModel = [FiveStageScreeningModel new];
        [fiveStageScreeningModel setValuesForKeysWithDictionary:value];
        self.matchinglevelfive = fiveStageScreeningModel;
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key{

}
@end
