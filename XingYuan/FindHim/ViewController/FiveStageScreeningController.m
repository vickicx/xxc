//
//  FiveStageScreeningController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/16.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "FiveStageScreeningController.h"
#import "DataPickerView.h"
#import "AddressPickerView.h"
#import "PickerDatas.h"
#import "FiveStageScreeningModel.h"

@interface FiveStageScreeningController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) FiveStageScreeningModel *fiveStageScreeningModel;
@end

@implementation FiveStageScreeningController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"珠联璧合";
    self.fiveStageScreeningModel = [FiveStageScreeningModel new];
    self.cellTitles = @[@"想何时结婚",@"偏爱约会方式",@"希望对方看中",@"期待婚礼形式",@"愿与对方父母住否",@"是否想要孩子",@"厨艺情况",@"家务分工"];

    //网络请求
    [self requestPrimaryData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - misc

- (void)dealUploadInfo:(BOOL)isToNext{
    [super dealUploadInfo:isToNext];
    [self uploadInfoToServer:isToNext];
}

//请求已经服务器已经填写的数据
- (void)requestPrimaryData{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    
    //匹配
    NSString *url = Showmatchingfive;
    //我的资料
    if(self.controllerType == ScreeningControllerTypeUpdatelocal){
        url = Showmatchingfive;
    }else if(self.controllerType == ScreeningControllerTypeMateRequireMent){
        //择偶要求
        url = ShowMateSelectionMatchingFive;
    }
    
    [VVNetWorkTool postWithUrl:Url(url) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        FiveStageScreeningModel *model = [FiveStageScreeningModel new];
        [model setValuesForKeysWithDictionary:result];
        [model setValuesForKeysWithDictionary:result[@"data"]];
        self.fiveStageScreeningModel = model;
        [self refreshWithModel:model];
        [JGProgressHUD showErrorWithModel:model In:self.view];
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

- (void)refreshWithModel:(FiveStageScreeningModel *)model{
    FillUserInfoCell *cell;
    
    //想何时结婚
    cell = self.cells[0];
    cell.infoValue = model.getmarriedtime;
    
    //偏爱约会方式
    cell = self.cells[1];
    cell.infoValue = model.datingpattern;
    
    //希望对方看中
    cell = self.cells[2];
    cell.infoValue = model.hopeotherlike;
    
    //希望婚礼形式
    cell = self.cells[3];
    cell.infoValue = model.weddingform;
    
    //愿与对方父母住否
    cell = self.cells[4];
    cell.infoValue = model.livingwithbothparents;
    
    //是否想要孩子
    cell = self.cells[5];
    cell.infoValue = model.wanthavechildren;
    
    //厨艺
    cell = self.cells[6];
    cell.infoValue = model.cookingskill;
    
    //家务分工
    cell = self.cells[7];
    cell.infoValue = model.householdduties;
    
//    getmarriedtime 想何时结婚
//    datingpattern 偏爱约会方式
//    hopeotherlike 希望对方看中
//    weddingform 希望婚礼形式
//    livingwithbothparents 愿与对方父母住否
//    wanthavechildren 是否想要孩子
//    cookingskill 厨艺
//    householdduties 家务分工
}


/**
 //保存数据到服务器
 @param isToNext 请求成功是否跳转下一页
 */
- (void)uploadInfoToServer:(BOOL)isToNext{
    NSMutableDictionary *parameters = [self.fiveStageScreeningModel mj_keyValues];
    parameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    
    NSString *url;
    if(self.controllerType == ScreeningControllerTypeUpdateToServer){
        url = Matchingfive;
    }
    if(self.controllerType == ScreeningControllerTypeUpdatelocal){
        url = Matchingfive;
    }
    if(self.controllerType == ScreeningControllerTypeMateRequireMent){
        url = SetMateSelectionMatchingFive;
    }
    [JGProgressHUD showStatusWith:nil In:self.view];
    [VVNetWorkTool postWithUrl:Url(url) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *model = [BaseModel new];
        [model setValuesForKeysWithDictionary:result];
        [JGProgressHUD showResultWithModel:model In:self.view];
        if([model.code isEqual:@1]){
            if(self.block != nil){
                self.block(self.fiveStageScreeningModel);
            }
            [self.navigationController popViewControllerAnimated:true];
        }
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}


#pragma mark - UITableViewDataSource,UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0.001;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    //想要何时结婚
    if(indexPath.row == 1){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas weddingTime] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.fiveStageScreeningModel.getmarriedtime = value;
            [self refreshWithModel:self.fiveStageScreeningModel];
        }];
        [dataPickerView toShow];
    }
    //偏爱约会方式
    if(indexPath.row == 2){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas datingModel] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.fiveStageScreeningModel.datingpattern = value;
            [self refreshWithModel:self.fiveStageScreeningModel];
        }];
        [dataPickerView toShow];
    }
    //希望对方看中
    if(indexPath.row == 3){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas hopeOtherImportance] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.fiveStageScreeningModel.hopeotherlike = value;
            [self refreshWithModel:self.fiveStageScreeningModel];
        }];
        [dataPickerView toShow];
    }
    //期待婚礼形式
    if(indexPath.row == 4){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas hopeWeddingForm] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.fiveStageScreeningModel.weddingform = value;
            [self refreshWithModel:self.fiveStageScreeningModel];
        }];
        [dataPickerView toShow];
    }
    //愿与对方父母住否
    if(indexPath.row == 5){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas liveWithOtherParents] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.fiveStageScreeningModel.livingwithbothparents = value;
            [self refreshWithModel:self.fiveStageScreeningModel];
        }];
        [dataPickerView toShow];
    }
    //是否想要孩子
    if(indexPath.row == 6){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas wantChildren] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.fiveStageScreeningModel.wanthavechildren = value;
            [self refreshWithModel:self.fiveStageScreeningModel];
        }];
        [dataPickerView toShow];
    }
    //厨艺情况
    if(indexPath.row == 7){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas cookingSkill] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.fiveStageScreeningModel.cookingskill = value;
            [self refreshWithModel:self.fiveStageScreeningModel];
        }];
        [dataPickerView toShow];
    }
    //家务分工
    if(indexPath.row == 8){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas houseworkDivision] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.fiveStageScreeningModel.householdduties = value;
            [self refreshWithModel:self.fiveStageScreeningModel];
        }];
        [dataPickerView toShow];
    }
}

@end
