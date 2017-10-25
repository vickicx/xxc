//
//  BasicInformationTableViewCell.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/10.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UserHomePageModel.h"
#import "OneStageScreeningModel.h"

@interface BasicInformationTableViewCell : UITableViewCell
@property (nonatomic,strong) OneStageScreeningModel *matchingLevelOneModel;
@property (nonatomic,strong) NSMutableArray *arr;
@end
