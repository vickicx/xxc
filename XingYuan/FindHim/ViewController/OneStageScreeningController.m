//
//  OneStageScreeningController.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/13.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "OneStageScreeningController.h"
#import "NickNameFillInController.h"
#import "DatePickerView.h"
#import "AddressPickerView.h"
#import "TwoStageScreeningController.h"
#import "OneStageScreeningModel.h"
#import "ScreeningController.h"
#import "DataPickerView.h"
#import "PickerDatas.h"
#import "AgeRangePickerView.h"
#import "HeightRangePickerView.h"

@interface OneStageScreeningController ()<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic,strong) OneStageScreeningModel *oneStageScreeningModel;
@end

@implementation OneStageScreeningController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"初次相识";
    self.oneStageScreeningModel = [OneStageScreeningModel new];
    if(self.controllerType != ScreeningControllerTypeMateRequireMent){
        self.cellTitles = @[@"昵称",@"生日",@"身高",@"地区",@"星座",@"体型",@"相貌自评"];
    }else{
        self.cellTitles = @[@"年龄",@"身高",@"地区",@"星座",@"体型",@"相貌自评"];
    }

    [self requestPrimaryData];
}

- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark --misc

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
    NSString *url = Showmatchingone;
    //我的资料
    if(self.controllerType == ScreeningControllerTypeUpdatelocal){
        url = Showmatchingone;
    }else if(self.controllerType == ScreeningControllerTypeMateRequireMent){
        //择偶要求
        url = ShowMateSelectionMatchingOne;
    }
    
    [VVNetWorkTool postWithUrl:Url(url) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        OneStageScreeningModel *model = [OneStageScreeningModel new];
        [model setValuesForKeysWithDictionary:result];
        [model setValuesForKeysWithDictionary:result[@"data"]];
        self.oneStageScreeningModel = model;
        [self refreshWithModel:model];
        [JGProgressHUD showErrorWithModel:model In:self.view];
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

/**
 //保存数据到服务器
 @param isToNext 请求成功是否跳转下一页
 */
- (void)uploadInfoToServer:(BOOL)isToNext{
    NSMutableDictionary *parameters = [self.oneStageScreeningModel mj_keyValues];
    parameters = [[NSMutableDictionary alloc] initWithDictionary:parameters];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];

    NSString *url;
    if(self.controllerType == ScreeningControllerTypeUpdateToServer){
        url = Matchingone;
    }
    if(self.controllerType == ScreeningControllerTypeUpdatelocal){
        url = Matchingone;
    }
    if(self.controllerType == ScreeningControllerTypeMateRequireMent){
        url = SetMateSelectionMatchingOne;
    }
    [JGProgressHUD showStatusWith:nil In:self.view];
    [VVNetWorkTool postWithUrl:Url(url) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *model = [BaseModel new];
        [model setValuesForKeysWithDictionary:result];
        [JGProgressHUD showResultWithModel:model In:self.view];
        if([model.code isEqual:@1] && isToNext){
            TwoStageScreeningController *screeningVC = [[TwoStageScreeningController alloc] initWithType:ScreeningControllerTypeUpdateToServer basicInfoCellPreTitle:@"嘿嘿嘿"];
            [self.navigationController pushViewController:screeningVC animated:true];
        }
        if([model.code isEqual:@1] && !isToNext){
            if(self.block != nil){
                self.block(self.oneStageScreeningModel);
            }
            [self.navigationController popViewControllerAnimated:true];
        }
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

- (void)refreshWithModel:(OneStageScreeningModel *)model{
    FillUserInfoCell *cell;
    if(self.controllerType != ScreeningControllerTypeMateRequireMent){
        //昵称
        cell = self.cells[0];
        cell.infoValue = model.nickname;
        
        //生日
        cell = self.cells[1];
        cell.infoValue = model.birthday;
        
        //身高
        cell = self.cells[2];
        cell.infoValue = model.stature;
        
        //地区
        cell = self.cells[3];
        cell.infoValue = model.address;
        
        //星座
        cell = self.cells[4];
        cell.infoValue = model.constellation;
        
        //体型
        cell = self.cells[5];
        cell.infoValue = model.physique;
        
        //相貌自评
        cell = self.cells[6];
        cell.infoValue = model.facialfeatures;
    }else{
        //择偶
        
        //年龄
        cell = self.cells[0];
        cell.infoValue = model.age;
        
        //身高
        cell = self.cells[1];
        cell.infoValue = model.stature;
        
        //地区
        cell = self.cells[2];
        cell.infoValue = model.address;
        
        //星座
        cell = self.cells[3];
        cell.infoValue = model.constellation;
        
        //体型
        cell = self.cells[4];
        cell.infoValue = model.physique;
        
        //相貌自评
        cell = self.cells[5];
        cell.infoValue = model.facialfeatures;
    }
    
//    address = "\U4e0a\U6d77\U5e02\U4e0a\U6d77\U5e02";
//    birthday = "1992-11-18";
//    constellation = "\U5929\U874e\U5ea7";
//    facialfeatures = "10\U5206";
//    nickname = "\U5730\U60a8";
//    physique = "\U5747\U5300";
//    stature = 127cm;
}

#pragma mark --UITableViewDelegate,UITableViewDataSource

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if(self.controllerType != ScreeningControllerTypeMateRequireMent){
        //
        //昵称
        if(indexPath.row == 1){
            NickNameFillInController *nickNameFillInController = [[NickNameFillInController alloc] init];
            nickNameFillInController.nickNameBlock = ^(NSString *nickName){
                self.oneStageScreeningModel.nickname = nickName;
                [self refreshWithModel:self.oneStageScreeningModel];
            };
            [self presentViewController:nickNameFillInController animated:true completion:nil];
        }
        //生日
        if(indexPath.row == 2){
            DatePickerView *datePickerView = [DatePickerView datePickerView];
            datePickerView.datePickerBlock = ^(NSDate *date){
                NSDateFormatter *formater = [[NSDateFormatter alloc] init];
                [formater setDateFormat:@"yyyy-MM-dd"];//设置时间显示的格式，此处使用的formater格式要与字符串格式完全一致，否则转换失败
                NSString *dateStr = [formater stringFromDate:date];//将日期转换成字符串
                
                self.oneStageScreeningModel.birthday = dateStr;
                [self refreshWithModel:self.oneStageScreeningModel];
            };
            datePickerView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
            [[[UIApplication sharedApplication] keyWindow] addSubview:datePickerView];
        }
        //身高
        if(indexPath.row == 3){
            DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas heights] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
                self.oneStageScreeningModel.stature = value;
                [self refreshWithModel:self.oneStageScreeningModel];
            }];
            [dataPickerView toShow];
        }
        //地区
        if(indexPath.row == 4){
            AddressPickerView *addressPickerView = [AddressPickerView addressPickerView];
            addressPickerView.block = ^(NSString *province, NSString *city){
                NSString *address = [NSString stringWithFormat:@"%@ %@",province,city];
                self.oneStageScreeningModel.address = address;
                [self refreshWithModel:self.oneStageScreeningModel];
            };
            addressPickerView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
            [[[UIApplication sharedApplication] keyWindow] addSubview:addressPickerView];
        }
        //星座
        if(indexPath.row == 5){
            DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas constellations] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
                self.oneStageScreeningModel.constellation = value;
                [self refreshWithModel:self.oneStageScreeningModel];
            }];
            [dataPickerView toShow];
        }
        //体型
        if(indexPath.row == 6){
            DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas bodyShaps] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
                self.oneStageScreeningModel.physique = value;
                [self refreshWithModel:self.oneStageScreeningModel];
            }];
            [dataPickerView toShow];
        }
        //相貌自评
        if(indexPath.row == 7){
            DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas lookEvaluates] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
                self.oneStageScreeningModel.facialfeatures = value;
                [self refreshWithModel:self.oneStageScreeningModel];
            }];
            [dataPickerView toShow];
        }
    }else{
        //择偶条件
        
        //年龄
        if(indexPath.row == 1){
            AgeRangePickerView *ageRangePickerView = [AgeRangePickerView pickerViewWithBlock:^(NSInteger smallValue, NSInteger bigValue) {
                self.oneStageScreeningModel.age = [NSString stringWithFormat:@"%lu-%lu",smallValue,bigValue];
                [self refreshWithModel:self.oneStageScreeningModel];
            }];
            [ageRangePickerView toShow];
        }
        //身高
        if(indexPath.row == 2){
            HeightRangePickerView *heightRangePickerView = [HeightRangePickerView pickerViewWithBlock:^(NSInteger smallValue, NSInteger bigValue) {
                self.oneStageScreeningModel.stature = [NSString stringWithFormat:@"%lu-%lu",smallValue,bigValue];
                [self refreshWithModel:self.oneStageScreeningModel];
            }];
            [heightRangePickerView toShow];
        }
        //地区
        if(indexPath.row == 3){
            AddressPickerView *addressPickerView = [AddressPickerView addressPickerView];
            addressPickerView.block = ^(NSString *province, NSString *city){
                NSString *address = [NSString stringWithFormat:@"%@ %@",province,city];
                self.oneStageScreeningModel.address = address;
                [self refreshWithModel:self.oneStageScreeningModel];
            };
            addressPickerView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
            [[[UIApplication sharedApplication] keyWindow] addSubview:addressPickerView];
        }
        //星座
        if(indexPath.row == 4){
            DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas constellations] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
                self.oneStageScreeningModel.constellation = value;
                [self refreshWithModel:self.oneStageScreeningModel];
            }];
            [dataPickerView toShow];
        }
        //体型
        if(indexPath.row == 5){
            DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas bodyShaps] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
                self.oneStageScreeningModel.physique = value;
                [self refreshWithModel:self.oneStageScreeningModel];
            }];
            [dataPickerView toShow];
        }
        //相貌自评
        if(indexPath.row == 6){
            DataPickerView *dataPickerView = [DataPickerView pickerViewWithDataArray:[PickerDatas lookEvaluates] initialSelectRow:0 dataPickerBlock:^(NSString *value) {
                self.oneStageScreeningModel.facialfeatures = value;
                [self refreshWithModel:self.oneStageScreeningModel];
            }];
            [dataPickerView toShow];
        }
    }
}
@end
