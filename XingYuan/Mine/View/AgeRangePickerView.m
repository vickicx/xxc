//
//  AgeRangePickerView.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/31.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "AgeRangePickerView.h"
#import "PickerDatas.h"

@interface AgeRangePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,copy) NSArray *dataArray;
@property (nonatomic,strong) AgeRangeBlock ageRangeBlock;
@end
@implementation AgeRangePickerView

+ (instancetype)pickerViewWithBlock:(AgeRangeBlock)ageBlock{
    AgeRangePickerView *ageRangePickerView = [[AgeRangePickerView alloc] initWithFrame:SCREEN_RECT block:ageBlock];
    return ageRangePickerView;
}

- (instancetype)initWithFrame:(CGRect)frame block:(AgeRangeBlock)block{
    self = [super initWithFrame:frame];
    if(self){
        self.ageRangeBlock = block;
        self.dataArray = [PickerDatas ageRanges];
        UIPickerView *pickerView = [[UIPickerView alloc] init];
        pickerView.delegate = self;
        pickerView.dataSource = self;
        [self.pickerContainView addSubview:pickerView];
        [pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.pickerContainView);
            make.right.equalTo(self.pickerContainView);
            make.bottom.equalTo(self.pickerContainView);
            make.top.equalTo(self.pickerContainView);
        }];
        self.pickerView = pickerView;
    }
    return self;
}

#pragma mark - misc

- (void)dealCancel{
    [super dealCancel];
    [self toDismiss];
}

- (void)dealOK{
    [super dealOK];
    if(self.ageRangeBlock != nil){
        AgeRangeModel *ageRangeModel = self.dataArray[[self.pickerView selectedRowInComponent:0]];
        NSInteger smallValue = ageRangeModel.littleAge;
        NSNumber *bigNumber = ageRangeModel.biggeraAges[[self.pickerView selectedRowInComponent:1]];
        NSInteger bigValue = [bigNumber integerValue];
        self.ageRangeBlock(smallValue,bigValue);
    }
    [self toDismiss];
}

- (void)toDismiss{
    [self removeFromSuperview];
}

- (void)toShow{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

#pragma mark --UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 2;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    if(component == 0){
        return self.dataArray.count;
    }
    if(component == 1){
        AgeRangeModel *ageRangeModel = self.dataArray[[pickerView selectedRowInComponent:0]];
        return ageRangeModel.biggeraAges.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        AgeRangeModel *ageRangeModel = self.dataArray[row];
        return [NSString stringWithFormat:@"%lu",ageRangeModel.littleAge];
    }
    if(component == 1){
        AgeRangeModel *ageRangeModel = self.dataArray[[pickerView selectedRowInComponent:0]];
        return [NSString stringWithFormat:@"%@",ageRangeModel.biggeraAges[row]];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0){
        [pickerView reloadComponent:1];
    }
}


@end
