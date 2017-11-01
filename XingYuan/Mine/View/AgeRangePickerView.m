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
@property (nonatomic,copy) NSArray *smallDataArray;
@property (nonatomic,copy) NSArray *bigDataArray;
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
        self.smallDataArray = [PickerDatas ages];
        self.bigDataArray = [PickerDatas ages];
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
        NSString *smallStr = self.smallDataArray[[self.pickerView selectedRowInComponent:0]];
        NSString *bigStr = self.smallDataArray[[self.pickerView selectedRowInComponent:1]];
        int smallValue = smallStr.intValue;
        int bigValue = bigStr.intValue;
        if(bigValue <= smallValue){
            [Helper showAlertControllerWithMessage:@"右边的值必须大于左边的值" completion:nil];
        }
        if(bigValue > smallValue){
            if(self.ageRangeBlock != nil){
                self.ageRangeBlock(smallValue,bigValue);
            }
        }
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
        return self.smallDataArray.count;
    }
    if(component == 1){
        return self.bigDataArray.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        return self.smallDataArray[row];
    }
    if(component == 1){
        return self.bigDataArray[row];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}


@end
