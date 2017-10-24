//
//  SelfIntroduceInputController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/17.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "SelfIntroduceInputController.h"

@interface SelfIntroduceInputController ()<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *placeHolderLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *wordsNumLabel;
@property (nonatomic,assign) NSInteger limitNum;
@end

@implementation SelfIntroduceInputController

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self getdata];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"个人信息";
    self.placeHolderLabel.text = @"请对自己进行简要介绍";
    self.textView.delegate = self;
    self.limitNum = 30;
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(buttonDidselect:)];
    self.navigationItem.rightBarButtonItem.tintColor = RGBColor(240, 53, 99, 1);
}

- (void)buttonDidselect:(UIButton *)button {
    if (self.textView.text == nil) {
        self.placeHolderLabel.hidden = NO;
        self.placeHolderLabel.text = @"请对自己进行简要介绍";
    } else {
        [self setArtistIntroduction];
    }
    
}

- (void)setArtistIntroduction {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:self.textView.text forKey:@"summary"];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
    [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
    [parameters setValue:[Helper sign] forKey:@"sign"];          //签名
    __weak __typeof(self)weakSelf = self;
    [VVNetWorkTool postWithUrl:Url(SetArtistIntroduction) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        [weakSelf.navigationController popViewControllerAnimated:YES];
    } fail:^(NSError *error) {
        
    }];
}



- (void)getdata {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    [parameters setValue:[Helper randomnumber] forKey:@"randomnumber"];  //100-999整随机数
    [parameters setValue:[Helper timeStamp] forKey:@"timestamp"];     //时间戳
    [parameters setValue:[Helper sign] forKey:@"sign"];          //签名
    [VVNetWorkTool postWithUrl:Url(MyArtistIntroduction) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        NSDictionary *dic = result;
        NSString *summary = [[dic objectForKey:@"data"] valueForKey:@"summary"];
        if (summary != nil) {
            self.textView.text = summary;
            self.placeHolderLabel.hidden = YES;
        }
        
    } fail:^(NSError *error) {
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView{
    if([textView.text length] > 0){
        [self.wordsNumLabel setHidden:false];
    }else{
        [self.placeHolderLabel setHidden:false];
        [self.wordsNumLabel setHidden:true];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView{
    [self.placeHolderLabel setHidden:true];
    [self.wordsNumLabel setHidden:false];
}

//字数发生变化
- (void)textViewDidChange:(UITextView *)textView{
    if([textView.text length]>self.limitNum){
        self.textView.text = [self.textView.text substringToIndex:self.limitNum];
    }else{
        
    }
    self.wordsNumLabel.text = [NSString stringWithFormat:@"%lu/%ld",[textView.text length],(long)self.limitNum];
}
@end
