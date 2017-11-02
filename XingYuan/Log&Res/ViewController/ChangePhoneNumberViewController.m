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
//    self.title = @"更改手机号";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"更改手机号";
    label.font = FONT_WITH_S(18);
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:label1];
    self.navigationItem.rightBarButtonItem = itme;
    self.navigationItem.titleView = label;
    
    self.bindingsButton.layer.cornerRadius = 3;
    self.bindingsButton.clipsToBounds = true;
    
    self.phoneNumber.font = FONT_WITH_S(17);
    self.vertificationCode.font = FONT_WITH_S(17);
    self.password.font = FONT_WITH_S(17)
    
    self.bindingsButton.titleLabel.font = FONT_WITH_S(18);
    
    self.requestVertificationCodeBtn.layer.borderColor = RGBColor(190, 195, 199, 1).CGColor;
    self.requestVertificationCodeBtn.layer.borderWidth = 1;
    self.requestVertificationCodeBtn.titleLabel.font = FONT_WITH_S(14);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//请求验证码
- (IBAction)dealRequestVertificationCode:(UIButton *)sender {
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
    [sender setBackgroundColor:RGBColor(246, 80, 118, 1)];
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
