//
//  MyDataModel.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/23.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"
#import "OneStageScreeningModel.h"
#import "TwoStateScreeningModel.h"
#import "ThreeStageScreeningModel.h"
#import "FourStageScreeningModel.h"
#import "FiveStageScreeningModel.h"

@interface MyDataModel : BaseModel
@property (nonatomic,copy) NSString *headimg;
@property (nonatomic,copy) NSString *matching;
@property (nonatomic,copy) NSNumber *picturecount;
@property (nonatomic,copy) NSString *summary;

@property (nonatomic,strong) OneStageScreeningModel *matchinglevelone;
@property (nonatomic,strong) TwoStateScreeningModel *matchingleveltwo;
@property (nonatomic,strong) ThreeStageScreeningModel *matchinglevelthree;
@property (nonatomic,strong) FourStageScreeningModel *matchinglevelfour;
@property (nonatomic,strong) FiveStageScreeningModel *matchinglevelfive;
@end
