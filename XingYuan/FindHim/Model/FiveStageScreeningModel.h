//
//  FiveStageScreeningModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/20.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"

@interface FiveStageScreeningModel : BaseModel
@property (nonatomic,copy) NSString *getmarriedtime; //想何时结婚
@property (nonatomic,copy) NSString *datingpattern; // 偏爱约会方式
@property (nonatomic,copy) NSString *hopeotherlike; // 希望对方看中
@property (nonatomic,copy) NSString *weddingform; // 希望婚礼形式
@property (nonatomic,copy) NSString *livingwithbothparents; // 愿与对方父母住否
@property (nonatomic,copy) NSString *wanthavechildren; // 是否想要孩子
@property (nonatomic,copy) NSString *cookingskill; // 厨艺
@property (nonatomic,copy) NSString *householdduties; // 家务分工
@end
