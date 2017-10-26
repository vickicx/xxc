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
#import "HeightPickerView.h"
#import "AddressPickerView.h"
#import "BodyShapPickerView.h"
#import "ConstellationPickerView.h"
#import "LooksEvaluatePickerView.h"
#import "TwoStageScreeningController.h"
#import "OneStageScreeningModel.h"
#import "ScreeningController.h"

@interface OneStageScreeningController ()<UITableViewDelegate,UITableViewDataSource>
@end

@implementation OneStageScreeningController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"初次相识";

    self.cellTitles = @[@"昵称",@"生日",@"身高",@"地区",@"星座",@"体型",@"相貌自评"];

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
    
    [VVNetWorkTool postWithUrl:Url(Showmatchingone) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        OneStageScreeningModel *model = [OneStageScreeningModel new];
        [model setValuesForKeysWithDictionary:result];
        [model setValuesForKeysWithDictionary:result[@"data"]];
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
    NSMutableDictionary *parameters = [NSMutableDictionary new];
    [parameters setValue:[Helper memberId] forKey:@"memberid"];
    
    FillUserInfoCell *cell;
    
    //昵称
    cell = self.cells[0];
    [parameters setValue:cell.infoValue forKey:@"nickname"];
    //生日
    cell = self.cells[1];
    [parameters setValue:cell.infoValue forKey:@"birthday"];
    //身高
    cell = self.cells[2];
    [parameters setValue:cell.infoValue forKey:@"stature"];
    //地区
    cell = self.cells[3];
    [parameters setValue:cell.infoValue forKey:@"address"];
    //星座
    cell = self.cells[4];
    [parameters setValue:cell.infoValue forKey:@"constellation"];
    //体型
    cell = self.cells[5];
    [parameters setValue:cell.infoValue forKey:@"physique"];
    //相貌自评
    cell = self.cells[6];
    [parameters setValue:cell.infoValue forKey:@"facialfeatures"];

    [JGProgressHUD showStatusWith:nil In:self.view];
    [VVNetWorkTool postWithUrl:Url(Matchingone) body:[Helper parametersWith:parameters] progress:nil success:^(id result) {
        BaseModel *model = [BaseModel new];
        [model setValuesForKeysWithDictionary:result];
        [JGProgressHUD showResultWithModel:model In:self.view];
        if([model.code isEqual:@1] && isToNext){
            TwoStageScreeningController *screeningVC = [[TwoStageScreeningController alloc] initWithType:ScreeningControllerTypeUpdateToServer basicInfoCellPreTitle:@"嘿嘿嘿"];
            [self.navigationController pushViewController:screeningVC animated:true];
        }
        if([model.code isEqual:@1] && !isToNext){
            [self.navigationController popViewControllerAnimated:true];
        }
    } fail:^(NSError *error) {
        [JGProgressHUD showErrorWith:[error localizedDescription] In:self.view];
    }];
}

- (void)refreshWithModel:(OneStageScreeningModel *)model{
    FillUserInfoCell *cell;
    
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
    //昵称
    if(indexPath.row == 1){
        NickNameFillInController *nickNameFillInController = [[NickNameFillInController alloc] init];
        nickNameFillInController.nickNameBlock = ^(NSString *nickName){
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = nickName;
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
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = dateStr;
        };
        datePickerView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
        [[[UIApplication sharedApplication] keyWindow] addSubview:datePickerView];
    }
    //身高
    if(indexPath.row == 3){
        HeightPickerView *heightPickerView = [HeightPickerView heightPickerView];
        heightPickerView.heightPickerBlock = ^(NSString *height){
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = height;
        };
        heightPickerView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
        [[[UIApplication sharedApplication] keyWindow] addSubview:heightPickerView];
    }
    //地区
    if(indexPath.row == 4){
        AddressPickerView *addressPickerView = [AddressPickerView addressPickerView];
        addressPickerView.block = ^(NSString *province, NSString *city){
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = [[province stringByAppendingString:@" "] stringByAppendingString:city];
        };
        addressPickerView.frame = CGRectMake(0, 0, kWIDTH, kHEIGHT);
        [[[UIApplication sharedApplication] keyWindow] addSubview:addressPickerView];
    }
    //星座
    if(indexPath.row == 5){
        ConstellationPickerView *constellationPickerView = [ConstellationPickerView constellationPickerView];
        constellationPickerView.constellationPickerBlock = ^(NSString *constellation){
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = constellation;
        };
        [constellationPickerView toShow];
    }
    //体型
    if(indexPath.row == 6){
        BodyShapPickerView *bodyShapPickerView = [BodyShapPickerView bodyShapPickerView];
        bodyShapPickerView.bodyPickerBlock = ^(NSString *bodyShap){
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = bodyShap;
        };
        [bodyShapPickerView toShow];
    }
    //相貌自评
    if(indexPath.row == 7){
        LooksEvaluatePickerView *looksEvaluatePickerView = [LooksEvaluatePickerView looksEvaluatePickerView];
        looksEvaluatePickerView.looksEvaluateBlock = ^(NSString *evaluate){
            FillUserInfoCell *cell = self.cells[indexPath.row-1];
            cell.infoValue = evaluate;
        };
        [looksEvaluatePickerView toShow];
    }
}
@end
