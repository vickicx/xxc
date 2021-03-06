//
//  ModifyPasswordController.m
//  XingYuan
//
//  Created by YunKuai on 2017/9/28.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "ModifyPasswordController.h"
#import "LoginRegisterController.h"

@interface ModifyPasswordController ()
@property (weak, nonatomic) IBOutlet UILabel *oldPwdLabel;

@property (weak, nonatomic) IBOutlet UILabel *pwdNewLabel;

@property (weak, nonatomic) IBOutlet UILabel *confirmNewPwdLabel;

@property (weak, nonatomic) IBOutlet UITextField *oldPassword;

@property (weak, nonatomic) IBOutlet UITextField *newsPassword;

@property (weak, nonatomic) IBOutlet UITextField *retypePassword;

@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;

@property (weak, nonatomic) IBOutlet UIButton *finishButton;
@end

@implementation ModifyPasswordController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"修改密码";
    
    self.finishButton.layer.cornerRadius = 3;
    self.finishButton.clipsToBounds = true;
    
    self.oldPwdLabel.font = FONT_WITH_S(17);
    self.pwdNewLabel.font = FONT_WITH_S(17);
    self.confirmNewPwdLabel.font = FONT_WITH_S(17);
    
    self.oldPassword.font = FONT_WITH_S(17);
    self.newsPassword.font = FONT_WITH_S(17);
    self.retypePassword.font = FONT_WITH_S(17);
    
    self.noticeLabel.font = FONT_WITH_S(15);
    
    self.finishButton.titleLabel.font = FONT_WITH_S(18);
    self.finishButton.layer.cornerRadius = 3;
    self.finishButton.clipsToBounds = true;
}

- (IBAction)dealFinish:(UIButton *)sender {
    if(![Helper isValidPassword:self.newsPassword.text]){
        [JGProgressHUD showErrorWith:@"密码格式不正确，请输入6-18位数字和字母" In:self.view];
        return;
    }
    if(![self.newsPassword.text isEqualToString:self.retypePassword.text]){
        [JGProgressHUD showErrorWith:@"两次密码不一致" In:self.view];
    }
    //修改密码
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:self.oldPassword.text forKey:@"oldpwd"];
    [parameters setValue:self.newsPassword.text forKey:@"surenewpwd"];
    [parameters setValue:self.newsPassword.text forKey:@"newpwd"];
    
    [VVNetWorkTool postWithUrl:Url(UpdateMemeberPassword) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *model = [BaseModel new];
        [model setValuesForKeysWithDictionary:result];
        [JGProgressHUD showResultWithModel:model In:self.view];
        
        if([model.code isEqual:@1]){
            [Helper showAlertControllerTitle:@"修改成功，请重新登录" Message:nil completion:^{
                [[[[UIApplication sharedApplication] keyWindow] rootViewController] dismissViewControllerAnimated:YES completion:nil];
                LoginRegisterController *loginRegisterController = [[LoginRegisterController alloc] init];
                UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:loginRegisterController];
                [[UIApplication sharedApplication] keyWindow].rootViewController = nav;
            }];
        }
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
