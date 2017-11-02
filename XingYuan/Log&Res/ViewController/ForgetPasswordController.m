//
//  ForgetPasswordController.m
//  XingYuan
//
//  Created by YunKuai on 2017/9/27.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ForgetPasswordController.h"

@interface ForgetPasswordController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *vertificationCode;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIButton *requestVertificationCodeBtn;

@property (weak, nonatomic) IBOutlet UITextField *newpass;

@end

@implementation ForgetPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"忘记密码";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"忘记密码";
    label.font = FONT_WITH_S(18);
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:label1];
    self.navigationItem.rightBarButtonItem = itme;
    self.navigationItem.titleView = label;
    self.finishBtn.layer.cornerRadius = 3;
    self.finishBtn.clipsToBounds = true;
    
    self.requestVertificationCodeBtn.layer.borderColor = RGBColor(190, 195, 199, 1).CGColor;
    self.requestVertificationCodeBtn.layer.borderWidth = 1;
    self.requestVertificationCodeBtn.titleLabel.font = FONT_WITH_S(14);
    
    self.phoneNum.font = FONT_WITH_S(17)
    self.vertificationCode.font = FONT_WITH_S(17)
    self.newpass.font = FONT_WITH_S(17)
    
    self.finishBtn.titleLabel.font = FONT_WITH_S(18)
}

//请求验证码
- (IBAction)dealRequestVertificationCode:(UIButton *)sender {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:self.phoneNum.text forKey:@"mobile"];
    [parameters setValue:[NSNumber numberWithInteger:MsgTyperesetLoginPwd] forKey:@"smstype"];
    [parameters setValue:@"" forKey:@"msg"];
    
    [VVNetWorkTool postWithUrl:Url(HYZX) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *model = [BaseModel new];
        [model setValuesForKeysWithDictionary:result];
        [[Helper shareInstance] makeBtnCannotBeHandleWith:self.requestVertificationCodeBtn];
        [JGProgressHUD showResultWithModel:model In:self.view];
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

- (IBAction)dealChangePasswordVisibleState:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    [self.newpass setSecureTextEntry:!sender.selected];
}

- (IBAction)dealFinish:(UIButton *)sender {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:self.phoneNum.text forKey:@"loginname"];
    [parameters setValue:self.newpass.text forKey:@"pwd"];
    [parameters setValue:self.newpass.text forKey:@"surepwd"];
    [parameters setValue:self.vertificationCode.text forKey:@"smscode"];
    
    [VVNetWorkTool postWithUrl:Url(ResetMemeberPassword) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *model = [BaseModel new];
        [model setValuesForKeysWithDictionary:result];
        [JGProgressHUD showResultWithModel:model In:self.view];
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
