//
//  TwoStageScreeningController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/14.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "TwoStageScreeningController.h"
#import "DataPickerView.h"
#import "FourStageScreeningController.h"
#import "PickerDatas.h"
#import "TwoStateScreeningModel.h"
#import "HobbiesController.h"
#import "MyAttestationViewController.h"

@interface TwoStageScreeningController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic,strong) TwoStateScreeningModel *twoStateScreenModel;
@end

@implementation TwoStageScreeningController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"更进一步";
    
    self.cellTitles = @[@"兴趣爱好",@"个人学历",@"工作岗位",@"月收入",@"婚姻状况",@"子女情况",@"是否喝酒",@"是否吸烟",@"购房情况",@"购车情况",@"生活作息"];
    
    //网络请求
    self.twoStateScreenModel = [TwoStateScreeningModel new];
    [self requestPrimaryData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - misc
- (void)dealUploadInfo:(BOOL)isToNext{
    [super dealUploadInfo:isToNext];
    //网络请求，更新信息到服务器,并在网络回调中根据isToNext判断是否跳转下一页
    [self uploadInfoToServer:isToNext];
    
}

//请求已经服务器已经填写的数据
- (void)requestPrimaryData{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    //匹配
    NSString *url = Showmatchingtwo;
    //我的资料
    if(self.controllerType == ScreeningControllerTypeUpdatelocal){
        url = Showmatchingtwo;
    }else if(self.controllerType == ScreeningControllerTypeMateRequireMent){
        //择偶要求
        url = ShowMateSelectionMatchingTwo;
    }
    
    [VVNetWorkTool postWithUrl:Url(url) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        TwoStateScreeningModel *model = [TwoStateScreeningModel new];
        self.twoStateScreenModel = model;
        [model setValuesForKeysWithDictionary:result];
        [model setValuesForKeysWithDictionary:result[@"data"]];
        [self refreshWithModel:model];
        [JGProgressHUD showErrorWithModel:model In:self.view];
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

- (void)refreshWithModel:(TwoStateScreeningModel *)model{
    FillUserInfoCell *cell;
    
    //兴趣爱好
    cell = self.cells[0];
    if([model.interestids length]>0){
        cell.infoValue = @"已选择";
    }
    
    //个人学历
    cell = self.cells[1];
    cell.infoValue = model.educational;
    
    //工作岗位
    cell = self.cells[2];
    cell.infoValue = model.operatingpost;
    
    //月收入
    cell = self.cells[3];
    cell.infoValue = model.monthlyincome;
    
    //婚姻状况
    cell = self.cells[4];
    cell.infoValue = model.maritalstatus;
    
    //子女情况
    cell = self.cells[5];
    cell.infoValue = model.children;
    
    //是否喝酒
    cell = self.cells[6];
    cell.infoValue = model.drink;
    
    //是否吸烟
    cell = self.cells[7];
    cell.infoValue = model.smoking;
    
    //购房情况
    cell = self.cells[8];
    cell.infoValue = model.housesstatus;
    
    //购车情况
    cell = self.cells[9];
    cell.infoValue = model.carstatus;
    
    //生活作息
    cell = self.cells[10];
    cell.infoValue = model.workandrest;

//    interestids 兴趣爱好，格式：“1，2，3，4，5”
//    educational 个人学历
//    operatingpost 工作岗位
//    monthlyincome 月收入
//    maritalstatus 婚姻状态
//    children 子女情况
//    drink 是否喝酒
//    smoking 是否吸烟
//    housesstatus 购房情况
//    carstatus 购车情况
//    workandrest 生活作息
}


/**
 //保存数据到服务器
 @param isToNext 请求成功是否跳转下一页
 */
- (void)uploadInfoToServer:(BOOL)isToNext{
    [super dealUploadInfo:isToNext];
    NSMutableDictionary *parameters = [self.twoStateScreenModel mj_keyValues];
    parameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    
    NSString *url;
    if(self.controllerType == ScreeningControllerTypeUpdateToServer){
        url = Matchingtwo;
    }
    if(self.controllerType == ScreeningControllerTypeUpdatelocal){
        url = Matchingtwo;
    }
    if(self.controllerType == ScreeningControllerTypeMateRequireMent){
        url = SetMateSelectionMatchingTwo;
    }
    [JGProgressHUD showStatusWith:nil In:self.view];
    [VVNetWorkTool postWithUrl:Url(url) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *model = [BaseModel new];
        [model setValuesForKeysWithDictionary:result];
        [JGProgressHUD showResultWithModel:model In:self.view];
        if([model.code isEqual:@1] && isToNext){
            MyAttestationViewController *attestationViewController = [[MyAttestationViewController alloc] initWithType:AttestationControllerTypeScreening];
            [self.navigationController pushViewController:attestationViewController animated:true];
        }
        if([model.code isEqual:@1] && !isToNext){
            if(self.block != nil){
                self.block(self.twoStateScreenModel);
            }
            [self.navigationController popViewControllerAnimated:true];
        }
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

#pragma mark - UITableViewDataSource,UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //兴趣爱好
    if(indexPath.row == 1){
        HobbiesController *hobbiesController;
        if(self.controllerType == ScreeningControllerTypeMateRequireMent){
            hobbiesController = [[HobbiesController alloc] initWithControllerType:HobbiesControllerTypeMateRequirement];
            hobbiesController.interestids = self.twoStateScreenModel.interestids;
        }else{
            hobbiesController = [[HobbiesController alloc] init];
        }
        hobbiesController.hobbiesBlock = ^(NSString *interestids,NSString *hobbiesNames){
            self.twoStateScreenModel.interestids = interestids;
            self.twoStateScreenModel.interestnames = hobbiesNames;
            [self refreshWithModel:self.twoStateScreenModel];
        };
        [self.navigationController pushViewController:hobbiesController animated:true];
    }
    //个人学历
    if(indexPath.row == 2){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas educations] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.twoStateScreenModel.educational = value;
            [self refreshWithModel:self.twoStateScreenModel];
        }];
        [dataPickerView toShow];
    }
    //工作岗位
    if(indexPath.row == 3){

        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas stations] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.twoStateScreenModel.operatingpost = value;
            [self refreshWithModel:self.twoStateScreenModel];
        }];
        [dataPickerView toShow];
    }
    //月收入
    if(indexPath.row == 4){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas monthlyIncome] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.twoStateScreenModel.monthlyincome = value;
            [self refreshWithModel:self.twoStateScreenModel];
        }];
        [dataPickerView toShow];
    }
    //婚姻状况
    if(indexPath.row == 5){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas maritalStatus] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.twoStateScreenModel.maritalstatus = value;
            [self refreshWithModel:self.twoStateScreenModel];
        }];
        [dataPickerView toShow];
    }
    //子女情况
    if(indexPath.row == 6){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas childStatus] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.twoStateScreenModel.children = value;
            [self refreshWithModel:self.twoStateScreenModel];
        }];
        [dataPickerView toShow];
    }
    //是否饮酒
    if(indexPath.row == 7){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas isDrink] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.twoStateScreenModel.drink = value;
            [self refreshWithModel:self.twoStateScreenModel];
        }];
        [dataPickerView toShow];
    }
    //是否吸烟
    if(indexPath.row == 8){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas isSmoking] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.twoStateScreenModel.smoking = value;
            [self refreshWithModel:self.twoStateScreenModel];
        }];
        [dataPickerView toShow];
    }
    //购房情况
    if(indexPath.row == 9){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas housePurchaseStatus] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.twoStateScreenModel.housesstatus = value;
            [self refreshWithModel:self.twoStateScreenModel];
        }];
        [dataPickerView toShow];
    }
    //购车情况
    if(indexPath.row == 10){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas carPurchaseStatus] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.twoStateScreenModel.carstatus = value;
            [self refreshWithModel:self.twoStateScreenModel];
        }];
        [dataPickerView toShow];
    }
    //生活作息
    if(indexPath.row == 11){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas lifeRestInfos] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            self.twoStateScreenModel.workandrest = value;
            [self refreshWithModel:self.twoStateScreenModel];
        }];
        [dataPickerView toShow];
    }
}
@end
