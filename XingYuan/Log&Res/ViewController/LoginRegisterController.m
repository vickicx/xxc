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
@property (weak, nonatomic) IBOutlet UITextField *loginPhoneTextFeild;
@property (weak, nonatomic) IBOutlet UITextField *loginPasswordTextFeild;
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;
@property (weak, nonatomic) IBOutlet UIImageView *loginImg;
@property (weak, nonatomic) IBOutlet UIView *loginContentView;


////注册
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
@property (nonatomic,weak) LoginResultModel *loginResultModel;
@end

@implementation LoginRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
}

//显示注册区域
- (IBAction)dealRegisterSelect:(UIButton *)sender {
    [self.registerContentView setHidden:false];
    [self.loginContentView setHidden:true];
}

//显示登录区域
- (IBAction)dealLoginSelect:(UIButton *)sender {
    [self.registerContentView setHidden:true];
    [self.loginContentView setHidden:false];
}


// MARK: - 登录
- (IBAction)dealLogin:(UIButton *)sender {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:self.loginPhoneTextFeild.text forKey:@"loginname"];
    [parameters setValue:self.loginPasswordTextFeild.text forKey:@"pwd"];
    [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
    [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
    [parameters setValue:[Helper sign] forKey:@"sign"];          //签名MD5_32(timestamp+randomnumber+SignValidateKey)

    //[UIApplication sharedApplication].keyWindow.rootViewController = [[TabBarController alloc] init];
    
    [JGProgressHUD showStatusWith:nil In:self.view];
    [VVNetWorkTool postWithUrl:Url(LOGIN) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        NSLog(@"%@",result);
        NSDictionary *dic = result;
        LoginResultModel *loginResultModel = [[LoginResultModel alloc] init];
        [loginResultModel setValuesForKeysWithDictionary:dic];
        NSDictionary *data = [dic valueForKey:@"data"];
        [loginResultModel setValuesForKeysWithDictionary:data];
        self.loginResultModel = loginResultModel;
        if ([loginResultModel.code  isEqual: @1]){
            [JGProgressHUD showErrorWithModel:loginResultModel In:self.view];
//            //若未选择性别则跳转性别选选择界面
//            if (!loginResultModel.sex){
//                SexSelectController *sexSelectController = [[SexSelectController alloc] init];
//                sexSelectController.memberId = loginResultModel.memberId;
//                [self.navigationController pushViewController:sexSelectController animated:true];
//                return;
//            }
//            //若未选择用户基础信息则跳转基础信息填写界面
//            if (!loginResultModel.baseInfo){
//                UserBaseInfoFillInController *baseInfoFillInController = [[UserBaseInfoFillInController alloc] init];
//                baseInfoFillInController.memberId = loginResultModel.memberId;
//                [self.navigationController pushViewController:baseInfoFillInController animated:true];
//                return;
//            }
            //若都已选择则进入IM登录业务
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
        if ([loginResultModel.code isEqual:@1]){
            [self loginNTESWithAccid:loginResultModel.accid Token:loginResultModel.token];
        }
        [JGProgressHUD showErrorWithModel:loginResultModel In:self.view];
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
                                          [Helper saveMemberId:self.loginResultModel.memberId];
                                          [UIApplication sharedApplication].keyWindow.rootViewController = [[TabBarController alloc] init];
                                          //NTESMainTabController * mainTab = [[NTESMainTabController alloc] initWithNibName:nil bundle:nil];
                                          //[UIApplication sharedApplication].keyWindow.rootViewController = mainTab;
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
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:@"" forKey:@"mobilephone"];
    [parameters setValue:@"" forKey:@"pwd"];
    [parameters setValue:@"" forKey:@"surepwd"];
    [parameters setValue:@"" forKey:@"smscode"];

    [VVNetWorkTool postWithUrl:Url(REGISTER) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *model = [BaseModel new];
        [model setValuesForKeysWithDictionary:result];
        [JGProgressHUD showResultWithModel:model In:self.view];
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
            [UIApplication sharedApplication].keyWindow.rootViewController = [[TabBarController alloc] init];
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
