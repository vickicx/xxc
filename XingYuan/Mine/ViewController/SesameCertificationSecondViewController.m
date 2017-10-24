//
//  SesameCertificationSecondViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/16.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "SesameCertificationSecondViewController.h"

@interface SesameCertificationSecondViewController ()
@property (strong, nonatomic) IBOutlet UITextField *zhifubao;
@property (strong, nonatomic) IBOutlet UITextField *phoneCode;
@property (strong, nonatomic) IBOutlet UITextField *IDCode;
@property (strong, nonatomic) IBOutlet UIButton *codeButton;
@property (strong, nonatomic) IBOutlet UILabel *phone;
@property (strong, nonatomic) IBOutlet UIButton *subButton;

@property (strong, nonatomic) IBOutlet UIButton *checkButton;
#define COLOR(R, G, B, A) [UIColor colorWithRed:R/255.0 green:G/255.0 blue:B/255.0 alpha:A]

@end

@implementation SesameCertificationSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"芝麻信用授权";
    [self createView];
}
- (void)createView{
    
    [self.codeButton.layer setBorderColor:[UIColor colorWithRed:190/255.0 green:195/255.0 blue:199/255.0 alpha:1].CGColor];
    [self.codeButton.layer setBorderWidth:1];
    [self.codeButton.layer setMasksToBounds:YES];
    self.codeButton.clipsToBounds = YES;
    self.codeButton.layer.cornerRadius = 5;
    
    self.subButton.clipsToBounds = YES;
    self.subButton.layer.cornerRadius = 5;
    
}
//选中
- (IBAction)Select:(id)sender {
}
//验证码
- (IBAction)Code:(id)sender {
    [self timer];
}
//提交
- (IBAction)submit:(id)sender {
}

- (void)timer{
    [self.codeButton setTitle:@"60S" forState:UIControlStateNormal];
    [self.codeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    __block int timeout=5; //倒计时时间
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_source_t _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0,queue);
    dispatch_source_set_timer(_timer,dispatch_walltime(NULL, 0),1.0*NSEC_PER_SEC, 0); //每秒执行
    dispatch_source_set_event_handler(_timer, ^{
        if(timeout<=0){ //倒计时结束，关闭
            dispatch_source_cancel(_timer);
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                [_codeButton setTitle:@"发送验证码" forState:UIControlStateNormal];
                _codeButton.userInteractionEnabled = YES;
            });
        }else{
            int seconds = timeout % 60;
            NSString *strTime = [NSString stringWithFormat:@"%.2d", seconds];
            dispatch_async(dispatch_get_main_queue(), ^{
                //设置界面的按钮显示 根据自己需求设置
                //NSLog(@"____%@",strTime);
                [UIView beginAnimations:nil context:nil];
                [UIView setAnimationDuration:1];
                [_codeButton setTitle:[NSString stringWithFormat:@"%@",strTime] forState:UIControlStateNormal];
                [UIView commitAnimations];
                _codeButton.userInteractionEnabled = NO;
            });
            timeout--;
        }
    });
    dispatch_resume(_timer);
    
}

@end
