//
//  SelectAuthenticationController.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/27.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ViewController.h"
#import "ThreeStageScreeningModel.h"

@interface SelectAuthenticationController : ViewController
@property (nonatomic,strong) void(^callBackBlock)(ThreeStageScreeningModel *model);
@end
