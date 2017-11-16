//
//  LoginRegisterController.m
//  XingYuan
//
//  Created by YunKuai on 2017/9/27.
//  Copyright © 2017年 Vicki. All rights reserved.
//sdfghjkl;

#import "LoginRegisterController.h"
#import "VVNetWorkTool+Request.h"
#import "ForgetPasswordController.h"
#import "TabBarController.h"
#import "LoginResultModel.h"
#import "BundlePhoneNumForThirdLoginController.h"
#import "NTESLoginManager.h"
#import "NTESService.h"
#import "UIView+Toast.h"
#import "NTESLoginResultModel.h"
#import "SexSelectController.h"
#import "UserBaseInfoFillInController.h"

@interface LoginRegisterController ()<UINavigationControllerDelegate,TencentSessionDelegate>

////登录
@property (weak, nonatomic) IBOutlet UIButton *loginSelectBtn;
@property (weak, nonatomic) IBOutlet UITextField *loginPhoneTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordTextFeild;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *loginImg;
@property (weak, nonatomic) IBOutlet UIView *loginContentView;


////注册
@property (weak, nonatomic) IBOutlet UIButton *registerSelectBtn;
@property (weak, nonatomic) IBOutlet UITextField *registerPhoneTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *registerPasswordTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *registerConfirmPasswordTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *registerVerificationCode;
@property (weak, nonatomic) IBOutlet UIButton *registerBtn;
@property (weak, nonatomic) IBOutlet UIImageView *registerImg;
@property (weak, nonatomic) IBOutlet UIView *registerContentView;
@property (weak, nonatomic) IBOutlet UIButton *requestVertificationCodeBtn;

@property (weak, nonatomic) IBOutlet UIView *gradientContentView;

@property (retain,nonatomic) TencentOAuth *tencentOAuth;
@property (nonatomic,strong) LoginResultModel *loginResultModel;
@end

@implementation LoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self dealLoginSelect:self.loginSelectBtn];
    
    self.requestVertificationCodeBtn.layer.borderColor = APP_THEME_COLOR.CGColor;
    self.requestVertificationCodeBtn.layer.borderWidth = 1;
    self.requestVertificationCodeBtn.titleLabel.font = FONT_WITH_S(14);
    
    self.registerBtn.layer.cornerRadius = 3;
    self.registerBtn.clipsToBounds = true;
    
    self.registerSelectBtn.titleLabel.font = FONT_WITH_S(16)
    self.loginSelectBtn.titleLabel.font = FONT_WITH_S(16)
    
    self.registerBtn.titleLabel.font = FONT_WITH_S(18)
    self.registerPhoneTextFeild.font = FONT_WITH_S(17)
    self.registerPasswordTextFeild.font = FONT_WITH_S(17)
    self.registerConfirmPasswordTextFeild.font = FONT_WITH_S(17)
    self.registerVerificationCode.font = FONT_WITH_S(17)
    self.registerSelectBtn.titleLabel.font = FONT_WITH_S(17)
    
    self.loginBtn.titleLabel.font = FONT_WITH_S(17)
    self.loginPhoneTextFeild.font = FONT_WITH_S(17)
    self.loginPasswordTextFeild.font = FONT_WITH_S(17)
    
    self.loginPhoneTextFeild.text = [Helper account];
}

//显示注册区域
- (IBAction)dealRegisterSelect:(UIButton *)sender {
    [self.loginSelectBtn setSelected:false];
    [self.registerSelectBtn setSelected:true];
    [self.registerImg setHidden:false];
    [self.loginImg setHidden:true];
    [self.registerContentView setHidden:false];
    [self.loginContentView setHidden:true];
}

//显示登录区域
- (IBAction)dealLoginSelect:(UIButton *)sender {
    [self.registerSelectBtn setSelected:false];
    [self.loginSelectBtn setSelected:true];
    [self.registerImg setHidden:true];
    [self.loginImg setHidden:false];
    [self.registerContentView setHidden:true];
    [self.loginContentView setHidden:false];
}


// MARK: - 登录
- (IBAction)dealLogin:(UIButton *)sender {
    if([self.loginPasswordTextFeild.text length] == 0){
        [JGProgressHUD showErrorWith:@"密码不能为空" In:self.view];
        return;
    }
    if(![Helper isValidPhoneNum:self.loginPhoneTextFeild.text]){
        [JGProgressHUD showErrorWith:@"手机号格式不正确" In:self.view];
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:self.loginPhoneTextFeild.text forKey:@"loginname"];
    [parameters setValue:self.loginPasswordTextFeild.text forKey:@"pwd"];
    
    [JGProgressHUD showStatusWith:nil In:self.view];
    [VVNetWorkTool postWithUrl:Url(LOGIN) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        NSLog(@"%@",result);
        NSDictionary *dic = result;
        LoginResultModel *loginResultModel = [[LoginResultModel alloc] init];
        [loginResultModel setValuesForKeysWithDictionary:dic];
        NSDictionary *data = [dic valueForKey:@"data"];
        [loginResultModel setValuesForKeysWithDictionary:data];
        self.loginResultModel = loginResultModel;
        [JGProgressHUD showErrorWithModel:loginResultModel In:self.view];
        
        //对登录结果进行检测
        if ([loginResultModel.code  isEqual: @1]){
            [Helper saveAccount:self.loginPhoneTextFeild.text];
            [Helper savePassword:self.loginPasswordTextFeild.text];
            
            //进入IM登录业务
            //如果已经注册了NIM则直接登录
            if ([loginResultModel.imaccid length]){
                [self loginNTESWithAccid:loginResultModel.imaccid Token:loginResultModel.imtoken];
            }else{
                //NIM还未注册则向服务器发起注册请求
                [self requestNTESAccidAndTokenWith:loginResultModel.memberId];
            }
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

//应用登陆成功后(若未注册网易云信)根据APPID获取网易云信的 Accid 网易云通信ID、Token 网易云通信ID密码
- (void)requestNTESAccidAndTokenWith:(NSNumber *)memberid{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:memberid forKey:@"memberid"];
    
    [VVNetWorkTool postWithUrl:Url(LoginRegistNIM) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        NSLog(@"%@",result);
        NSDictionary *dic = result;
        NTESLoginResultModel *loginResultModel = [[NTESLoginResultModel alloc] init];
        [loginResultModel setValuesForKeysWithDictionary:dic];
        NSDictionary *data = [dic valueForKey:@"data"];
        [loginResultModel setValuesForKeysWithDictionary:data];
        [JGProgressHUD showErrorWithModel:loginResultModel In:self.view];
        if ([loginResultModel.code isEqual:@1]){
            //登录网易云信账号
            [self loginNTESWithAccid:loginResultModel.accid Token:loginResultModel.token];
        }
    } fail:^(NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

//获取网易云信 Accid、Token成功后，使用NIMSDK登录网易云信
- (void)loginNTESWithAccid:(NSString *)accid Token:(NSString *)token{
    //NIM SDK 只提供消息通道，并不依赖用户业务逻辑，开发者需要为每个APP用户指定一个NIM帐号，NIM只负责验证NIM的帐号即可(在服务器端集成)
    //用户APP的帐号体系和 NIM SDK 并没有直接关系
    //开发者需要根据自己的实际情况配置自身用户系统和 NIM 用户系统的关系
    [[[NIMSDK sharedSDK] loginManager] login:accid
                                       token:token
                                  completion:^(NSError *error) {
                                      if (error == nil)
                                      {
                                          
                                          LoginData *sdkData = [[LoginData alloc] init];
                                          sdkData.account   = accid;
                                          sdkData.token     = token;
                                          [[NTESLoginManager sharedManager] setCurrentLoginData:sdkData];
                                          [[NTESServiceManager sharedManager] start];
                                          
                                          //若未选择性别则跳转性别选选择界面
                                          if ([self.loginResultModel.sex isEqual:@0]){
                                              SexSelectController *sexSelectController = [[SexSelectController alloc] init];
                                              sexSelectController.loginResultModel = self.loginResultModel;
                                              [self.navigationController pushViewController:sexSelectController animated:true];
                                              return;
                                          }
                                          //若未选择用户基础信息则跳转基础信息填写界面
                                          if (!self.loginResultModel.issetmemberinfo){
                                              UserBaseInfoFillInController *baseInfoFillInController = [[UserBaseInfoFillInController alloc] init];
                                              baseInfoFillInController.loginResultModel = self.loginResultModel;
                                              [self.navigationController pushViewController:baseInfoFillInController animated:true];
                                              return;
                                          }
                                          
                                          [Helper saveMemberId:self.loginResultModel.memberId];
                                          [Helper setupMainViewController];
                                      }
                                      else
                                      {
                                          NSString *toast = [NSString stringWithFormat:@"IM登录失败 code: %zd",error.code];
                                          [self.view makeToast:toast duration:2.0 position:CSToastPositionCenter];
                                      }
                                  }];
}

// MARK: - 注册
- (IBAction)dealRegister:(UIButton *)sender {
    //对控件中的值进行判断。。
    if(![Helper isValidPassword:self.registerPasswordTextFeild.text]){
        [JGProgressHUD showErrorWith:@"密码格式不正确，请输入6-18位数字和字母" In:self.view];
        return;
    }
    if(![Helper isValidPhoneNum:self.registerPhoneTextFeild.text]){
        [JGProgressHUD showErrorWith:@"手机号格式不正确" In:self.view];
        return;
    }
    if(![self.registerPasswordTextFeild.text isEqualToString:self.registerConfirmPasswordTextFeild.text]){
        [JGProgressHUD showErrorWith:@"密码不一致" In:self.view];
        return;
    }
    if([self.registerVerificationCode.text length] == 0){
        [JGProgressHUD showErrorWith:@"验证码不能为空" In:self.view];
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:self.registerPhoneTextFeild.text forKey:@"mobilephone"];
    [parameters setValue:self.registerPasswordTextFeild.text forKey:@"pwd"];
    [parameters setValue:self.registerConfirmPasswordTextFeild.text forKey:@"surepwd"];
    [parameters setValue:self.registerVerificationCode.text forKey:@"smscode"];

    [VVNetWorkTool postWithUrl:Url(REGISTER) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *model = [BaseModel new];
        [model setValuesForKeysWithDictionary:result];
        [JGProgressHUD showResultWithModel:model In:self.view];
        if([model.code isEqual:@1]){
            [self.navigationController popViewControllerAnimated:true];
        }
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

// MARK: - 改变密码是否可见状态
- (IBAction)dealChangePasswordVisibleStatus:(UIButton *)sender {
    [sender setSelected:!sender.isSelected];
    self.loginPasswordTextFeild.secureTextEntry = !sender.isSelected;
}

// MARK: - 请求验证码
- (IBAction)dealRequestVertificationCode:(UIButton *)sender {
    if(![Helper isValidPhoneNum:self.registerPhoneTextFeild.text]){
        [JGProgressHUD showErrorWith:@"手机号格式不正确" In:self.view];
        return;
    }
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:self.registerPhoneTextFeild.text forKey:@"mobile"];
    [parameters setValue:[NSNumber numberWithInteger:MsgTyperegister] forKey:@"smstype"];
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

// MARK: - 三方登录
- (IBAction)dealThirdPartyLogin:(UIButton *)sender {
    if (sender.tag == 0){[self qqLogin];}
    if (sender.tag == 1){[self weiboLogin];}
    if (sender.tag == 2){[self wechatLogin];}
}

//忘记密码
- (IBAction)dealForgetPwd:(UIButton *)sender {
    ForgetPasswordController *forgetPwdController = [[ForgetPasswordController alloc] init];
    [self.navigationController pushViewController:forgetPwdController animated:true];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.delegate = self;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma 三方登录
- (void)qqLogin{
    self.tencentOAuth = [[TencentOAuth alloc] initWithAppId:TencentAPPID andDelegate:self];
    NSArray *permissionArray = @[@"get_user_info", @"get_simple_userinfo", @"add_t"];
    [self.tencentOAuth authorize:permissionArray inSafari:true];
}

- (void)weiboLogin{
    
}

- (void)wechatLogin{
    
}

#pragma TencentSessionDelegate
- (void)tencentDidLogin{
    if (self.tencentOAuth.accessToken.length != 0){
        //记录登录用户的openId、token、以及过期时间
        
        //不执行此方法，下面的代理方法就不会调用
        [self.tencentOAuth getUserInfo];
    }else{
        NSLog(@"登录失败，没有获取到accesstoken");
    }
}

- (void)getUserInfoResponse:(APIResponse *)response{
    NSString *openid = self.tencentOAuth.openId;
    NSData *jsonData = [response.message dataUsingEncoding:NSUTF8StringEncoding];
    NSError *err;
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData
                                                        options:NSJSONReadingMutableContainers
                                                          error:&err];
    //网络请求，三方登录（若登录失败则还未绑定手机号跳转绑定）
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:openid forKey:@"openid"];
    [parameters setValue:@2 forKey:@"type"]; //微信：1，QQ：2，微博：3
    [JGProgressHUD showStatusWith:nil In:self.view];
    [VVNetWorkTool postWithUrl:Url(THIRDLOGIN) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        NSLog(@"%@",result);
        NSDictionary *dic = result;
        LoginResultModel *loginResultModel = [[LoginResultModel alloc] init];
        [loginResultModel setValuesForKeysWithDictionary:dic];
        NSDictionary *data = [dic valueForKey:@"data"];
        [loginResultModel setValuesForKeysWithDictionary:data];
        //如果绑定了直接跳TabBarController
        if (loginResultModel.isbindingloginname){
            [Helper saveMemberId:loginResultModel.memberId];
            [Helper setupMainViewController];
        }
        //如果没绑定就去绑定
        if (!loginResultModel.isbindingloginname){
            BundlePhoneNumForThirdLoginController *bundlePhonenumForThirdLoginController = [[BundlePhoneNumForThirdLoginController alloc] init];
            bundlePhonenumForThirdLoginController.memberId = loginResultModel.memberId;
            bundlePhonenumForThirdLoginController.openId = openid;
            bundlePhonenumForThirdLoginController.type = ThirdPartyLoginTypeqq;
            [self.navigationController pushViewController:bundlePhonenumForThirdLoginController animated:true];
        }
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

- (void)tencentDidNotLogin:(BOOL)cancelled{
    if (cancelled){
        NSLog(@"用户取消登录");
    }
}

- (void)tencentDidNotNetWork{
    NSLog(@"网络故障");
}

#pragma UINavigationControllerDelegate
//隐藏导航栏
- (void)navigationController:(UINavigationController *)navigationController willShowViewController:(nonnull UIViewController *)viewController animated:(BOOL)animated{
    if (viewController == self){
        [navigationController setNavigationBarHidden:true animated:true];
    }else{
        [navigationController setNavigationBarHidden:false animated:true];
    }
}
@end
