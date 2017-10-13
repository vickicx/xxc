//
//  NickNameFillInController.h
//  XingYuan
//
//  Created by YunKuai on 2017/10/12.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ViewController.h"

@interface NickNameFillInController : ViewController
@property (nonatomic,strong) void(^nickNameBlock)(NSString *nickname);
@end
