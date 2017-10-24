//
//  DataPickerView.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/14.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "DataPickerView.h"

@interface DataPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) NSArray *dataArray;
@property (nonatomic,strong) void(^dataPickerBlock)(NSString *value);
@end

@implementation DataPickerView

+ (instancetype)pickerViewWithDataArray:(NSArray *)dataArray initialSelectRow:(NSInteger)row dataPickerBlock:(void (^)(NSString *value))block{
    DataPickerView *dataPickerView = [[DataPickerView alloc] initWithFrame:SCREEN_RECT dataArray:dataArray dataPickerBlock:block];
    return dataPickerView;
}


- (instancetype)initWithFrame:(CGRect)frame dataArray:(NSArray *)dataArray dataPickerBlock:(void(^)(NSString *))block{
    if([super initWithFrame:frame]){
        self.dataArray = dataArray;
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        self.dataPickerBlock = block;
    }
    return self;
}

- (void)dealCancel{
    [super dealCancel];
    [self toDismiss];
}

- (void)dealOK{
    [super dealOK];
    if(self.dataPickerBlock != nil){
        self.dataPickerBlock(self.dataArray[[self.pickerView selectedRowInComponent:0]]);
    }
    [self toDismiss];
}

- (void)toDismiss{
    [self removeFromSuperview];
}

- (void)toShow{
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
}

- (void)dealloc{
    
}

#pragma mark --UIPickerViewDelegate,UIPickerViewDataSource
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return self.dataArray.count;
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return self.dataArray[row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
}

@end
