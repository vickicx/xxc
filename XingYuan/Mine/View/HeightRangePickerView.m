//
//  HeightRangePickerView.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/31.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "HeightRangePickerView.h"
#import "PickerDatas.h"

@interface HeightRangePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,copy) NSArray *dataArray;
@property (nonatomic,strong) HeightRangeBlock heightRangeBlock;
@end

@implementation HeightRangePickerView

+ (instancetype)pickerViewWithBlock:(HeightRangeBlock)heightBlock{
    
    HeightRangePickerView *heightRangePickerView = [[HeightRangePickerView alloc] initWithFrame:SCREEN_RECT block:heightBlock];
    return heightRangePickerView;
}

- (instancetype)initWithFrame:(CGRect)frame block:(HeightRangeBlock)block{
    self = [super initWithFrame:frame];
    if(self){
        self.heightRangeBlock = block;
        self.dataArray = [PickerDatas heightsRange];
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
    if(self.heightRangeBlock != nil){
        HeightRangeModel *heightRangeModel = self.dataArray[[self.pickerView selectedRowInComponent:0]];
        NSInteger smallValue = heightRangeModel.littleHeight;
        NSNumber *bigNumber = heightRangeModel.biggerHeights[[self.pickerView selectedRowInComponent:1]];
        NSInteger bigValue = [bigNumber integerValue];

        self.heightRangeBlock(smallValue,bigValue);
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
        return  self.dataArray.count;
    }
    if(component == 1){
        HeightRangeModel *heightRangeModel = self.dataArray[[pickerView selectedRowInComponent:0]];
        return heightRangeModel.biggerHeights.count;
    }
    return 0;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    if(component == 0){
        HeightRangeModel *heightRangeModel = self.dataArray[row];
        return [NSString stringWithFormat:@"%lu",heightRangeModel.littleHeight];
    }
    if(component == 1){
        HeightRangeModel *heightRangeModel = self.dataArray[[pickerView selectedRowInComponent:0]];
        return [NSString stringWithFormat:@"%@",heightRangeModel.biggerHeights[row]];
    }
    return @"";
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    if(component == 0){
        [pickerView reloadComponent:1];
    }
}


@end
