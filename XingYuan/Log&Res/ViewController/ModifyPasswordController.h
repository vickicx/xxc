//
//  ModifyPasswordController.h
//  XingYuan
//
//  Created by YunKuai on 2017/9/28.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BaseViewController.h"

@interface ModifyPasswordController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextField *oldPassword;

@property (weak, nonatomic) IBOutlet UITextField *newsPassword;

@property (weak, nonatomic) IBOutlet UITextField *retypePassword;

@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@end
