//
//  FeedBackViewController.m
//  XingYuan
//
//  Created by 陈曦 on 2017/10/17.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "FeedBackViewController.h"

@interface FeedBackViewController ()<UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *placeHolder;

@property (weak, nonatomic) IBOutlet UILabel *stirngLenghLabel;
@end

@implementation FeedBackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"意见反馈";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"意见反馈";
    label.font = FONT_WITH_S(18);
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:label1];
    self.navigationItem.rightBarButtonItem = itme;
    self.navigationItem.titleView = label;
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    self.textView.delegate = self;
    self.placeHolder.userInteractionEnabled = NO;
    self.button.userInteractionEnabled = NO;
    [self.button addTarget:self action:@selector(buttonDidSelect:) forControlEvents:UIControlEventTouchUpInside];
    // Do any additional setup after loading the view from its nib.
}

// 将要开始编辑
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    self.placeHolder.hidden = YES;
    return YES;
}

//正在改变
- (void)textViewDidChange:(UITextView *)textView
{
    
    
    //允许提交按钮点击操作
    self.button.userInteractionEnabled = YES;
    //实时显示字数
    self.stirngLenghLabel.text = [NSString stringWithFormat:@"%lu/1500", (unsigned long)textView.text.length];
    
    //字数限制操作
    if (textView.text.length >= 1500) {
        
        textView.text = [textView.text substringToIndex:100];
        self.stirngLenghLabel.text = @"1500/1500";
        
    }
    
    //取消按钮点击权限，并显示提示文字
    if (textView.text.length == 0) {
        
        self.placeHolder.hidden = NO;
        self.button.userInteractionEnabled = NO;
        self.button.backgroundColor = RGBColor(215, 214, 214, 1);
        
    }else {
        self.button.backgroundColor = RGBColor(240, 52, 99, 1);
    }
    
}

- (void)buttonDidSelect:(UIButton *)button {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:self.textView.text forKey:@"content"];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
    [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
    [parameters setValue:[Helper sign] forKey:@"sign"];          //签名
    [VVNetWorkTool postWithUrl:Url(SubmitFeedBack) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        [JGProgressHUD showSuccessWith:@"意见反馈成功！" In:self.view];
        self.button.userInteractionEnabled = NO;
        self.button.backgroundColor = RGBColor(215, 214, 214, 1);
    } fail:^(NSError *error) {
        NSLog(@"%@",[error localizedDescription]);
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
