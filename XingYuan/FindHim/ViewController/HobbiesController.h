//
//  HobbiesController.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/20.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ViewController.h"
typedef enum _HobbiesControllerType {
    HobbiesControllerTypeDefault,
    HobbiesControllerTypeMateRequirement
}HobbiesControllerType;
@interface HobbiesController : ViewController
@property (nonatomic,strong) void(^hobbiesBlock)(NSString *interestids,NSString *hobbiesNames);
@property (nonatomic,copy) NSString *interestids;

- (instancetype)initWithControllerType:(HobbiesControllerType)controllerType;
@end
