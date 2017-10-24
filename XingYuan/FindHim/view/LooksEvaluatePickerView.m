//
//  LooksEvaluatePickerView.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/14.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "LooksEvaluatePickerView.h"

@interface LooksEvaluatePickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation LooksEvaluatePickerView

+ (instancetype)looksEvaluatePickerView{
    LooksEvaluatePickerView *looksEvaluatePickerView = [[LooksEvaluatePickerView alloc] initWithFrame:SCREEN_RECT];
    return looksEvaluatePickerView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        self.dataArray = @[@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@"10"];
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
    }
    return self;
}

- (void)dealCancel{
    [super dealCancel];
    [self toDismiss];
}

- (void)dealOK{
    [super dealOK];
    self.looksEvaluateBlock(self.dataArray[[self.pickerView selectedRowInComponent:0]]);
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
