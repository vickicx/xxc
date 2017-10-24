//
//  ChangePhoneNumberViewController.h
//  XingYuan
//
//  Created by 陈曦 on 2017/10/18.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangePhoneNumberViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *bindingsButton;

@property (weak, nonatomic) IBOutlet UIButton *forgetPassword;
@end
