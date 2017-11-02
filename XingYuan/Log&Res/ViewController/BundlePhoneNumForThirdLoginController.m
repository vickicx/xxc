//
//  BundlePhoneNumForThirdLoginController.m
//  XingYuan
//
//  Created by YunKuai on 2017/9/28.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "BundlePhoneNumForThirdLoginController.h"
#import "TabBarController.h"

@interface BundlePhoneNumForThirdLoginController ()
@property (weak, nonatomic) IBOutlet UITextField *phoneNum;
@property (weak, nonatomic) IBOutlet UITextField *vertificationCode;
@property (weak, nonatomic) IBOutlet UITextField *password;
@property (weak, nonatomic) IBOutlet UIButton *requestVertificationCodeBtn;
@property (weak, nonatomic) IBOutlet UIButton *bundBtn;

@end

@implementation BundlePhoneNumForThirdLoginController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"绑定手机号";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"绑定手机号";
    label.font = FONT_WITH_S(18);
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:label1];
    self.navigationItem.rightBarButtonItem = itme;
    self.navigationItem.titleView = label;
    
    self.requestVertificationCodeBtn.layer.borderColor = RGBColor(190, 195, 199, 1).CGColor;
    self.requestVertificationCodeBtn.layer.borderWidth = 1;
    self.requestVertificationCodeBtn.titleLabel.font = FONT_WITH_S(14);
    
    self.phoneNum.font = FONT_WITH_S(17);
    self.vertificationCode.font = FONT_WITH_S(17);
    self.password.font = FONT_WITH_S(17);
    
    self.bundBtn.titleLabel.font = FONT_WITH_S(18);
}

//改变密码输入框是否可见状态
- (IBAction)dealChangePasswordVisibleStatus:(UIButton *)sender {
    [sender setSelected:!sender.isSelected];
    [self.password setSecureTextEntry:sender.isSelected];
}

//请求验证码
- (IBAction)dealRequestVertificationCode:(UIButton *)sender {
    //此处应进行手机号格式判断
    if (self.phoneNum.text.length == 0){
        [JGProgressHUD showErrorWith:@"手机号格式不正确" In:self.view];
        return ;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:self.phoneNum.text forKey:@"mobile"];
    [parameters setValue:[NSNumber numberWithInteger:MsgTypethirdAccountBundLoginAccount] forKey:@"smstype"];
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
//使按钮在一定时间内不可操作
//- (void)makeBtnCannotBeHandleWith:(UIButton *)button{
//        button.isUserInteractionEnabled = false
//        var time = 10
//        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: { (timer) in
//            button.setTitle("\(time)秒后再试", for: .normal)
//            time -= 1
//            if time == 0{
//                button.isUserInteractionEnabled = true
//                button.setTitle("获取验证码", for: .normal)
//                timer.invalidate()
//                self.timer = nil
//            }
//        })
//}

//开始绑定
- (IBAction)dealBund:(UIButton *)sender {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:self.openId forKey:@"openid"];
    [parameters setValue:[NSNumber numberWithInteger:self.type] forKey:@"type"]; //微信：1，QQ：2，微博：3
    [parameters setValue:self.memberId forKey:@"memberid"];
    [VVNetWorkTool postWithUrl:Url(BundThirdAccount) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        NSLog(@"%@",result);
        NSDictionary *dic = result;
        BaseModel *model = [[BaseModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        if ([model.code isEqual:@1]){
            [Helper saveMemberId:self.memberId];
            [UIApplication sharedApplication].keyWindow.rootViewController = [[TabBarController alloc] init];
        }
        [JGProgressHUD showErrorWithModel:model In:self.view];
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
