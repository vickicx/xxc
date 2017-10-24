//
//  FourStageScreeningController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/16.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "FourStageScreeningController.h"
#import "FillUserInfoNoticeHeaderView.h"
#import "FillUserInfoNextFooterView.h"
#import "BasiceInfoCell.h"
#import "FillUserInfoCell.h"
#import "DataPickerView.h"
#import "AddressPickerView.h"
#import "PickerDatas.h"
#import "FiveStageScreeningController.h"
#import "FourStageScreeningModel.h"

@interface FourStageScreeningController ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation FourStageScreeningController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"情投意合";
    
    self.cellTitles = @[@"家乡",@"户口",@"民族",@"属相",@"家庭排行",@"父母情况",@"父亲工作",@"母亲工作",@"父母经济",@"父母医保"];

    //网络请求
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
    
    [VVNetWorkTool postWithUrl:Url(ShowmatchingFour) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        FourStageScreeningModel *model = [FourStageScreeningModel new];
        [model setValuesForKeysWithDictionary:result];
        [model setValuesForKeysWithDictionary:result[@"data"]];
        [self refreshWithModel:model];
        [JGProgressHUD showErrorWithModel:model In:self.view];
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

- (void)refreshWithModel:(FourStageScreeningModel *)model{
    FillUserInfoCell *cell;
    
    //家乡
    cell = self.cells[0];
    cell.infoValue = model.hometown;
    
    //户口
    cell = self.cells[1];
    cell.infoValue = model.householdregister;
    
    //民族
    cell = self.cells[2];
    cell.infoValue = model.nation;
    
    //属相
    cell = self.cells[3];
    cell.infoValue = model.sx;
    
    //家庭排行
    cell = self.cells[4];
    cell.infoValue = model.familyranking;
    
    //父母情况
    cell = self.cells[5];
    cell.infoValue = model.parentstatus;
    
    //父亲工作
    cell = self.cells[6];
    cell.infoValue = model.fatherwork;
    
    //母亲工作
    cell = self.cells[7];
    cell.infoValue = model.motherwork;
    
    //父母经济
    cell = self.cells[8];
    cell.infoValue = model.parenteconomic;
    
    //父母医保
    cell = self.cells[9];
    cell.infoValue = model.parentmedicalinsurance;

//    hometown 家乡
//    householdregister 户口
//    nation 民族
//    sx 属相
//    familyranking 家庭排行
//    parentstatus 父母情况
//    fatherwork 父亲工作
//    motherwork 母亲工作
//    parenteconomic 父母经济
//    parentmedicalinsurance 父母医保
}


/**
 //保存数据到服务器
 @param isToNext 请求成功是否跳转下一页
 */
- (void)uploadInfoToServer:(BOOL)isToNext{
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    
    FillUserInfoCell *cell;
    
    //家庭
    cell = self.cells[0];
    [parameters setValue:cell.infoValue forKey:@"hometown"];
    //户口
    cell = self.cells[1];
    [parameters setValue:cell.infoValue forKey:@"householdregister"];
    //民族
    cell = self.cells[2];
    [parameters setValue:cell.infoValue forKey:@"nation"];
    //属相
    cell = self.cells[3];
    [parameters setValue:cell.infoValue forKey:@"sx"];
    //家庭排行
    cell = self.cells[4];
    [parameters setValue:cell.infoValue forKey:@"familyranking"];
    //父母情况
    cell = self.cells[5];
    [parameters setValue:cell.infoValue forKey:@"parentstatus"];
    //父亲工作
    cell = self.cells[6];
    [parameters setValue:cell.infoValue forKey:@"fatherwork"];
    //母亲工作
    cell = self.cells[7];
    [parameters setValue:cell.infoValue forKey:@"motherwork"];
    //父母经济
    cell = self.cells[8];
    [parameters setValue:cell.infoValue forKey:@"parenteconomic"];
    //父母医保
    cell = self.cells[9];
    [parameters setValue:cell.infoValue forKey:@"parentmedicalinsurance"];
    
    [JGProgressHUD showStatusWith:nil In:self.view];
    [VVNetWorkTool postWithUrl:Url(MatchingFour) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *model = [BaseModel new];
        [model setValuesForKeysWithDictionary:result];
        [JGProgressHUD showResultWithModel:model In:self.view];
        if([model.code isEqual:@1] && isToNext){
            FiveStageScreeningController *screeningVC = [[FiveStageScreeningController alloc] initWithType:ScreeningControllerTypeUpdateToServer basicInfoCellPreTitle:@"嘿嘿嘿"];
            [self.navigationController pushViewController:screeningVC animated:true];
        }
        if([model.code isEqual:@1] && !isToNext){
            [self.navigationController popViewControllerAnimated:true];
        }
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}


#pragma mark - UITableViewDataSource,UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //家乡
    if(indexPath.row == 1){
        AddressPickerView *addressPickerView = [AddressPickerView addressPickerView];
        addressPickerView.block = ^(NSString *province,NSString *city){
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = [province stringByAppendingString:city];
        };
        [addressPickerView toShow];
    }
    //户口
    if(indexPath.row == 2){
        AddressPickerView *addressPickerView = [AddressPickerView addressPickerView];
        addressPickerView.block = ^(NSString *province,NSString *city){
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = [province stringByAppendingString:city];
        };
        [addressPickerView toShow];
    }
    //民族
    if(indexPath.row == 3){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas nations] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = value;
        }];
        [dataPickerView toShow];
    }
    //属相
    if(indexPath.row == 4){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas zodiacs] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = value;
        }];
        [dataPickerView toShow];
    }
    //家庭排行
    if(indexPath.row == 5){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas familyRank] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = value;
        }];
        [dataPickerView toShow];
    }
    //父母情况
    if(indexPath.row == 6){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas parentsSituations] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = value;
        }];
        [dataPickerView toShow];
    }
    //父亲工作
    if(indexPath.row == 7){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas stations] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = value;
        }];
        [dataPickerView toShow];
    }
    //母亲工作
    if(indexPath.row == 8){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas stations] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = value;
        }];
        [dataPickerView toShow];
    }
    //父母经济
    if(indexPath.row == 9){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas parentsEconomics] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = value;
        }];
        [dataPickerView toShow];
    }
    //父母医保
    if(indexPath.row == 10){
        DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas parentsMedicalInsurance] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = value;
        }];
        [dataPickerView toShow];
    }
}

@end
