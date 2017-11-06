//
//  CertificationViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/16.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "CertificationViewController.h"
#import "FinishCertificationViewController.h"


@interface CertificationViewController ()

@end

@implementation CertificationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"实名认证";
    label.font = FONT_WITH_S(18);
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:label1];
    self.navigationItem.rightBarButtonItem = itme;
    self.navigationItem.titleView = label;

    [self createView];
    // Do any additional setup after loading the view from its nib.
}

- (void)createView {
    self.label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.label.textColor = RGBColor(184, 186, 189, 1);
    
    self.name.textColor = RGBColor(43, 48, 52, 1);
    self.line.backgroundColor = self.line1.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.button.backgroundColor = RGBColor(240, 53, 99, 1);
    self.button.layer.cornerRadius = 10.0f;
    [self.button addTarget:self action:@selector(buttonDidSelect:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)buttonDidSelect:(UIButton *)button {
    if(self.nameField.text.length == 0){
         [JGProgressHUD showSuccessWith:@"请输入姓名" In:self.view];
        
    }
    else if(![self verifyIDCardNumber:self.idNumberField.text]){
         [JGProgressHUD showSuccessWith:@"请输入正确身份证号码" In:self.view];
    }
    else
    {
        [self requestData];
    }
}
/**
 *  身份证号全校验
 */
- (BOOL)verifyIDCardNumber:(NSString *)IDCardNumber
{
    IDCardNumber = [IDCardNumber stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    if ([IDCardNumber length] != 18)
    {
        return NO;
    }
    NSString *mmdd = @"(((0[13578]|1[02])(0[1-9]|[12][0-9]|3[01]))|((0[469]|11)(0[1-9]|[12][0-9]|30))|(02(0[1-9]|[1][0-9]|2[0-8])))";
    NSString *leapMmdd = @"0229";
    NSString *year = @"(19|20)[0-9]{2}";
    NSString *leapYear = @"(19|20)(0[48]|[2468][048]|[13579][26])";
    NSString *yearMmdd = [NSString stringWithFormat:@"%@%@", year, mmdd];
    NSString *leapyearMmdd = [NSString stringWithFormat:@"%@%@", leapYear, leapMmdd];
    NSString *yyyyMmdd = [NSString stringWithFormat:@"((%@)|(%@)|(%@))", yearMmdd, leapyearMmdd, @"20000229"];
    NSString *area = @"(1[1-5]|2[1-3]|3[1-7]|4[1-6]|5[0-4]|6[1-5]|82|[7-9]1)[0-9]{4}";
    NSString *regex = [NSString stringWithFormat:@"%@%@%@", area, yyyyMmdd  , @"[0-9]{3}[0-9Xx]"];
    
    NSPredicate *regexTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", regex];
    if (![regexTest evaluateWithObject:IDCardNumber])
    {
        return NO;
    }
    int summary = ([IDCardNumber substringWithRange:NSMakeRange(0,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(10,1)].intValue) *7
    + ([IDCardNumber substringWithRange:NSMakeRange(1,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(11,1)].intValue) *9
    + ([IDCardNumber substringWithRange:NSMakeRange(2,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(12,1)].intValue) *10
    + ([IDCardNumber substringWithRange:NSMakeRange(3,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(13,1)].intValue) *5
    + ([IDCardNumber substringWithRange:NSMakeRange(4,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(14,1)].intValue) *8
    + ([IDCardNumber substringWithRange:NSMakeRange(5,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(15,1)].intValue) *4
    + ([IDCardNumber substringWithRange:NSMakeRange(6,1)].intValue + [IDCardNumber substringWithRange:NSMakeRange(16,1)].intValue) *2
    + [IDCardNumber substringWithRange:NSMakeRange(7,1)].intValue *1 + [IDCardNumber substringWithRange:NSMakeRange(8,1)].intValue *6
    + [IDCardNumber substringWithRange:NSMakeRange(9,1)].intValue *3;
    NSInteger remainder = summary % 11;
    NSString *checkBit = @"";
    NSString *checkString = @"10X98765432";
    checkBit = [checkString substringWithRange:NSMakeRange(remainder,1)];// 判断校验位
    return [checkBit isEqualToString:[[IDCardNumber substringWithRange:NSMakeRange(17,1)] uppercaseString]];
}

- (void)requestData {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:self.idNumberField.text forKey:@"idcard"];
    [parameters setValue:self.nameField.text forKey:@"realname"];
    [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
    [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
    [parameters setValue:[Helper sign] forKey:@"sign"];          //签名
    [VVNetWorkTool postWithUrl:Url(Realnameauthentication) body:[Helper parametersWith:parameters]
                      progress:nil success:^(id result) {
                        [JGProgressHUD showSuccessWith:[result objectForKey:@"msg"] In:self.view];
                          if ([[result objectForKey:@"code"] isEqualToString:@"1"]) {
                              FinishCertificationViewController *finishVC = [[FinishCertificationViewController alloc] init];
                              [self.navigationController pushViewController:finishVC animated:YES];
                          }
                      } fail:^(NSError *error) {
                        [JGProgressHUD showSuccessWith:error In:self.view];
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
