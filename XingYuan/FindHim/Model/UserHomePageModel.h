//
//  UserHomePageModel.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/25.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseModel.h"
#import "OneStageScreeningModel.h"
#import "TwoStateScreeningModel.h"
#import "ThreeStageScreeningModel.h"
#import "FourStageScreeningModel.h"
#import "FiveStageScreeningModel.h"
#import "PictureModel.h"
@interface UserHomePageModel : BaseModel
@property (nonatomic,copy) NSString *headimg;
@property (nonatomic,copy) NSString *address;
@property (nonatomic,copy) NSNumber *age;
@property (nonatomic,copy) NSString *constellation;
@property (nonatomic,copy) NSString *educational;
@property (nonatomic,copy) NSString *nickname;
@property (nonatomic,copy) NSString *stature;
@property (nonatomic,copy) NSString *summary;
//各项分析未加
@property (nonatomic,copy) NSNumber *picturecount;
@property (nonatomic,strong) NSMutableArray *picArr;

@property (nonatomic,copy) NSNumber *ismatchinglevelone;
@property (nonatomic,copy) NSNumber *ismatchingleveltwo;
@property (nonatomic,copy) NSNumber *ismatchinglevelthree;
@property (nonatomic,copy) NSNumber *ismatchinglevelfour;
@property (nonatomic,copy) NSNumber *ismatchinglevelfive;

@property (nonatomic,strong) OneStageScreeningModel *matchingLevelOne;
@property (nonatomic,strong) TwoStateScreeningModel *matchingLevelTwo;
@property (nonatomic,strong) ThreeStageScreeningModel *matchingLevelThree;
@property (nonatomic,strong) FourStageScreeningModel *matchingLevelFour;
@property (nonatomic,strong) FiveStageScreeningModel *matchingLevelFive;

@property (nonatomic,assign) BOOL isfollow;
@property (nonatomic,assign) BOOL isfriend;

@end
