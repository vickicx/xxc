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

@end

@implementation NickNameFillInController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"昵称";
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
