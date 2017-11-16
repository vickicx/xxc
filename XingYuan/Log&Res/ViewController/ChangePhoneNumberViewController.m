//
//  ChangePhoneNumberViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/18.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ChangePhoneNumberViewController.h"
#import "ForgetPasswordController.h"

@interface ChangePhoneNumberViewController ()
@property (weak, nonatomic) IBOutlet UIButton *requestVertificationCodeBtn;

@property (weak, nonatomic) IBOutlet UITextField *phoneNumber;

@property (weak, nonatomic) IBOutlet UITextField *vertificationCode;

@property (weak, nonatomic) IBOutlet UITextField *password;

@property (weak, nonatomic) IBOutlet UIButton *bindingsButton;

@property (weak, nonatomic) IBOutlet UIButton *forgetPassword;
@end

@implementation ChangePhoneNumberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更改手机号";
    
    self.bindingsButton.layer.cornerRadius = 3;
    self.bindingsButton.clipsToBounds = true;
    
    self.phoneNumber.font = FONT_WITH_S(17);
    self.vertificationCode.font = FONT_WITH_S(17);
    self.password.font = FONT_WITH_S(17)
    
    self.bindingsButton.titleLabel.font = FONT_WITH_S(18);
    
    self.requestVertificationCodeBtn.layer.borderColor = APP_THEME_COLOR.CGColor;
    self.requestVertificationCodeBtn.layer.borderWidth = 1;
    self.requestVertificationCodeBtn.titleLabel.font = FONT_WITH_S(14);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//请求验证码
- (IBAction)dealRequestVertificationCode:(UIButton *)sender {
    if(![Helper isValidPhoneNum:self.phoneNumber.text]){
        [JGProgressHUD showErrorWith:@"手机号格式不正确" In:self.view];
        return;
    }

    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:self.phoneNumber.text forKey:@"mobile"];
    [parameters setValue:[NSNumber numberWithInteger:MsgTypebundPhone] forKey:@"smstype"];
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

//改变密码是否可见状态
- (IBAction)dealChangePasswordVisibleState:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    [self.password setSecureTextEntry:!sender.selected];
}

//开始绑定
- (IBAction)dealToBand:(UIButton *)sender {
    if(![Helper isValidPhoneNum:self.phoneNumber.text]){
        [JGProgressHUD showErrorWith:@"手机号格式不正确" In:self.view];
        return;
    }
    if([self.vertificationCode.text length] == 0){
        [JGProgressHUD showErrorWith:@"验证码不能为空" In:self.view];
        return;
    }
    if([self.password.text length] == 0){
        [JGProgressHUD showErrorWith:@"密码不能为空" In:self.view];
    }
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:self.phoneNumber.text forKey:@"mobilephone"];
    [parameters setValue:self.vertificationCode.text forKey:@"msmcode"];
    [parameters setValue:self.password.text forKey:@"pwd"];
    
    [JGProgressHUD showStatusWith:nil In:self.view];
    [VVNetWorkTool postWithUrl:Url(Setmembermobilephone) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *model = [BaseModel new];
        [model setValuesForKeysWithDictionary:result];
        [JGProgressHUD showResultWithModel:model In:self.view];
        if([model.code isEqual:@1]){
            //成功后进行的操作
        }
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

//忘记密码
- (IBAction)dealForgetPwd:(UIButton *)sender {
    //进入忘记密码界面
    ForgetPasswordController *forgetPwdVC = [[ForgetPasswordController alloc] init];
    [self.navigationController pushViewController:forgetPwdVC animated:true];
}

@end
