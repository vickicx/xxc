//
//  SesameCertificationFirstViewController.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/16.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

@interface SesameCertificationFirstViewController : ViewController
@property (weak, nonatomic) IBOutlet UILabel *label;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumberField;

@property (weak, nonatomic) IBOutlet UITextField *verificationCodeField;

@property (weak, nonatomic) IBOutlet UIButton *submitButton;

@property (weak, nonatomic) IBOutlet UIButton *verificationCodeButton;
@end
