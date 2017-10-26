//
//  NickNameFillInController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/12.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "NickNameFillInController.h"

@interface NickNameFillInController ()
@property (weak, nonatomic) IBOutlet UITextField *nickNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UIButton *finishBtn;
@property (weak, nonatomic) IBOutlet UIButton *cancelBtn;

@end

@implementation NickNameFillInController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"昵称";
    self.titleLabel.font = FONT_WITH_S(17);
    self.finishBtn.titleLabel.font = FONT_WITH_S(17);
    self.cancelBtn.titleLabel.font = FONT_WITH_S(17);
}
- (IBAction)dealCancel:(id)sender {
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)dealFinish:(id)sender {
    if ([self.nickNameTextField.text length]){
        self.nickNameBlock(self.nickNameTextField.text);
    }
    [self dismissViewControllerAnimated:true completion:nil];
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
