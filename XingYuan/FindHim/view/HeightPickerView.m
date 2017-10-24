//
//  HeightPickerView.m
//  XingYuan
//
//  Created by YunKuai on 2017/10/14.
//  Copyright © 2017年 Vicki. All rights reserved.
//

#import "HeightPickerView.h"

@interface HeightPickerView ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (nonatomic,strong) NSArray *dataArray;
@end

@implementation HeightPickerView

+ (instancetype)heightPickerView{
    HeightPickerView *heightPickerView = [[HeightPickerView alloc] initWithFrame:SCREEN_RECT];
    return heightPickerView;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if([super initWithFrame:frame]){
        NSMutableArray *dataArray = [NSMutableArray new];
        [dataArray addObject:@"140以下"];
        for (int i=140;i<=230;i++){
            [dataArray addObject:[NSString stringWithFormat:@"%d",i]];
        }
        [dataArray addObject:@"230以上"];
        self.dataArray = dataArray;
        
        self.pickerView.delegate = self;
        self.pickerView.dataSource = self;
        [self.pickerView selectRow:170 inComponent:0 animated:false];
        [self.pickerView reloadAllComponents];
    }
    return self;
}

- (void)dealCancel{
    [super dealCancel];
    [self toDismiss];
}

- (void)dealOK{
    [super dealOK];
    self.heightPickerBlock(self.dataArray[[self.pickerView selectedRowInComponent:0]]);
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
