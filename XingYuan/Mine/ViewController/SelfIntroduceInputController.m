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
    if([self.textView.text isEqual:nil] || [self.textView.text length]<=0){
        [JGProgressHUD showErrorWith:@"介绍不能为空" In:self.view];
    }else{
        [self setArtistIntroduction];
    }
}

- (void)setArtistIntroduction {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:self.textView.text forKey:@"summary"];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    __weak __typeof(self)weakSelf = self;
    [JGProgressHUD showStatusWith:nil In:self.view];
    [VVNetWorkTool postWithUrl:Url(SetArtistIntroduction) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *model = [BaseModel new];
        [model setValuesForKeysWithDictionary:result];
        [JGProgressHUD showErrorWithModel:model In:self.view];
        if([model.code isEqual:@1]){
            if(self.callBackBlock != nil){
                self.callBackBlock(self.textView.text);
            }
            [weakSelf.navigationController popViewControllerAnimated:YES];
        }
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}



- (void)getdata {
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
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
