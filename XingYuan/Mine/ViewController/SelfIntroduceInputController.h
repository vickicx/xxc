//
//  SelfIntroduceInputController.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/17.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ViewController.h"

@interface SelfIntroduceInputController : ViewController

@property (nonatomic,strong) void(^callBackBlock)(NSString *introduce);
@end
