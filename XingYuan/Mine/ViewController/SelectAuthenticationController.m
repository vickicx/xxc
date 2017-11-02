//
//  SelectAuthenticationController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/27.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "SelectAuthenticationController.h"

@interface SelectAuthenticationController ()
@property (weak, nonatomic) IBOutlet UILabel *noticeLabel;
@property (weak, nonatomic) IBOutlet UILabel *certificationLabel;
//统一配置字体
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;
@property (strong,nonatomic) ThreeStageScreeningModel *threeStageScreeningModel;
@property (nonatomic,weak) UIButton *finishBtn;

//实名认证
@property (weak, nonatomic) IBOutlet UIButton *realNameBtn;
//手机认证
@property (weak, nonatomic) IBOutlet UIButton *phoneBtn;
//芝麻认证
@property (weak, nonatomic) IBOutlet UIButton *zhimaBtn;
//购房认证
@property (weak, nonatomic) IBOutlet UIButton *houseBtn;
//购车认证
@property (weak, nonatomic) IBOutlet UIButton *carBtn;

@end

@implementation SelectAuthenticationController

- (void)viewDidLoad {
    [super viewDidLoad];
//    self.title = @"我的认证";
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    label.text = @"我的认证";
    label.font = FONT_WITH_S(18);
    UILabel *label1 = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    UIBarButtonItem *itme = [[UIBarButtonItem alloc] initWithCustomView:label1];
    self.navigationItem.rightBarButtonItem = itme;
    self.navigationItem.titleView = label;
    
    UIButton *finishBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.finishBtn = finishBtn;
    [finishBtn setTitleColor:RGBColor(246, 80, 116, 1) forState:UIControlStateNormal];
    [finishBtn setTitle:@"完成" forState:UIControlStateNormal];
    finishBtn.titleLabel.font = FONT_WITH_S(16);
    [finishBtn sizeToFit];
    [finishBtn addTarget:self action:@selector(dealTapFinished) forControlEvents:UIControlEventTouchUpInside];
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithCustomView:finishBtn]];
    
    self.noticeLabel.font = FONT_WITH_S(14);
    self.certificationLabel.font = FONT_WITH_S(17);
    for(int i=0;i<self.labels.count;i++){
        UILabel *label = self.labels[i];
        label.font = FONT_WITH_S(14);
    }
    
    //请求原始数据
    [self requestPrimaryData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)requestPrimaryData{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    
    [VVNetWorkTool postWithUrl:Url(ShowMateSelectionMatchingThree) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        ThreeStageScreeningModel *model = [ThreeStageScreeningModel new];
        [model setValuesForKeysWithDictionary:result];
        [model setValuesForKeysWithDictionary:[result valueForKey:@"data"]];
        self.threeStageScreeningModel = model;
        [self refreshWithModel:model];
        [JGProgressHUD showErrorWithModel:model In:self.view];
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

- (void)refreshWithModel:(ThreeStageScreeningModel *)model{
    
    [self.phoneBtn setSelected:model.phoneauthentication];
    
    [self.realNameBtn setSelected:model.realnameauthentication];
    
    [self.zhimaBtn setSelected:model.zmxyauthentication];
    
    [self.houseBtn setSelected:model.buyhouseauthentication];
    
    [self.carBtn setSelected:model.buycarauthentication];

}

- (void)dealTapFinished{
    NSMutableDictionary *parameters = [self.threeStageScreeningModel mj_keyValues];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];

    [JGProgressHUD showStatusWith:nil In:self.view];
    [VVNetWorkTool postWithUrl:Url(SetMateSelectionMatchingThree) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *model = [BaseModel new];
        [model setValuesForKeysWithDictionary:result];
        [JGProgressHUD showResultWithModel:model In:self.view];
        if([model.code isEqual:@1]){
            if(self.callBackBlock != nil){
                self.callBackBlock(self.threeStageScreeningModel);
            }
            [self.navigationController popViewControllerAnimated:true];
        }
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

- (IBAction)dealSelectCertification:(UIButton *)sender {
    [sender setSelected:!sender.selected];
    if(sender.tag == 0){
        self.threeStageScreeningModel.realnameauthentication = sender.isSelected;
    }
    if(sender.tag == 1){
        self.threeStageScreeningModel.phoneauthentication = sender.isSelected;
    }
    if(sender.tag == 2){
        self.threeStageScreeningModel.zmxyauthentication = sender.isSelected;
    }
    if(sender.tag == 3){
        self.threeStageScreeningModel.buyhouseauthentication = sender.isSelected;
    }
    if(sender.tag == 4){
        self.threeStageScreeningModel.buycarauthentication = sender.isSelected;
    }
}

@end
