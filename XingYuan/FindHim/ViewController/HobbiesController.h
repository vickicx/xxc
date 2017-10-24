//
//  HobbiesController.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/20.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ViewController.h"

@interface HobbiesController : ViewController
@property (nonatomic,strong) void(^hobbiesBlock)(NSString *hobbies);
@end
