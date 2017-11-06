//
//  SexSelectController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/11.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "SexSelectController.h"
#import "UserBaseInfoFillInController.h"
@interface SexSelectController ()
@property (weak, nonatomic) IBOutlet UILabel *maleLabel;
@property (weak, nonatomic) IBOutlet UILabel *femaleLabel;

@property (weak, nonatomic) IBOutlet UILabel *messageLabel;
@property (weak, nonatomic) IBOutlet UILabel *noticeLabe;

@end

@implementation SexSelectController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"性别选择";
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    
    self.maleLabel.font = FONT_WITH_S(17);
    self.femaleLabel.font = FONT_WITH_S(17);
    
    self.messageLabel.font = FONT_WITH_S(16);
    self.noticeLabe.font = FONT_WITH_S(14);
}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    [self.navigationController.navigationBar setBackgroundColor:[UIColor clearColor]];
}

- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//选中了男性
- (IBAction)dealSelectMan:(UIButton *)sender {
    [self setSexWith:@1];
}

//选中了女性
- (IBAction)dealSelectWomen:(UIButton *)sender {
    [self setSexWith:@2];
}

- (void)setSexWith:(NSNumber *)sex{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:self.loginResultModel.memberId forKey:@"memberid"];
    [parameters setValue:sex forKey:@"sex"];
    [JGProgressHUD showStatusWith:nil In:self.view];
    [VVNetWorkTool postWithUrl:Url(SetMemberSex) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *model = [BaseModel new];
        [model setValuesForKeysWithDictionary:result];
        [JGProgressHUD showErrorWithModel:model In:self.view];
        if ([model.code isEqual:@1]){
            UserBaseInfoFillInController *baseInfoFillInController = [[UserBaseInfoFillInController alloc] init];
            baseInfoFillInController.loginResultModel = self.loginResultModel;
            [self.navigationController pushViewController:baseInfoFillInController animated:true];
        }
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}
@end
